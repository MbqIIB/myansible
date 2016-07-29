
import json
import sys
import os
import string
import commands
import argparse
import time
import fcntl

capi_dev_board = "Alphadata-KU3"
capi_dev_path = r"/dev/cxl/"
capi_db_path = "/var/lib/capi"
lock_file_path = capi_db_path + "/capi_locked"
history_file_path = capi_db_path + "/capi_history"
#CC
containers_info_file_path = capi_db_path + "/capi_containers_info"
docker_cgroup_search_path = ["/sys/fs/cgroup/devices/system.slice/docker-%s.scope",
                        "/sys/fs/cgroup/devices/docker/%s"]

#CC
def get_capi_status(container_id):
    if not os.path.exists(capi_dev_path) :
        return "error"

    l = os.listdir (capi_dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('.')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return "error"

    status = ""
    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r')
        info_file = open(containers_info_file_path, 'r')

        try :
            text = locked_file.read()
            if len(text) > 0 :
                records = json.loads(text)
            info_text = info_file.read()
            if len(info_text) > 0:
                containers_info = json.loads(info_text)

            if containers_info.has_key(container_id):
                target_afu = containers_info[container_id].get("afu")
                if records.has_key(target_afu):
                    if records[target_afu][0] == container_id:
                        status = "attached"
                    else:
                        status = "busy"
                else:
                    status = "expired"
            else:
                status = "expired"

        except Exception, e:
            status = "error"
        finally :
            locked_file.close()
            info_file.close()

    return status


def report_capi_resource ():
    if not os.path.exists(capi_dev_path) :
        return None

    l = os.listdir (capi_dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('.')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return None

    new_records = {}
    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')

        ## LOCK the file
        fcntl.flock (locked_file, fcntl.LOCK_EX)
        try :
            text = locked_file.read()
            if len(text) > 0 :
                try :
                    records = json.loads(text)
                except Exception, e :
                    print "Can not read file as json format"
    
                new_records = update_capi_db (records)
                if len (new_records) != len (records) :
                    new_text = json.dumps(new_records)
                    locked_file.truncate(0)
                    locked_file.seek(0)
                    locked_file.write(new_text)
        finally :
            fcntl.flock(locked_file,fcntl.LOCK_UN)
            locked_file.close()

    afu_val_list = {}
    for afu in afu_list :
        if new_records.has_key(afu) :
            end_time = new_records [afu][2]
            end_stamp = time.mktime(time.strptime(end_time,'%Y-%m-%d-%H-%M-%S'))
            now_stamp = time.time()
            afu_val_list [afu] = (capi_dev_board, int(end_stamp - now_stamp))
        else :
            afu_val_list [afu] = (capi_dev_board, 0)

    return {"fpga_capi":afu_val_list}


def docker_capi_device (docker_id, afu, allow) :
    cgroup_path = None
    for path in docker_cgroup_search_path :
        if os.path.exists(path % docker_id) :
            cgroup_path = path % docker_id
            break

    if allow and not cgroup_path :
        return False

    afu_linux_id = os.popen("ls %s/%s* -l | awk '{print $5 $6}' | sed 's/,/:/g'" % (capi_dev_path, afu)).read().rstrip()
    
    if cgroup_path and allow :
        os.system("sudo sh -c 'echo c %s rwm > %s/devices.allow'" % (afu_linux_id, cgroup_path))
    elif cgroup_path and not allow :
        os.system("sudo sh -c 'echo c %s rwm > %s/devices.deny'" % (afu_linux_id, cgroup_path))

    return True


def update_capi_db (records = None):
    new_records = {}
    for k,v in records.items() :
        end_time = v [2]
        end_stamp = time.mktime(time.strptime(end_time,'%Y-%m-%d-%H-%M-%S'))
        now_stamp = time.time()
        if end_stamp > now_stamp :
            new_records [k] = v
            docker_capi_device (v [0], k, True)
        else :
            docker_capi_device (v [0], k, False)

    return new_records


def afu_match_history_uuid (afu, acc_uuid):

    history_afu = None
    if acc_uuid and os.path.exists(history_file_path) :
        history_file = open(history_file_path, 'r')
        text = history_file.read()
        if len (text) > 0 :
            try :
                history_afu = json.loads(text)
            except Exception, e :
                print "Can not read file %s as json format" % history_file_path
        history_file.close()

    if not history_afu :
        return False

    if acc_uuid == history_afu.get (afu) :
        return True
    else :
        return False

def update_afu_history (afu, acc_uuid):

    history_afu = None
    if os.path.exists(history_file_path) :
        history_file = open(history_file_path, 'r+')
    else :
        history_file = open(history_file_path, 'w+')

    text = history_file.read()
    if len (text) > 0 :
        try :
            history_afu = json.loads(text)
        except Exception, e :
            print "Can not read file %s as json format" % history_file_path

    if not history_afu :
        history_afu = {}

    history_afu [afu] = acc_uuid
    text = json.dumps(history_afu)
    history_file.truncate(0)
    history_file.seek(0)
    history_file.write(text)
    history_file.close()


#CC
def update_container_info(container_id, afu, acc_uuid):
    containers_info = None
    if os.path.exists(containers_info_file_path):
        info_file = open(containers_info_file_path, 'r+')
    else:
        info_file = open(containers_info_file_path, 'w+')

    text = info_file.read()
    if len(text) > 0:
        try:
            containers_info = json.loads(text)
        except Exception, e:
            print "Can not read file %s as json format" % containers_info_file_path

    if not containers_info:
        containers_info = {}

    containers_info[container_id] = {"afu": afu, "acc_id": acc_uuid}
    text = json.dumps(containers_info)
    info_file.truncate(0)
    info_file.seek(0)
    info_file.write(text)
    info_file.close()

#CC
def get_container_info(container_id):
    containers_info = None
    if not os.path.exists(containers_info_file_path):
        return None
    else:
        info_file = open(containers_info_file_path, 'r')
        text = info_file.read()
        info_file.close()
        if len(text) > 0:
            try:
                containers_info = json.loads(text)
            except Exception, e:
                print "Can not read file %s as json format" % containers_info_file_path
                return None
            if containers_info.has_key(container_id):
                return containers_info[container_id]
            else:
                print "Can not find container info of %s" % container_id
        return None

#CC
def remove_container_info(container_id):
    containers_info = None
    if not os.path.exists(containers_info_file_path):
        return
    else:
        info_file = open(containers_info_file_path, 'r+')
        text = info_file.read()
        if len(text) > 0:
            try:
                containers_info = json.loads(text)
                containers_info.pop(container_id)
            except Exception, e:
                info_file.close()
                return

            new_text = json.dumps(containers_info)
            info_file.truncate(0)
            info_file.seek(0)
            info_file.write(new_text)
            info_file.close()
        return

#CC
def reserve_one_afu():
    if not os.path.exists(capi_dev_path) :
        print "capi_dev_path does not exists"
        return None

    l = os.listdir (capi_dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('.')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return None

    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')
    else :
        return None

    target_afu = None
    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read %s as json format" % lock_file_path

            new_records = update_capi_db (records)
        else :
            new_records = {}

        # find target_afu
        if len(new_records) < len(afu_list):
            target_afu = None
        else:
            nearest_stamp = time.mktime(time.strptime("31 Dec 2199", "%d %b %Y"))
            for k,v in new_records.items():
                end_time = v[2]
                end_stamp = time.mktime(time.strptime(end_time,'%Y-%m-%d-%H-%M-%S'))
                if end_stamp < nearest_stamp:
                    nearest_stamp = end_stamp
                    target_afu = k

        # free target_afu
        docker_capi_device (new_records.get(target_afu)[0], target_afu, False)
        new_records.pop(target_afu)

        new_text = json.dumps(new_records)
        locked_file.truncate(0)
        locked_file.seek(0)
        locked_file.write(new_text)
    finally :
        fcntl.flock(locked_file,fcntl.LOCK_UN)
        locked_file.close()
        return target_afu


def add_entry (docker_name, afu, life):

    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')
    else :
        if not os.path.exists(capi_db_path) :
            os.makedirs(capi_db_path)

        locked_file = open(lock_file_path, 'w+')

    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        conflict = False
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read file as json format"

            new_records = update_capi_db (records)
            if new_records.has_key (afu) :
                conflict = True
                print "AFU : %s is in used." % afu
        else :
            new_records = {}

        if not conflict :
            start_time = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            end_time = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + life))
            new_records [afu] = (docker_name, start_time, end_time)

            new_text = json.dumps(new_records)
            locked_file.truncate(0)
            locked_file.seek(0)
            locked_file.write(new_text)
    finally :
        fcntl.flock(locked_file,fcntl.LOCK_UN)
        locked_file.close()
    return not conflict


def find_add_entry (docker_name, life, cgroup_control=False, acc_uuid=None):
    if cgroup_control :
        cgroup_path = None
        for path in docker_cgroup_search_path :
            if os.path.exists(path % docker_name) :
                cgroup_path = path % docker_name
                break
        if not cgroup_path :
            return None

    if not os.path.exists(capi_dev_path) :
        return None

    l = os.listdir (capi_dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('.')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return None

    idle_afu = None
    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')
    else :
        if not os.path.exists(capi_db_path) :
            os.makedirs(capi_db_path)
        locked_file = open(lock_file_path, 'w+')

    history_afu = None
    if acc_uuid and os.path.exists(history_file_path) :
        history_file = open(history_file_path, 'r')
        text = history_file.read()
        if len (text) > 0 :
            try :
                history_afu = json.loads(text)
            except Exception, e :
                print "Can not read file %s as json format" % history_file_path
        history_file.close()
    

    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read %s as json format" % lock_file_path

            new_records = update_capi_db (records)
        else :
            new_records = {}

        for afu in afu_list :
            if not new_records.has_key (afu) :
                idle_afu = afu
                print "AFU : Find an idle afu %s" % idle_afu
                if acc_uuid and history_afu :
                    if acc_uuid == history_afu.get (afu) :
                        print "Find an match history afu match %s" % acc_uuid
                        break

        if idle_afu and ((not cgroup_control) or docker_capi_device (docker_name, idle_afu, True)):
            start_time = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            end_time = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time() + life))
            new_records [idle_afu] = (docker_name, start_time, end_time)
        else :
            idle_afu = None

        new_text = json.dumps(new_records)
        locked_file.truncate(0)
        locked_file.seek(0)
        locked_file.write(new_text)
    finally :
        fcntl.flock(locked_file,fcntl.LOCK_UN)
        locked_file.close()
    return idle_afu


def remove_entry (docker_name):

    if not os.path.exists(lock_file_path) :
        return
    else :
        locked_file = open(lock_file_path, 'r+')

    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        result_records = {}
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read file as json format"

            new_records = update_capi_db (records)
            for k,v in new_records.items() :
                if v[0] != docker_name :
                    result_records[k] = v

        new_text = json.dumps(result_records)
        locked_file.truncate(0)
        locked_file.seek(0)
        locked_file.write(new_text)
    finally :
        fcntl.flock(locked_file,fcntl.LOCK_UN)
        locked_file.close()


def change_entry (docker_name=None, new_name=None, new_life=None):
    change = False
    if not os.path.exists(lock_file_path) :
        return None

    locked_file = open(lock_file_path, 'r+')
    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read file as json format"

            new_records = update_capi_db (records)
        else :
            new_records = {}

        for k,v in new_records.items() :
            if new_life and (v[0] == docker_name) :
                end_time = v [2]
                end_stamp = time.mktime(time.strptime(end_time,'%Y-%m-%d-%H-%M-%S'))
                new_end_stamp = end_stamp + new_life
                v [2] = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(new_end_stamp))
                print "Add life %s to docker : %s" % (new_life, docker_name)

            if new_name and (v[0] == docker_name) :
                v[0] = new_name
                print "change docker name %s -> %s" % (docker_name, new_name)
                change = True

        new_text = json.dumps(new_records)
        locked_file.truncate(0)
        locked_file.seek(0)
        locked_file.write(new_text)
    finally :
        fcntl.flock(locked_file,fcntl.LOCK_UN)
        locked_file.close()
    return change


