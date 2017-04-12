#!/usr/bin/env python

"""
a module of share host GPU, created on 2016/05/31
"""

import os
import re
#import shutil
from oslo_log import log

LOG = log.getLogger(__name__)

def search_file(topPath, reValue):
    print "Jian>>> topPath:%s search:%s" % (topPath, reValue)
    resultList = []
    for rootpath, dirnames, filenames in os.walk(topPath):
        for filename in filenames:
            if re.findall(reValue, filename, re.IGNORECASE):
                resultList.append(os.path.join(rootpath, filename))
    print "Jian>>> lib files:%s" % resultList
    return resultList

def search_nvidia_dir(dstPath):
    dirList = []
    patt = re.compile('nvidia-\d+$', re.IGNORECASE)
    for dirname in os.listdir(dstPath):
        if patt.findall(dirname):
            dirList.append(os.path.join(dstPath, dirname))
    return dirList

"""
{"message": "Build of instance 280cc136-7b4d-43cd-ae88-9f84b9f2a083 was re-scheduled: [Errno 13] Permission denied: '/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf'", "code": 500, "created": "2016-06-01T09:40:30Z"}

def create_local_conf():
    libList = search_nvidia_dir("/usr/lib/")
    content = sorted(libList)[-1]
    if os.path.exists("/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf"):
        shutil.copyfile("/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf", "/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf.bak")
        os.remove("/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf")
    with open("/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf", "w") as fh:
        fh.writelines(content)
    #os.system("cd /etc/ld.so.conf.d/ && echo '%s' > powerpc64le-linux-gnu_GL.conf" % content)

"""

def report_gpu_volume():
    #create_local_conf()
    ubuntuDict = {
                  "nvidia-smi" : "/usr/lib/",
                  "libnvidia-ml" : "/usr/lib/",
                  "libcuda" : "/usr/lib/powerpc64le-linux-gnu/",
                  "etc_ld" : "/etc/ld.so.conf.d/powerpc64le-linux-gnu_GL.conf", #this file need to be create manually before running, on 2016/06/01
                  "usr_bin" : "/usr/bin/nvidia-smi",
                  }
    allDict = []
    allDict.append(ubuntuDict)
    bindList = []
    for eachDict in allDict:
        if "etc_ld" in eachDict.keys():
            bindList.append(eachDict["etc_ld"])
        if "usr_bin" in eachDict.keys():
            bindList.append(eachDict["usr_bin"])
        for nvidiaPath in search_nvidia_dir(eachDict["nvidia-smi"]):
            print "nvidia path:", nvidiaPath
            bindList.extend(search_file(os.path.join(nvidiaPath, "bin"), "nvidia-smi"))
            
        for nvidiaPath in search_nvidia_dir(eachDict["libnvidia-ml"]):
            bindList.extend(search_file(nvidiaPath, "libnvidia-ml\.so"))
        
        bindList.extend(search_file(eachDict["libcuda"], "libcuda\.so"))
        
    LOG.info("Jian>>> Bind List:%s" % bindList)
    print "Jian>>> Bind List:%s" % bindList
    return bindList
    
if __name__ == '__main__':
    print "Begain."
    report_gpu_volume()
    
