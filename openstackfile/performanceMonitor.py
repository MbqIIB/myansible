#!/bin/env python
# -*- coding:utf-8 -*-

import time,os
import commands
import re

hostsfile='/home/linzhbj/openpower/performanceMonitor'+'/'+'hosts.txt'
def pingT(ip):
    cmd='ping -c 3 -w 5 %s' % ip
    (ret, output)=commands.getstatusoutput(cmd)
    if ret:
        errinfo= '[ Info ] ping %s is fail'%ip
        #print errinfo
        pass
    else:
        errinfo= '[ Info ] ping %s is ok'%ip
        #print errinfo
        return ret

    return ret

def ping_Test():
    start_Time=int(time.time())
    ips=open('hosts.txt','r')
    ip_True = open('ip_True.txt','w')
    ip_False = open('ip_False.txt','w')

    count_True,count_False=0,0

    for ip in ips.readlines():
         ip = ip.replace('\n','')
         return1=os.system('ping -c 3 -w 5 %s' % ip)
         if return1:
            print 'ping %s is fail' % ip
            ip_False.write(ip+'\n')
            count_False += 1
         else:
            print 'ping %s is ok'%ip
            ip_True.write(ip+'\n')
            count_True += 1

    ip_True.close()
    ip_False.close()
    ips.close()
    end_Time = int(time.time())
    print "time(s)：",end_Time - start_Time,"s"

    print "ping True conunt :", count_True, "ping False conunt :" , count_False

def pingTest():
    times=5

    ip_ok=[]
    ip_failed=[]

    content=''
    content+="<h2>Network Delay Test</h2>"
    content+="<hr>"
    #content+='<p><font color="#FF00FF">Test Times %d s</font></p>'  % times
    content+='<p><font color="#FF00FF">Ping From %s</font></p>'  % '192.168.11.225' # TODO: get local ip

    tablehead="""<table
        style="border:1px #808080 outset;border-collapse:separate;border-spacing:0px;"
        cellspacing="0px" ><tbody>"""

    titlehead="""<tr>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
    </tr>""" % \
    ('IP','packet loss','time', 'min','max', 'avg')
    #('IP','transmitted', 'received', 'packet loss','time', 'min','max', 'avg')

    content += tablehead
    content += titlehead

    table=''
    ips=open(hostsfile,'r')
    for ip in ips.readlines():
        ip = ip.replace('\n','')
        ret=pingT(ip)
        if ret:
            ip_failed.append(ip)
            error="ping %s fail" % ip
            print error

        else:
            ip_ok.append(ip)

            cmd='ping -f -w %d %s' % (times, ip)
            print cmd
            (ret1, output)=commands.getstatusoutput(cmd)
            if ret1 ==0 :
                #print output
                olist=output.split('\n')
                #print olist[2:]

                line=olist[3].split(',')
                #print line
                transmitted=line[0].split()[0]
                received=line[1].split()[0]
                packetloss=line[2].split()[0]
                time=line[3].split()[1]

                line=olist[4].split()
                #print line
                pmin=line[3].split('/')[0]
                pavg=line[3].split('/')[1]
                pmax=line[3].split('/')[2]

                pmdev=line[3].split('/')[3]
                pipg=line[6].split('/')[0]
                pewma=line[6].split('/')[1]

                fmt="""<tr>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                </tr>""" \
                % ( ip,packetloss, time, pmin,pmax, pavg )

                #print fmt
                table+=fmt

    content+=table

    tableend = """</tbody></table>"""
    content+=tableend

    ipinfo="<h2>IP Infomations</h2>"
    #content+="<hr>"
    if ip_ok:
        ipinfo+='IP OK<br>'
        ipinfo+='<br>'.join(ip_ok)
        ipinfo+='<br>'
    else:
        ipinfo+='IP No Ok<br>'

    if ip_failed:
        ipinfo+='IP Failed<br>'
        ipinfo+='<br>'.join(ip_failed)
        ipinfo+='<br>'
    else:
        ipinfo+='IP No Failed<br>'

    content+=ipinfo

    #print content
    return content

if __name__ == '__main__':
    print "Test performance Monitor"
    #ping_Test()
    pingTest()
