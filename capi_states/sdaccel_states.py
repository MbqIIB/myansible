
import json
import sys
import os
import string
import commands
import argparse
import time
import fcntl

dev_type = "fpga_pcie_sdaccel"
dev_board = "Alphdata_SDAccel_7V3"
dev_path = r"/dev/xcldma"
db_path = "/var/lib/sdaccel"
lock_file_path = db_path + "/dev_locked"
queue_file_path = db_path + "/dev_queue"
result_file_path = db_path + "/dev_result"

docker_cgroup_search_path = ["/sys/fs/cgroup/devices/system.slice/docker-%s.scope",
                        "/sys/fs/cgroup/devices/docker/%s"]

def report_dev_resource ():
    if not os.path.exists(dev_path) :
        return None

    l = os.listdir (dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('_')[0])

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
    
                new_records = update_db (records)
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
            afu_val_list [afu] = (dev_board, int(end_stamp - now_stamp))
        else :
            afu_val_list [afu] = (dev_board, 0)

    return {dev_type:afu_val_list}


def docker_capi_device (docker_id, afu, allow) :
    cgroup_path = None
    for path in docker_cgroup_search_path :
        if os.path.exists(path % docker_id) :
            cgroup_path = path % docker_id
            break

    if not cgroup_path :
        return False

    afu_linux_ids = os.popen("ls /dev/%s* -l | awk '{print $5 $6}' | sed 's/,/:/g'" % afu).read().rstrip().split()
    for afu_linux_id in afu_linux_ids :
        if allow :
            os.system("sudo sh -c 'echo c %s rwm > %s/devices.allow'" % (afu_linux_id, cgroup_path))
        else:
            os.system("sudo sh -c 'echo c %s rwm > %s/devices.deny'" % (afu_linux_id, cgroup_path))

    return True


def update_db (records = None):
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


def add_entry (docker_name, afu, life):

    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')
    else :
        if not os.path.exists(db_path) :
            os.makedirs(db_path)

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

            new_records = update_db (records)
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


def find_add_entry (docker_name, life, cgroup_control=False):

    if cgroup_control :
        cgroup_path = None
        for path in docker_cgroup_search_path :
            if os.path.exists(path % docker_name) :
                cgroup_path = path % docker_name
                break
        if not cgroup_path :
            return None

    if not os.path.exists(dev_path) :
        return None

    l = os.listdir (dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('_')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return None

    idle_afu = None
    if os.path.exists(lock_file_path) :
        locked_file = open(lock_file_path, 'r+')
    else :
        if not os.path.exists(db_path) :
            os.makedirs(db_path)
        locked_file = open(lock_file_path, 'w+')

    ## LOCK the file
    fcntl.flock (locked_file, fcntl.LOCK_EX)
    try :
        text = locked_file.read()
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read %s as json format" % lock_file_path

            new_records = update_db (records)
        else :
            new_records = {}

        for afu in afu_list :
            if not new_records.has_key (afu) :
                idle_afu = afu
                print "AFU : Find an idle afu %s" % idle_afu

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



def try_find_idle_afu () :
    l = os.listdir (dev_path)
    afu_list = []
    for x in l :
        afu_list.append(x.split('_')[0])

    afu_list = list(set(afu_list))
    if not afu_list :
        return None

    idle_afus = []
    if not os.path.exists(lock_file_path) :
        return afu_list, idle_afus

    locked_file = open(lock_file_path, 'r+')
    text = locked_file.read()
    if len(text) > 0 :
        try :
            records = json.loads(text)
        except Exception, e :
            print "Can not read %s as json format" % lock_file_path

        new_records = update_db (records)
    else :
        new_records = {}

    for afu in afu_list :
        if not new_records.has_key (afu) :
            idle_afus.append (afu)

    return afu_list, idle_afus



def add_to_queue (instance_id):
    if os.path.exists(queue_file_path) :
        queue_file = open(queue_file_path, 'r+')
    else :
        if not os.path.exists(db_path) :
            os.makedirs(db_path)
        queue_file = open(queue_file_path, 'w+')

    idle_afu = None
    ## LOCK the file
    fcntl.flock (queue_file, fcntl.LOCK_EX)
    try :
        afu_list, idle_afus = try_find_idle_afu ()
        text = queue_file.read()
        if len(text) > 0 :
            try :
                # There may be xcldma0, xcldma1 ... queues
                # One job is described as [docker id, instance id, instance ip, status]
                queues = json.loads(text)
            except Exception, e :
                print "Can not read %s as json format" % queue_file_path
        else :
            queues = {}

        min_queue_len = 99999
        for afu in afu_list :
            if not queues.has_key (afu):
                idle_afu = afu
                break;
            else :
                queue_len = len(queues [afu])
                if queue_len < min_queue_len :
                    min_queue_len = queue_len
                    idle_afu = afu

        if idle_afu :
            if not queues.has_key (idle_afu) :
                queues [idle_afu] = []
            queues [idle_afu].append(["", instance_id, "", "Waiting", 75,])  # set timeout as 75*4 seconds
            print "Add job in %s to accelerator %s" % (instance_id, idle_afu)

        new_text = json.dumps(queues)
        queue_file.truncate(0)
        queue_file.seek(0)
        queue_file.write(new_text)
    finally :
        fcntl.flock(queue_file,fcntl.LOCK_UN)
        queue_file.close()
    return idle_afu




def remove_entry (docker_name, check_queue=True):
    if os.path.exists(lock_file_path) :
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

                new_records = update_db (records)
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

    if not check_queue :
        return

    job_result_action("remove", docker_name)

    if os.path.exists(queue_file_path) :
        queue_file = open(queue_file_path, 'r+')

        ## LOCK the file
        fcntl.flock (queue_file, fcntl.LOCK_EX)
        try :
            text = queue_file.read()
            if len(text) > 0 :
                try :
                    queues = json.loads(text)
                except Exception, e :
                    print "Can not read file as json format"

                # There may be xcldma0, xcldma1 ... queues
                # One job is described as [docker id, instance id, instance ip, status]
                find_afu = None
                for afu, queue in queues.items() :
                    job_id = 0
                    for job in queue :
                        if job [0] :
                            if job [0] == docker_name :
                                find_afu = afu
                                break
                        elif job [1] == docker_name :
                            find_afu = afu
                            break
                        job_id += 1

                    if find_afu :
                        break;

                if find_afu :
                    del queues[find_afu][job_id]
                    new_text = json.dumps(queues)
                    queue_file.truncate(0)
                    queue_file.seek(0)
                    queue_file.write(new_text)
        finally :
            fcntl.flock(queue_file,fcntl.LOCK_UN)
            queue_file.close()



def change_entry (docker_name=None, new_name=None, new_life=None):
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

                new_records = update_db (records)
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

            new_text = json.dumps(new_records)
            locked_file.truncate(0)
            locked_file.seek(0)
            locked_file.write(new_text)
        finally :
            fcntl.flock(locked_file,fcntl.LOCK_UN)
            locked_file.close()

    if os.path.exists(queue_file_path) :
        queue_file = open(queue_file_path, 'r+')

        ## LOCK the file
        fcntl.flock (queue_file, fcntl.LOCK_EX)
        try :
            text = queue_file.read()
            if len(text) > 0 :
                try :
                    queues = json.loads(text)
                except Exception, e :
                    print "Can not read file as json format"

                # There may be xcldma0, xcldma1 ... queues
                # One job is described as [docker id, instance id, instance ip, status]
                find_afu = None
                for afu, queue in queues.items() :
                    job_id = 0
                    for job in queue :
                        if job [1] == docker_name:
                            find_afu = afu
                            break
                        job_id += 1
                    if find_afu :
                        break

                if find_afu :
                    queues[find_afu][job_id][0] = new_name
                    new_text = json.dumps(queues)
                    queue_file.truncate(0)
                    queue_file.seek(0)
                    queue_file.write(new_text)
        finally :
            fcntl.flock(queue_file,fcntl.LOCK_UN)
            queue_file.close()



def job_result_action (action=None, docker_id=None, instance_id=None, status=None):

    def read_recorder (result_file) :
        text = result_file.read()
        records = []
        if len(text) > 0 :
            try :
                records = json.loads(text)
            except Exception, e :
                print "Can not read file as json format"
        return records


    if not action :
        return None

    if action == "status" :
        if not os.path.exists(result_file_path) :
            return None

        print "search %s" % instance_id
        result_file = open(result_file_path, 'r')
        records = read_recorder (result_file)
        result_file.close()
        for record in records :
            if record [1] == instance_id :
                return record [2]
        return None

    if not os.path.exists(result_file_path) :
        if action == "remove" :
            return
        if action == "add" :
            if not os.path.exists(db_path) :
                os.makedirs(db_path)
            result_file = open(result_file_path, 'w+')
    else :
        result_file = open(result_file_path, 'r+')

    ## LOCK the file
    fcntl.flock (result_file, fcntl.LOCK_EX)
    try :
        records = read_recorder (result_file)
        change = False
        if action == "add" :
            time_stamp = time.strftime('%Y-%m-%d-%H-%M-%S',time.localtime(time.time()))
            records.append ([docker_id, instance_id, status, time_stamp])
            change = True
        elif action == "remove" :
            job_id = 0
            for record in records :
                if record [0] == docker_id or record [1] == docker_id :
                    change = True
                    break;
                job_id += 1

            if change :
                del records [job_id]

        if change :
            new_text = json.dumps(records)
            result_file.truncate(0)
            result_file.seek(0)
            result_file.write(new_text)
    finally :
        fcntl.flock(result_file,fcntl.LOCK_UN)
        result_file.close()


