#!/usr/bin/env python
#-*- coding:utf-8 -*-

import json
import sys
import os
import string
import commands
import argparse
import time
import fcntl
import re 
import traceback
#from pip._vendor.requests.models import CONTENT_CHUNK_SIZE
from oslo_log import log

import xml.etree.cElementTree as ElementTree
#import json

#add by jian on 2016/06/14 for convert XML to JSON
def get_attrib(node):
    if node.attrib and 'id' in node.attrib.keys():
        return node.attrib['id']
    else:
        return ''
    
class XmlListConfig(list):
    def __init__(self, aList):
        for element in aList:
            if element:
                if len(element) == 1 or \
                    (element[0].tag != element[1].tag):
                    self.append(XmlDictConfig(element))
                elif element[0].tag == element[1].tag and get_attrib(element[0]) == get_attrib(element[1]):
                    self.append(XmlListConfig(element))
            elif element.text:
                text = element.text.strip()
                if text:
                    self.append(text)


class XmlDictConfig(dict):
    '''
    Example usage:

    >>> tree = ElementTree.parse('your_file.xml')
    >>> root = tree.getroot()
    >>> xmldict = XmlDictConfig(root)

    Or, if you want to use an XML string:

    >>> root = ElementTree.XML(xml_string)
    >>> xmldict = XmlDictConfig(root)

    And then use xmldict for what it is... a dict.
    '''
    def __init__(self, parent_element):
#        if parent_element.items():
#            self.update(dict(parent_element.items()))
        for element in parent_element:
            if element:
                if len(element) == 1 or (element[0].tag != element[1].tag):
                    aDict = XmlDictConfig(element)
                else:
                    aDict = {element[0].tag + get_attrib(element[0]): XmlListConfig(element)}
#                if element.items():
#                    aDict.update(dict(element.items()))
                self.update({element.tag + get_attrib(element): aDict})
#            elif element.items():
#                self.update({element.tag + get_attrib(element): dict(element.items())})
            else:
                self.update({element.tag + get_attrib(element): element.text})
                
        

#added the period of using GPU by Jian on 2016/05/23
DEFAULT_LIFE = 365 * 24 * 60 * 60
MAX_USER_COUNT = 9999
DEV_TYPE = "gpu_pcie"
DEV_BOARD = "gpu_nvidia"
DEV_GPU_PATH = r"/dev"
DB_PATH = r"/var/lib/gpu"
LOCK_FILE_PATH = os.path.join(DB_PATH, "gpu_locked.txt")
QUEUE_FILE_PATH = os.path.join(DB_PATH, "gpu_queue.txt")
RESULT_FILE_PATH = os.path.join(DB_PATH, "gpu_result.txt")

DOCKER_CGROUP_SEARCH_PATH = ["/sys/fs/cgroup/devices/system.slice/docker-%s.scope",
                        "/sys/fs/cgroup/devices/docker/%s"]

LOG = log.getLogger(__name__)

def docker_gpu_device(dockerID, gpuName, allow):
    cgroupPath = None
    for dockerPath in DOCKER_CGROUP_SEARCH_PATH:
#        if os.path.exists(os.path.split( dockerPath)[0]):
#            LOG.info("all sub folders:%s" % os.listdir(os.path.split(dockerPath)[0]))
        tmp = dockerPath % dockerID
        LOG.info("cgroup path:%s" % tmp)
        if os.path.exists(tmp):
            cgroupPath = tmp
            break
    if not cgroupPath:
        LOG.info(">\tDocker name:%s, cgroup path not exist!" % dockerID)
        return False
    gpuLinuxIDs = os.popen("ls /dev/%s* -l | awk '{print $5 $6}' | sed 's/,/:/g'" % gpuName).read().rstrip().split()
    LOG.info(">\tGet GPU IDs:%s" % gpuLinuxIDs)
    for gpuLinuxID in gpuLinuxIDs:
        if allow:
            LOG.info(">\tExecute command: sudo sh -c 'echo c %s rwm > %s/devices.allow'" % (gpuLinuxID, cgroupPath))
            os.system("sudo sh -c 'echo c %s rwm > %s/devices.allow'" % (gpuLinuxID, cgroupPath))
        else:
            LOG.info(">\tExecute command: sudo sh -c 'echo c %s rwm > %s/devices.deny'" % (gpuLinuxID, cgroupPath))
            os.system("sudo sh -c 'echo c %s rwm > %s/devices.deny'" % (gpuLinuxID, cgroupPath))
    return True

def update_gpu_db(records=None):
    newRecords = {}
    for gpu in records.keys():
        usable = MAX_USER_COUNT
        newRecords[gpu] = {"available_count" : usable}
        for dockerID, v in records[gpu].items():
            if dockerID == "available_count":
                continue
            endTime = v[1]
            endStamp = time.mktime(time.strptime(endTime, '%Y-%m-%d-%H-%M-%S'))
            nowStamp = time.time()
            if endStamp > nowStamp:
                if newRecords[gpu]["available_count"] > 0:
                    newRecords[gpu][dockerID] = v
                    newRecords[gpu]["available_count"] -= 1
                    docker_gpu_device(dockerID, gpu, True)
                else:
                    print "Deny!, the num of GPU_user have reached the MAX:%d" % MAX_USER_COUNT
            else:
                docker_gpu_device(dockerID, gpu, False)
    print "Updated newRecords:%s" % newRecords
    return newRecords

def report_gpu_resource():
    if not os.path.exists(DEV_GPU_PATH):
        print "GPU path:%s was not exist! please check it." % DEV_GPU_PATH
        return None
    gpuNodeList = []
    for node in (os.listdir(DEV_GPU_PATH)):
        if re.findall("^nvidia\d+", node, re.IGNORECASE):
            gpuNodeList.append(node)
            print "find GPU:", node
            
    gpuNodeList = list(set(gpuNodeList))
    if len(gpuNodeList) == 0:
        print "GPU devices were None."
        return None
    if os.path.exists(LOCK_FILE_PATH):
        lockedFile = open(LOCK_FILE_PATH, "r+")
        fcntl.flock(lockedFile, fcntl.LOCK_EX)
        try:
            content = lockedFile.read().strip("\n")
            content = "".join(content.split())
            print "content:%s" % content
            newRecords = {}
            if content:
                try:
                    records = json.loads(content)
                except Exception, e:
                    print "Can not read %s as json format, error:%s" % (LOCK_FILE_PATH, e.__str__())
                    traceback.print_exc()
                    return None
                newRecords = update_gpu_db(records)
                
                if (len(newRecords) != len(records)) and len(newRecords) > 0 :
                    newText = json.dumps(newRecords)
                    lockedFile.truncate(0)
                    lockedFile.seek(0)
                    lockedFile.write(newText)
                else:
                    print "%s, No changed" % LOCK_FILE_PATH
                    
        finally :
            fcntl.flock(lockedFile,fcntl.LOCK_UN)
            lockedFile.close()
                
        gpuValDict = {}
        for gpu in gpuNodeList:
            if newRecords.has_key(gpu) and newRecords[gpu]["available_count"] < 1:
                waitting_sec = DEFAULT_LIFE
                for dockerID in newRecords[gpu].keys():
                    if dockerID == "available_count":
                        continue
                    endTime = newRecords[gpu][dockerID][1]
                    endStamp = time.mktime(time.strptime(endTime,'%Y-%m-%d-%H-%M-%S'))
                    nowStamp = time.time()
                    sec = int(endStamp - nowStamp)
                    if sec < waitting_sec:
                        waitting_sec = sec
                gpuValDict[gpu] = (DEV_BOARD, waitting_sec)
            else :
                gpuValDict[gpu] = (DEV_BOARD, 0)
                
                
        #add GPU utilization, and convert XML to JSON
        xmlStr = os.popen("nvidia-smi -q -x").read()
        root = ElementTree.XML(xmlStr)
        xmldict = XmlDictConfig(root)
        print "Jian>>> json string:"
        print {DEV_TYPE : gpuValDict, "gpu_monitor" : xmldict}
        return {DEV_TYPE : gpuValDict, "gpu_monitor" : xmldict}
    else:
        print "%s was not exist! please check..." % LOCK_FILE_PATH
        return None
    
def add_gpu_entry(dockerName, gpu, life=None):
    if os.path.exists(LOCK_FILE_PATH):
        lockedFile = open(LOCK_FILE_PATH, 'r+')
    else:
        if not os.path.exists(DB_PATH):
            os.mkdir(DB_PATH)
        lockedFile = open(LOCK_FILE_PATH, 'w+')
    fcntl.flock(lockedFile, fcntl.LOCK_EX)
    try:
        conflict = False
        text = lockedFile.read().strip("\n")
        if len(text) > 0:
            try:
                records = json.loads(text)
            except Exception, e:
                print "can not read %s, as Json format" % LOCK_FILE_PATH
#                 traceback.print_exc()
                return None
            newRecords = update_gpu_db(records)
            if newRecords.has_key(gpu):
                if newRecords[gpu].has_key("available_count") and newRecords[gpu]["available_count"] < 1:
                    conflict = True
                if dockerName in newRecords[gpu].keys():
                    conflict = True
                    print "The docker:%s already running in GPU:%s" % (dockerName, gpu)
        else:
            newRecords = {}
        if not conflict:
            print "not conflict"
            startTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            if life is None:
                endTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + DEFAULT_LIFE))
            else:
                endTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + life))
            if gpu not in newRecords.keys():
                newRecords[gpu] = {}
            newRecords[gpu].update({dockerName : [startTime, endTime]})
            if "available_count" in newRecords[gpu].keys():
                newRecords[gpu]["available_count"] -= 1
            else:
                newRecords[gpu]["available_count"] = MAX_USER_COUNT - 1
            
            newText = json.dumps(newRecords)
            lockedFile.truncate(0)
            lockedFile.seek(0)
            lockedFile.write(newText)
    finally :
        fcntl.flock(lockedFile,fcntl.LOCK_UN)
        lockedFile.close()
        
    return not conflict
    

def get_file_object(filePath):
    if os.path.exists(filePath):
        lockedFile = open(filePath, 'r+')
    else:
        if not os.path.exists(DB_PATH):
            os.mkdir(DB_PATH)
        lockedFile = open(filePath, 'w+')
    return lockedFile

def return_idle_gpu(dockerName, gpuNodeList, life=None, cgroupControl=False):
    idleGpu = None
    lockedFile = get_file_object(LOCK_FILE_PATH)
    fcntl.flock(lockedFile, fcntl.LOCK_EX)
    try:
        text = "".join(lockedFile.read().split())
        if len(text) > 0:
            try:
                records = json.loads(text)
            except Exception, e:
                print "can not read %s, as Json format, error:%s " % (LOCK_FILE_PATH, e.__str__())
                traceback.print_exc()
                return None
            newRecords = update_gpu_db(records)
        else:
            newRecords = {}
            
        print "newRecords:", newRecords
        #sorted GPU list by "available_count", low to top
        sort_newRecords = sorted(newRecords.items(), key = lambda e:e[1]["available_count"], reverse=True)
        sort_gpuNodeList = []
        for a_tuple in sort_newRecords:
            if a_tuple[0] in gpuNodeList:
                sort_gpuNodeList.append(a_tuple[0])
        for gpuNode in gpuNodeList:
            if gpuNode not in sort_gpuNodeList:
                sort_gpuNodeList.insert(0, gpuNode)
        LOG.info("Sorted GPU list:%s" % sort_gpuNodeList)

        for gpu in sort_gpuNodeList:
            if gpu not in newRecords.keys():
                idleGpu = gpu
                LOG.info("find an idleGpu:%s" % gpu)
                break
            else:
                if dockerName not in newRecords[gpu].keys() and \
                   (newRecords[gpu].has_key("available_count") and newRecords[gpu]["available_count"]) > 0:
                    idleGpu = gpu
                    LOG.info("find an usable GPU:%s, the available count is:%s" % (gpu, newRecords[gpu]["available_count"]))
                    break
        else:
            LOG.info("can not find an idle gpu...")
            return None
        if (idleGpu and (not cgroupControl))  or (docker_gpu_device(dockerName, idleGpu,True)):
            startTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            if life is None:
                endTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + DEFAULT_LIFE))
            else:
                endTime = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + life))
            if idleGpu not in newRecords.keys():
                newRecords[idleGpu] = {}
            newRecords[idleGpu].update({dockerName : [startTime, endTime]})
#             print "jian: newRecords:", newRecords
            if "available_count" in newRecords[idleGpu].keys():
                newRecords[idleGpu]["available_count"] -= 1
            else:
                newRecords[idleGpu]["available_count"] = MAX_USER_COUNT - 1
            LOG.info("jian: newRecords:%s" % newRecords)
            newText = json.dumps(newRecords)
            lockedFile.truncate(0)
            lockedFile.seek(0)
            lockedFile.write(newText)
            print "finally, return an idle GPU:%s" % idleGpu
        else:
            print "can not find any idle GPU!"
    finally :
        fcntl.flock(lockedFile,fcntl.LOCK_UN)
        lockedFile.close()
    return idleGpu


def find_add_entry(dockerName, life=None, cgroupControl=False, gpu_num=1):
    if cgroupControl:
        cgroupPath = None
        for path in DOCKER_CGROUP_SEARCH_PATH:
            if os.path.exists(path % dockerName):
                cgroupPath = path % dockerName
                break
        else:
            print "can not find %s in search path:%s" % (dockerName, DOCKER_CGROUP_SEARCH_PATH)
            return None
        
    if not os.path.exists(DEV_GPU_PATH):
        print "can not find: ", DEV_GPU_PATH
        return None
    
    gpuNodeList = []
    for node in (os.listdir(DEV_GPU_PATH)):
        if re.findall("^nvidia\d+", node, re.IGNORECASE):
            gpuNodeList.append(node)
            
    gpuNodeList = list(set(gpuNodeList))
    if not gpuNodeList:
        print "can find any GPU devices"
        return None
    
    if gpu_num > len(gpuNodeList):
        gpu_num = len(gpuNodeList)
        LOG.info("Warning! the gpu_num is too large, auto set the number of host gpu!")
    elif gpu_num <= 0:
        gpu_num = 1
        LOG.info("Warning! the gpu_num can not be 0/-1/...! auto reset the value of gpu_num 1")
    idleGpuList = []
    for i in range(gpu_num):
        idleGpu = return_idle_gpu(dockerName, gpuNodeList, life, cgroupControl)
        if idleGpu is not None:
            idleGpuList.append(idleGpu)
    
    return idleGpuList

def try_find_idle_gpu():
    gpuNodeList = []
    for node in (os.listdir(DEV_GPU_PATH)):
        if re.findall("^nvidia\d+", node, re.IGNORECASE):
            gpuNodeList.append(node)
            
    gpuNodeList = list(set(gpuNodeList))
    if not gpuNodeList:
        print "can find GPU devices"
        return None
    idleGpuList = []
    if os.path.exists(LOCK_FILE_PATH):
        lockedFile = open(LOCK_FILE_PATH, "r+")
        text = "".join(lockedFile.read().split())
        if len(text) > 0:
            try:
                records = json.loads(text)
            except Exception, e:
                pass
                return None
            newRecords = update_gpu_db(records)
        else:
            newRecords = {}
        for gpu in gpuNodeList:
            if gpu not in newRecords.keys():
                idleGpuList.append(gpu)
            else:
                if "available_count" in newRecords[gpu].keys() and newRecords[gpu]["available_count"] > 0:
                    idleGpuList.append(gpu)
                    
                
    print "All GPU devices list", gpuNodeList
    print "Idle GPU devices list", idleGpuList
    return gpuNodeList, idleGpuList
    
def add_to_queue(instanceID):
    queueFile = get_file_object(QUEUE_FILE_PATH)
    idleGpu = None
    fcntl.flock(queueFile, fcntl.LOCK_EX)
    idleGpu = None
    try:
        gpuList, idleGpuList = try_find_idle_gpu()
        text = "".join(queueFile.read().split())
        if len(text) > 0:
            try:
                queues = json.loads(text)
            except Exception, e:
                traceback.print_exc()
                return None
        else:
            queues = {}
            
        minQueueLen = 99999
        for gpu in gpuList:
            if gpu not in queues.keys():
                idleGpu = gpu
                queues[idleGpu] = []
                break
            else:
                print "!!!GPU length:%d, minimum queue length:%d" % (len(queues[gpu]), minQueueLen)
                if len(queues[gpu]) < minQueueLen:
                    minQueueLen = len(queues[gpu])
                    idleGpu = gpu
                    
        if idleGpu:
            queues[idleGpu].append(["", instanceID, "", "Waiting", 75])# set timeout as 75*4 seconds
            print "Add job in %s to accelerator %s" % (instanceID, idleGpu)
        else:
            print "!!! No GPU equipment is available, full load..."
        if len(queues) > 0:
            queueFile.truncate(0)
            queueFile.seek(0)
            queueFile.write(json.dumps(queues))
    finally:
        fcntl.flock(queueFile,fcntl.LOCK_UN)
        queueFile.close()
    print "!!!Return idle GPU:", idleGpu
    return idleGpu

def remove_entry(dockerName, checkQueue=False):#for GPU, no need to change queue file
    #changed locked file
    LOG.info("remove entry >> docker name:%s" % dockerName)
    if os.path.exists(LOCK_FILE_PATH):
        lockedFile = open(LOCK_FILE_PATH, "r+")
        fcntl.flock(lockedFile, fcntl.LOCK_EX)
        try:
            resultRecords = {}
            text = "".join(lockedFile.read().strip("\n").split())
            print "remove gpu, text:%s" % text
            if len(text) > 0:
                try:
                    records = json.loads(text)
                except Exception, e:
                    print "read %s as JSON format failed!" % LOCK_FILE_PATH
                    return None
                    pass
                newRecords = update_gpu_db(records)
                for gpu in newRecords.keys():
                    resultRecords[gpu] = {}
                    for dockerID, v in newRecords[gpu].items():
                        if dockerID != dockerName:
                            resultRecords[gpu][dockerID] = v 
                    resultRecords[gpu]["available_count"] = MAX_USER_COUNT - (len(resultRecords[gpu]) - 1)
            print "resultRecords:%s" % resultRecords
            if len(resultRecords) > 0:
                newText = json.dumps(resultRecords)
                lockedFile.truncate(0)
                lockedFile.seek(0)
                lockedFile.write(newText)
            else:
                lockedFile.truncate(0)
                lockedFile.seek(0)
                lockedFile.write("")
        finally:
            fcntl.flock(lockedFile,fcntl.LOCK_UN)
            lockedFile.close()
    #changed queue file
    # One job is described as [docker id, instance id, instance ip, status]
#    if checkQueue:
#        job_action("remove", dockerName)
#        if os.path.exists(QUEUE_FILE_PATH):
#            queueFile = open(QUEUE_FILE_PATH, "r+")
#            fcntl.flock(queueFile, fcntl.LOCK_EX)
#            try:
#                text = "".join(queueFile.read().strip("\n").split())
#                if len(text) > 0:
#                    try:
#                        queues = json.loads(text)
#                    except Exception, e:
#                        return None
#                        pass
#                    findGpu = None
#                    for gpu, queue in queues.items():
#                        for job in queue:
#                            if job[0] == dockerName or job[1] == dockerName:
#                                findGpu = gpu
#                                break
#                        if findGpu:
#                            break
#                    if findGpu:
#                        indexID = queues[findGpu].index(job)
#                        del queues[findGpu][indexID]
#                        print "queues:%s===" % queues
#                        if len(queues) > 0:
#                            newText = json.dumps(queues)
#                            queueFile.truncate(0)
#                            queueFile.seek(0)
#                            queueFile.write(newText)
#                        else:
#                            queueFile.write("")
#            finally :
#                fcntl.flock(queueFile, fcntl.LOCK_UN)
#                queueFile.close()
#                
def change_entry(dockerName=None, newName=None, newLife=None):
    #changed locked file
    #changed novadocker name into docker name
    if os.path.exists(LOCK_FILE_PATH):
        with open(LOCK_FILE_PATH, "r+") as fh:
            fcntl.flock(fh, fcntl.LOCK_EX)
            try:
                text = "".join(fh.read().split())
                if len(text) > 0:
                    try:
                        records = json.loads(text)
                    except Exception, e:
                        traceback.print_exc()
                        return None
                    newRecords = update_gpu_db(records)
                    findFlag = False
                    for gpu in newRecords.keys():
                        del_list = []
                        for dockerID, v in newRecords[gpu].items():
                            if dockerID == dockerName:
                                findFlag = True
                                if newLife:
                                    endTime = v[1]
                                    endStamp = time.mktime(time.strptime(endTime, '%Y-%m-%d-%H-%M-%S'))
                                    newRecords[gpu][dockerID][1] = time.strftime('%Y-%m-%d-%H-%M-%S', time.localtime(endStamp + newLife))
                                    print "Already added new-life %s to novadocker: %s" % (newLife, dockerName)
                                if newName:
                                    newRecords[gpu][newName] = newRecords[gpu][dockerID]
                                    del_list.append(dockerID)
                                    print "Changed novadocker:%s to docker:%s" % (dockerName, newName)
                        for old_docker in del_list:
                            del newRecords[gpu][old_docker]
                            print ">>> delete old novadocker:%s" % old_docker
                            LOG.info(">>> delete old novadocker:%s" % old_docker)
                    if findFlag:
                        newText = json.dumps(newRecords)
                        fh.truncate(0)
                        fh.seek(0)
                        fh.write(newText)
                    else:
                        print "changed failed, for can not find any corresponding novadocker: ", dockerName
                        LOG.info("changed failed, for can not find any corresponding novadocker: ", dockerName)
                else:
                    print "changed novadocker: %s failed, for %s content is empty!" % (dockerName, LOCK_FILE_PATH)
                    LOG.info("changed novadocker: %s failed, for %s content is empty!" % (dockerName, LOCK_FILE_PATH))
            finally:
                fcntl.flock(fh, fcntl.LOCK_UN)
    else:
        print "changed docker into locked file: %s failed, for %s is not exist!" % (dockerName, LOCK_FILE_PATH)
        LOG.info("changed docker into locked file: %s failed, for %s is not exist!" % (dockerName, LOCK_FILE_PATH))
    #changed queue file
    # One job is described as [docker id, instance id, instance ip, status]
#for GPU, do not need queue 2016/05/23
#     if os.path.exists(QUEUE_FILE_PATH):
#         with open(QUEUE_FILE_PATH, "r+") as fh:
#             fcntl.flock(fh, fcntl.LOCK_EX)
#             try:
#                 text = fh.read()
#                 if len(text) > 0:
#                     try:
#                         queues = json.loads(text)
#                     except Exception, e:
#                         return None
#                         pass
#                     for gpu, queue in queues.items():
#                         for job in queue:
#                             if job[1] == dockerName:
#                                 indexID = queues[gpu].index(job)
#                                 queues[gpu][indexID][0] = newName
#                                 break
#                     if len(queues) > 0:
#                         newText = json.dumps(queues)
#                         fh.truncate(0)
#                         fh.seek(0)
#                         fh.write(newText)
#                     
#             finally :
#                 fcntl.flock(fh, fcntl.LOCK_UN)
#                 fh.close()
#     else:
#         print "changed docker into queue file: %s failed, for %s is not exist!" % (dockerName, QUEUE_FILE_PATH)
        
def text_to_iterate(fileObject):
    text = "".join(fileObject.read().split())
    if len(text) > 0:
        try:
            records = json.loads(text)
        except Exception, e:
            print ""
            return []
        return records
    else:
        return []
    
def job_action(action=None, dockerID=None, instanceID=None, status=None):
    # One job is described as [docker id, instance id, instance ip, status]
    if os.path.exists(RESULT_FILE_PATH):
        if action == "status":
            with open(RESULT_FILE_PATH, "r") as fh:
                records = text_to_iterate(fh)
            for record in records:
                if instanceID == record[1]:
                    return record[2]
            return None
        resultFile = open(RESULT_FILE_PATH, "r+")
    else:
        if action == "status" or action == "remove":
            print "%s is not exist, return None..." % RESULT_FILE_PATH
            return None
        elif action == "add" :
            if not os.path.exists(DB_PATH) :
                os.makedirs(DB_PATH)
            resultFile = open(RESULT_FILE_PATH, 'w+')
            
    fcntl.flock (resultFile, fcntl.LOCK_EX)
    try:
        change = False
        records = text_to_iterate(resultFile)
        print "!!!old result list:", records
        if action == "add":
            timeStamp = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            records.append([dockerID, instanceID, status, timeStamp])
            change = True
        elif action == "remove":
            for record in records :
                if record[0] == dockerID or record[1] == dockerID:
                    change = True
                    del records[records.index(record)]
                    break
        print "!!!new result list", records
        if change and len(records) > 0:
            newText = json.dumps(records)
            resultFile.truncate(0)
            resultFile.seek(0)
            resultFile.write(newText)
    finally :
        fcntl.flock(resultFile,fcntl.LOCK_UN)
        resultFile.close()
        
#if __name__ == '__main__':
#     report_gpu_resource()
#     dockerName = "TestGpu0"
#     gpu = "nvidia0"
#     life = 600
#     dockerName1 = "TestGpu4"
#     gpu1 = "nvidia1"
# #     life1 = 600
# #     print "=====add gpu entry ==========="
# #     print add_gpu_entry(dockerName, gpu, life)
# #     print add_gpu_entry(dockerName1, gpu1)
#     print "=======find an idle gpu=========="
#     find_add_entry(dockerName, life, cgroupControl=False)
#     print "=====report gpu resource========="
#     print report_gpu_resource()
# #     print "======remove gpu entry ========="
# #     remove_entry(dockerName, checkQueue=False)
#     print "========change gpu entry ========"
#     change_entry(dockerName, newName="TestGpu_jian", newLife=3*600)
#     print "=======job action==========="
#     job_action("add", dockerName, instanceID="201605231445", status="active")
#     print "========docker_gpu_device============"
#     try_find_idle_gpu()
#     docker_gpu_device(dockerName, gpu, True)
#     docker_gpu_device(dockerName, gpu, False)
    
    
