#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
#   Author  :   Lin Zhao
#   E-mail  :   linzhaolover@gmail.com
#   Date    :   14/12/22 17:37:54
#   Desc    :
#

import time,os
import commands
import re

from os import environ as env
import os

import socket
hostname=socket.gethostname()
#print hostname


#my module
import performanceMonitor as perfMoni

#import novaclient.v1_1.client as nvclient
import novaclient.client as nvclient

#nova = nvclient.Client(auth_url=env['OS_AUTH_URL'],
#                       username=env['OS_USERNAME'],
#                       api_key=env['OS_PASSWORD'],
#                       project_id=env['OS_TENANT_NAME'],
#                       region_name=env['OS_REGION_NAME'])
#



def get_nova_credentials_v2():
    d = {}
    d['version'] = '2'
    d['username'] = os.environ['OS_USERNAME']
    d['api_key'] = os.environ['OS_PASSWORD']
    d['auth_url'] = os.environ['OS_AUTH_URL']
    d['project_id'] = os.environ['OS_TENANT_NAME']
    d['region_name'] = os.environ['OS_REGION_NAME']
#    d['endpoint_type'] = os.environ['OS_ENDPOINT_TYPE']
    return d


def get_nova_creds():
    d = {}
    d['username'] = os.environ['OS_USERNAME']
    d['api_key'] = os.environ['OS_PASSWORD']
    d['auth_url'] = os.environ['OS_AUTH_URL']
    d['project_id'] = os.environ['OS_TENANT_NAME']
    d['region_name'] = os.environ['OS_REGION_NAME']
    return d

class NovaInformations:

    def __init__(self):
        #self.nova = nvclient.Client(
        #                auth_url=env['OS_AUTH_URL'],
        #                username=env['OS_USERNAME'],
        #                api_key=env['OS_PASSWORD'],
        #                project_id=env['OS_TENANT_NAME'],
        #                region_name=env['OS_REGION_NAME'])

        #NovaCred = get_nova_creds()
        NovaCred = get_nova_credentials_v2()
        #print NovaCred
        self.nova = nvclient.Client(**NovaCred)
        #print self.nova
        #print self.nova.servers.list()
        self.serverscounts=0
        self.OneComputeUserCounts=0
        self.OneComputeInstanceCounts=0


    def printhypervisors(self, hypervisor):
        info=(
            hypervisor.id,
            hypervisor.hypervisor_hostname,
            hypervisor.hypervisor_type,
            hypervisor.vcpus,
            hypervisor.vcpus_used,
            hypervisor.memory_mb,
            hypervisor.memory_mb_used,
            hypervisor.local_gb,
            hypervisor.local_gb_used,
            hypervisor.running_vms
            )
        print info


    def hypelist(self):
        hypervisors = []
        try:
            hypervisors=self.nova.hypervisors.list()

            for hypervisor in hypervisors:
                self.printhypervisors(hypervisor)

        except Exception as e:
            print "hypervisors err" , e

        #return info

    def hypeshowserver(self, server):
        hypervisor_match=server

        content=''
        hypervisors = []
        tablehead="""<table style="border:1px #808080 outset;border-collapse:separate;border-spacing:1px;" cellspacing="1px" ><tbody>"""
        titlehead="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        </tr>""" % \
        ('ID','Hostname','Type','VCPUs(total)','VCPUs(used)','RAM(total)','RAM(used)','Storage(total)','Storage(used)','instances')
        try:
            content+=tablehead
            content+=titlehead

            hypervisors=self.nova.hypervisors.list()
            for hypervisor in hypervisors:
                #fmt="""<p>%d&nbsp;%s&nbsp;%s&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d</p>"""
                if hypervisor.hypervisor_hostname != hypervisor_match :
                    continue

                fmt="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dMB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dMB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dGB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dGB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    </tr>""" \
                        % (
                        hypervisor.id,
                        hypervisor.hypervisor_hostname,
                        hypervisor.hypervisor_type,
                        hypervisor.vcpus,
                        hypervisor.vcpus_used,
                        hypervisor.memory_mb,
                        hypervisor.memory_mb_used,
                        hypervisor.local_gb,
                        hypervisor.local_gb_used,
                        hypervisor.running_vms
                        )
                content+=fmt

            tableend = """</tbody></table>"""
            content+=tableend
            #print content
            return content
        except Exception as e:
            print "hypervisors err" , e
            return content

    def hypestat(self):
        try:
            stat=self.nova.hypervisors.statistics()
            print stat.__dict__
            info=(
                stat.count,
                  stat.vcpus_used,
                  stat.vcpus,
                  stat.memory_mb,
                  stat.memory_mb_used,
                  stat.local_gb,
                  stat.local_gb_used
                  )
            print info

        except Exception as e:
            print "hypervisors err" , e

        #return info

    def hypeinfostat(self):

        info=()
        try:
            stat=self.nova.hypervisors.statistics()
            info=(
                  stat.count,
                  stat.vcpus_used,
                  stat.vcpus,
                  stat.memory_mb_used,
                  stat.memory_mb,
                  stat.local_gb_used,
                  stat.local_gb
                  )
            #print info

            fmt="""<p>Total &nbsp; Statistics &nbsp;&nbsp;<font color="#FF0000">%d</font>
            &nbsp;
            VCPU Usage &nbsp;Used
            <span style="color: rgb(255, 0, 255);">%d</span>
            &nbsp;of
            <span style="color: rgb(255, 0, 255);">%d</span>
            &nbsp;
            Memory Usage &nbsp;Used
            <span style="color: rgb(255, 0, 255);">%d</span>
            GB&nbsp;of
            <span style="color: rgb(255, 0, 255);">%d</span>
            GB&nbsp;
            Disk Usage &nbsp;Used
            <span style="color: rgb(255, 0, 255);">%d</span>
            GB&nbsp;of
            <span style="color: rgb(255, 0, 255);">%d</span>
            GB</p>""" \
                    % (
                      stat.count,
                      stat.vcpus_used,
                      stat.vcpus,
                      stat.memory_mb_used,
                      stat.memory_mb,
                      stat.local_gb_used,
                      stat.local_gb)

            return fmt

        except Exception as e:
            print "hypervisors err" , e

            return  ''

    def hypeinfolist(self):
        content=''
        hypervisors = []
        tablehead="""<table style="border:1px #808080 outset;border-collapse:separate;border-spacing:1px;" cellspacing="1px" ><tbody>"""
        titlehead="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        </tr>""" % \
        ('ID','Hostname','Type','VCPUs(total)','VCPUs(used)','RAM(total)','RAM(used)','Storage(total)','Storage(used)','instances')
        try:
            content+=tablehead
            content+=titlehead

            hypervisors=self.nova.hypervisors.list()
            for hypervisor in hypervisors:
                #fmt="""<p>%d&nbsp;%s&nbsp;%s&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d GB&nbsp;%d</p>"""

                fmt="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dMB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dMB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dGB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%dGB</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    </tr>""" \
                        % (
                        hypervisor.id,
                        hypervisor.hypervisor_hostname,
                        hypervisor.hypervisor_type,
                        hypervisor.vcpus,
                        hypervisor.vcpus_used,
                        hypervisor.memory_mb,
                        hypervisor.memory_mb_used,
                        hypervisor.local_gb,
                        hypervisor.local_gb_used,
                        hypervisor.running_vms
                        )
                content+=fmt


            tableend = """</tbody></table>"""
            content+=tableend
            #print content
            return content
        except Exception as e:
            print "hypervisors err" , e
            return content

    def hypeinfo(self,compute=None):
        print 'get nova hypervisor infomations'
        content=''
        name= 'Server'
        contenthead="<h2>%s Statistics</h2>" % name
        content+=contenthead

        #fmt=self.hypeinfostat()
        #content+=fmt

        #content+='<br>'

        #fmt=self.hypeinfolist()
        #content+=fmt

        #content+='<br>'
        fmt=self.hypeshowserver(compute)
        content+=fmt

        #print content

        return content

    def hypetest(self):
        #self.hypestat()
        #self.hypelist()
        self.hypeinfo()
        self.hypeshowserver(server="compute-cp12-ppc-LE-kvm.ibm.com")

    def print_server(self, server):
        print ("-"*35)
        print ("server id: %s" % server.id)
        print ("server name: %s" % server.name)
        print ("server status: %s" % server.status)
        print ("server image: %s" % server.image)
        print ("server flavor: %s" % server.flavor)
        print ("server key_name: %s" % server.key_name)
        print ("server user_id: %s" % server.user_id)
        print ("server tenant_id: %s" % server.tenant_id)
        print ("-"*35)

    def novaOneComputeUser(self,server):
        print "nova list info stat"
        try:
            computeUserList=[]
            search_opts={'all_tenants':True ,
                    'host':server}

            print search_opts
            serversList=self.nova.servers.list(detailed=True, search_opts=search_opts)
            self.OneComputeInstanceCounts=len(serversList)

            for instance in serversList:
                #self.print_server(instance)
                #print instance.user_id
                computeUserList.append(instance.user_id)

            #print computeUserList

            userlist=list(set(computeUserList))
            self.OneComputeUserCounts=len(userlist)
            return True
        except Exception as e:
            print "servers list err" , e
            return False

    def novalistinfostat(self):
        print "nova list info stat"
        try:
            #search_opts={'all_tenants':True ,
            #        'host':u"compute-cp12-ppc-LE-kvm.ibm.com"}
            #search_opts={'host':u"compute-cp12-ppc-LE-kvm.ibm.com"}

            search_opts = {'status': None,
                    'deleted': False,
                    'ip': None,
                    'image': None,
                    'host': u'compute-cp12-ppc-LE-kvm.ibm.com',
                    'ip6': None,
                    'all_tenants': 1,
                    'flavor': None,
                    'reservation_id': None,
                    'name': None,
                    'tenant_id': None,
                    'instance_name': None}

            #search_opts = {
            #'all_tenants': args.all_tenants,
            #'reservation_id': args.reservation_id,
            #'ip': args.ip,
            #'ip6': args.ip6,
            #'name': args.name,
            #'image': imageid,
            #'flavor': flavorid,
            #'status': args.status,
            #'tenant_id': args.tenant,
            #'host': args.host,
            #'deleted': args.deleted,
            #'instance_name': args.instance_name}


            serversList=self.nova.servers.list(detailed=True, search_opts=search_opts)
            for server in serversList:
                self.print_server(server)
                break

        except Exception as e:
            print "servers list err" , e
            return content

    def computeUserCounts(self, compute=None):

        self.novaOneComputeUser(compute)
        name="Compute User and Instance Counts"
        contenthead="<h2>Statistics %s</h2> " % name
        fmt = """<p>%s : <span style="color: rgb(255, 0, 255);">%d</span></p>""" % ("Users", self.OneComputeUserCounts)
        fmt += """<p>%s : <span style="color: rgb(255, 0, 255);">%d</span></p>""" % ("Instances", self.OneComputeInstanceCounts)
        #print fmt
        content=''
        content=''.join(fmt)
        return contenthead+content


    def getserverscounts(self):
        name="NovaVMCounts"
        contenthead="<h2>Statistics %s</h2> " % name
        fmt = """<p>%s : <span style="color: rgb(255, 0, 255);">%d</span></p>""" % (name, self.serverscounts)
        #print fmt
        content=''
        content=''.join(fmt)
        return contenthead+content


    def htmlnovalistinfostat(self):
        #print "nova list info stat"
        content=''
        tablehead="""<table style="border:1px #808080 outset;border-collapse:separate;border-spacing:1px;" cellspacing="1px" ><tbody>"""
        titlehead="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        </tr>""" % \
        ('ID','Name')
        try:
            content+=tablehead
            content+=titlehead

            search_opts={'all_tenants':True ,
                    'host':u"compute-cp12-ppc-LE-kvm.ibm.com"}

            serversList=self.nova.servers.list(search_opts=search_opts)
            self.serverscounts=len(serversList)
            for server in serversList:
                # TODO: need filter by user_id
                #print server.id, server.name
                fmt="""<tr><td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    </tr>""" \
                        % (
                        server.id,
                        server.name,
                        )
                content+=fmt

            tableend = """</tbody></table>"""
            content+=tableend
            #print content
            return content

        except Exception as e:
            print "servers list err" , e
            return content


    def novalistinfo(self):
        print "Get nova list infomations"
        content=''
        name= 'Nova List'
        contenthead="<h2>%s Statistics</h2>" % name
        content+=contenthead

        fmt=self.htmlnovalistinfostat()

        return content+fmt

    def novalisttest(self):
        self.novalistinfo()


    def novapingtest(self,iplist):
        ip_ok=[]
        ip_failed=[]
        iplen=len(iplist)
        print "iplist len %d" % iplen

        for (id,ip) in iplist:
            #my module
            ret=perfMoni.pingT(ip)
            if ret:
                ip_failed.append(ip)
                error="ping %s fail" % ip
                print error

            else:
                ip_ok.append(ip)

        print "ip ok %d" % len(ip_ok)
        print "ip faild %d" % len(ip_failed)

        if iplen == 0:
            print "ping test p1"
            return True
        elif iplen < 5 and len(ip_ok) > 0 :
            print "ping test p2"
            return True
        elif iplen >= 5 :
            if len(ip_ok) >= 5 :
                print "ping test p3"
                return True
            else:
                print "ping test p4"
                return False




    def service_start(self,name):
        cmd="/sbin/initctl start %s " % name
        print cmd
        (ret1, output)=commands.getstatusoutput(cmd)
        print output

    def service_stop(self,name):
        cmd="/sbin/initctl stop %s " %  name
        print cmd
        (ret1, output)=commands.getstatusoutput(cmd)
        print output

    def service_restart(self,name):
        self.service_stop(name)
        time.sleep(1)
        self.service_start(name)



    def restartcomputeservice(self):
        name="nova-compute"
        self.service_restart(name)

    def restartcomputeopenswitch(self):
        name="neutron-plugin-openvswitch-agent"
        self.service_restart(name)

    def novaPrintIP(self,servername):
        search_opts={'all_tenants':True ,
                    'status':"ACTIVE",
#                    'status':"SHUTOFF",
                    'host':servername}
        serversList=self.nova.servers.list(search_opts=search_opts)

        serverlistlen = len(serversList)
        print "server list len %d" % serverlistlen

        floatingiplist=[]
        for server in serversList:
                print server.id
                #self.print_server(server)
#                output = []
                for (network, addresses) in server.networks.items():
                    if len(addresses) == 0:
                        continue
                    elif len(addresses) == 2:
                        if "172."  in addresses[1] :
#                            print "| %s | %s |" % (server.id,addresses[1])
                            floatingiplist.append((server.id,addresses[1]))
                            break
                        else :
                            print "no",addresses

#                print len(floatingiplist)

                if len(floatingiplist) >= serverlistlen :
                    print "all server list "
                    print floatingiplist
                    break
                elif len(floatingiplist) >= 10 :
                    print "all server list first 10"
                    print floatingiplist
                    break

#                    addresses_csv = ', '.join(addresses)
#                    group = "%s=%s" % (network, addresses_csv)
#                    output.append(group)
#                print output

        ret=self.novapingtest(floatingiplist)
        if ret:
            print "all ip ok"
            return True
        else :
            print "all ip don't ok"
            #self.restartcomputeservice()
            self.restartcomputeopenswitch()
            return False






if __name__ == '__main__' :

    novainfo= NovaInformations()
    #novainfo.hypetest()
    #novainfo.novalisttest()
    #novainfo.novalistinfostat()
    #novainfo.novaOneComputeUser(server="compute-cp12-ppc-LE-kvm.ibm.com")
    novainfo.novaPrintIP(hostname)
#   novainfo.restartcomputeservice()
#   novainfo.restartcomputeopenswitch()

