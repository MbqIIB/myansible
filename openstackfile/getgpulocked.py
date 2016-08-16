#!/usr/bin/env python

path="/var/lib/gpu/gpu_locked.txt"


import os,sys

import ast 

def getlocked():
    #print path
    fp=open(path, "r")
    info=fp.read()
    #print info
    d=ast.literal_eval(info)
    #print len(d)
    print "nvidia0 = %d" % (9999 - d['nvidia0']['available_count'])
    print "nvidia1 = %d" % (9999 - d['nvidia1']['available_count'])
    print "nvidia2 = %d" % (9999 - d['nvidia2']['available_count'])
    print "nvidia3 = %d" % (9999 - d['nvidia3']['available_count'])
    fp.close()


if __name__ == "__main__":
    getlocked()
