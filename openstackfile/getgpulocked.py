#!/usr/bin/env python

path="/var/lib/gpu/gpu_locked.txt"


import os,sys

import ast 
import socket

def getHost():
    return socket.gethostname()


def getlocked():
    hostname=getHost()
    #print path
    fp=open(path, "r")
    info=fp.read()
    #print info
    d=ast.literal_eval(info)
    #print len(d)
    print "%s,nvidia0,%d" % (hostname, (9999 - d['nvidia0']['available_count']))
    print "%s,nvidia1,%d" % (hostname, (9999 - d['nvidia1']['available_count']))
    print "%s,nvidia2,%d" % (hostname, (9999 - d['nvidia2']['available_count']))
    print "%s,nvidia3,%d" % (hostname, (9999 - d['nvidia3']['available_count']))
    fp.close()


if __name__ == "__main__":
    getlocked()
