#!/usr/bin/env python

import os, sys
import datetime
import time

import json
import urllib
import urllib2
import httplib
import socket


class SvUser:

    def __init__(self):
        self.AllUserList=[]
        self.NewUserList=[]
        self.AllUserName=[]
        self.AllUserCounts=0
        self.NewUserCounts=0
        self.CurDate=time.strftime('%Y%m%d')
        self.Yesterday=''
        self.GetYestoday()
        self.UserList=[]

    def GetYestoday(self, cnt=int(1)):
        date = datetime.datetime.strptime(str(self.CurDate), '%Y%m%d').date()
        back = datetime.timedelta(days=cnt)
        yesterday=date - back
        self.Yesterday= yesterday.strftime('%Y%m%d')
        print "Yesterday % s" % self.Yesterday

    def UrlRequest(self, url):
        header=True
        testpost=False
        if testpost == True:
            user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
            values = {'code' : str_symbol,
                      'start' : start,
                      'end' : end,
                      'fields' : options }
            headers = { 'User-Agent' : user_agent }
        
        else :
            i_headers = {"User-Agent": "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1) Gecko/20090624 Firefox/3.5"}
        
        Debug=False
        if Debug==True:
            httpHandler = urllib2.HTTPHandler(debuglevel=1)
            httpsHandler = urllib2.HTTPSHandler(debuglevel=1)
            opener = urllib2.build_opener(httpHandler, httpsHandler)
            urllib2.install_opener(opener)
        
        #useipv4=True
        useipv4=False
        
        retry =0
        MaxRetry=3
        while True :
             try:
                 tout=120
                 if useipv4==True:
                     urlopen_IPv4= urllib2.build_opener(HTTPHandler_IPv4).open
                     response= urlopen_IPv4(url, timeout=tout)
                     break
                 if header==True:
                     if testpost == True:
                         data = urllib.urlencode(values)
                         print data
                         req = urllib2.Request(url, data, headers)
                     else:
                         req = urllib2.Request(url, headers=i_headers)
                     response = urllib2.urlopen(req, timeout=tout)
                 else:
                     response = urllib2.urlopen(url, timeout=tout)
                 break

             except urllib2.HTTPError,e:
                 if hasattr(e,'code'):
                     print 'code:{0}'.format(e.code)
                 raise urllib2.HTTPError
             except urllib2.URLError, e:
                 if hasattr(e,'reason'):
                     print 'reason:{0}'.format(e.reason)
                 if hasattr(e,'code'):
                     print 'code:{0}'.format(e.code)
                 retry +=1
                 if retry > MaxRetry:
                     print 'More than max %d' % MaxRetry
                     raise urllib2.URLError
                 else:
                     print 'Try request again ...'
             else :
                 pass
                 #print "Down data ok"
        return response

    def AllUserPrint(self,UserList):

        for id in UserList :
            print             datetime.datetime.utcfromtimestamp(
                                 id['timestamp']/1000 
                             ).strftime('%Y-%m-%d'),
                             #).strftime('%Y-%m-%d %H:%M:%S'),
        
            print "%s,   %s,   %d,   %s,   %s" % (
                             id['balance'],
                             id['isActivated'],
                             id['timestamp'],
                             id['username'],
                             id['rawPasswd'],
                            )

    def GetUserData(self):
        """ Get user list from web server """
        url="http://accountservice.ptopenlab.com/cloudlab/api/user/account/compete/userlist"
        Data=self.UrlRequest(url)
        JsonData=Data.read()
        self.AllUserList=json.loads(JsonData)
        #self.AllUserPrint(self.AllUserList)
        self.AllUserCounts=len(self.AllUserList)

    def bak1_HtmlGetUserData(self):

        print 'Get Power Challenge Infomations'
        content=''
        name= 'Power Challenge New User Registrations'
        contenthead="<h2>%s</h2>" % name
        content+=contenthead

        self.GetUserData()
        self.GetNewUsers()

        #if self.AllUserCounts == 0:
        if self.NewUserCounts == 0:
            content="None User Register Today"
            return content

        tablehead="""<table style="border:1px #808080 outset;border-collapse:separate;border-spacing:1px;" cellspacing="1px" ><tbody>"""
        titlehead="""
        <tr>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
        </tr>""" % \
        ('User','Activated','Balance','Date')
        try:
            content+=tablehead
            content+=titlehead

            #for id in self.AllUserList :
            for id in self.NewUserList:
                fmt="""<tr>
                    <td style="border:1px #808080 inset;padding:1px;" align="left">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%d</td>
                    <td style="border:1px #808080 inset;padding:1px;" align="center">%s</td>
                    </tr>""" \
                        % (
                             id['username'],
                             id['isActivated'],
                             id['balance'],
                             datetime.datetime.utcfromtimestamp(
                                 id['timestamp']/1000 
                                ).strftime('%Y-%m-%d %H:%M:%S'),
                        )


                #fmt="""<tr>
                #    <td>%s</td>
                #    <td>%s</td>
                #    <td>%d</td>
                #    <td>%s</td>
                #    </tr>""" \
                #        % (
                #             id['username'],
                #             id['isActivated'],
                #             id['balance'],
                #             datetime.datetime.utcfromtimestamp(
                #                 id['timestamp']/1000 
                #                ).strftime('%Y-%m-%d %H:%M:%S'),
                #        )


                content+=fmt

            tableend = """</tbody></table>"""
            content+=tableend
            #print content
            
            return content

        except Exception as e:
            print "users list err" , e
            return content


    def HtmlGetUserData(self):
        print 'Get Power Challenge Infomations'
        content='<hr>'
        name= 'Date: %s POWER Challenge New User Registrations' % self.Yesterday
        contenthead="<h2>%s</h2>" % name
        content+=contenthead

        self.GetUserData()
        self.GetNewUsers()

        #if self.AllUserCounts == 0:
        if self.NewUserCounts == 0:
            NoneContent = "<h3>None User Register Today </h3>"
            content += NoneContent
            return content

        #tablehead="""<table style="border:1px #808080 outset;border-collapse:separate;border-spacing:1px;" cellspacing="1px" ><tbody>"""
        tablehead="""<table style="border-collapse:collapse; margin-left: 5px;">"""
        titlehead="""
        <thead style="background:#4E5066  ; color: #FFFFFF; font-size: 11pt; text-transform: uppercase; line-height:2.5em;">
        <tr>
            <td style="font-weight: normal; font-size:15px; border-right: 2px solid rgb(217,217,217); padding: 6px 0;" align="center">%s</td>
            <td style="font-weight: normal; font-size:15px; border-right: 2px solid rgb(217,217,217); padding: 6px 0;" align="center">%s</td>
            <td style="font-weight: normal; font-size:15px; border-right: 2px solid rgb(217,217,217); padding: 6px 0;" align="center">%s</td>
        </tr>
        </thead>
        <tbody>
        """ % \
        ('User', 'Activated', 'Date')
        #('User','Activated','Balance','Date')
        try:
            content+=tablehead
            content+=titlehead

            count=0
            #for id in self.AllUserList :
            for id in self.NewUserList:
                if count % 2 == 1 :
                    trhead="""<tr style="background-color: rgb(220,220,220);line-height: 22px;">"""
                    
                else :
                    trhead="""<tr style=";line-height: 22px;">"""
                count +=1

                fmt2="""
                    <td style="font-size: 13px; border-right: 1px solid rgb(217,217,217);  padding: 5px 0 5px 5px;" align="left">%s</td>
                    <td style="font-size: 13px; border-right: 1px solid rgb(217,217,217);  padding: 5px 0 5px 5px;" align="center">%s</td>
                    <td style="font-size: 13px; border-right: 1px solid rgb(217,217,217);  padding: 5px 0 5px 5px;" align="center">%s</td>
                </tr>
                    """ % (
                             id['username'],
                             id['isActivated'],
                             datetime.datetime.utcfromtimestamp(
                                 id['timestamp']/1000 
                                ).strftime('%Y-%m-%d %H:%M:%S'),
                        )
                fmt=trhead+fmt2

                content+=fmt
            tableend = """</tbody></table>"""
            content+=tableend
            #print content
            return content
        except Exception as e:
            print "users list err" , e
            return content

    def GetNewUsers(self):
        DATETIME=self.Yesterday
        #DATETIME='20160603'
        print "Date : %s" % DATETIME
        #print type(DATETIME)
        for id in self.AllUserList:
            date=datetime.datetime.utcfromtimestamp(
                    id['timestamp']/1000 
                    ).strftime('%Y%m%d'),
            #print date
            #print type(date[0])
            #print "%d" % int(DATETIME)
            #print "%d" % int(date[0])
            if int(DATETIME) == int(date[0]):
                self.NewUserList.append(id.copy())
            else :
                pass
        
        self.NewUserCounts=len(self.NewUserList)
        #self.AllUserPrint(self.NewUserList)

    def GetAllUserName(self):
        for id in self.AllUserList:
            self.AllUserName.append(id['username'])

    def PrintAllUserName(self, NameList):
        for name in NameList:
            print name

    def HtmlGetNewUserCounts(self):
        name="Date: %s New Registration Accounts" % self.Yesterday
        contenthead="<h2>%s</h2> " % name
        contenthead=""
        fmt = """<h3>%s : <span style="color: #0000EE;">%d</span></h3>""" % (name, self.NewUserCounts)
        #print fmt
        content=''
        content=''.join(fmt)
        return contenthead+content

    def HtmlGetAllUserCounts(self):
        name="From 20160601 to %s Registration Accounts" % self.Yesterday
        contenthead="<h2>%s</h2> " % name
        contenthead=""
        fmt = """<h3>%s : <span style="color: #0000EE;">%d</span></h3>""" % (name, self.AllUserCounts)
        #print fmt
        content=''
        content=''.join(fmt)
        return contenthead+content

    def GetUserList(self, file):
        fp=open(file, 'r')
        for l in fp.readlines():
            user=l.split('|')
            #print user
            uid=user[1].strip()
            u=user[2].strip()
            #print "id=%s" % u
            self.UserList.append((uid,u))
        fp.close()

    def GetUserInfo(self, UserList):

        for user in UserList: 
            #print "====== user %s =======" % user[1]
            try:
                url='https://accountservice.ptopenlab.com/cloudlab/api/user/account/%s/withraw' % user[1]
                Data=self.UrlRequest(url)
                JsonData=Data.read()
                #print type(JsonData)
                if len(JsonData) == 0:
                    continue
                id=json.loads(JsonData)

                #print info
                print "%s," % user[0],
                print  "%s,"   %    datetime.datetime.utcfromtimestamp(
                                     id['timestamp']/1000 
                                 ).strftime('%Y-%m-%d'),
                print "%s,   %s,   %d,   %s,   %s" % (
                                 id['balance'],
                                 id['isActivated'],
                                 id['timestamp'],
                                 id['username'],
                                 id['rawPasswd'],
                                )
            except Exception as e:
                print "users list err" , e




if __name__ == '__main__' :
    svuser=SvUser()
    svuser.GetUserList('alluserlist.txt')
    #print svuser.UserList
    svuser.GetUserInfo(svuser.UserList)
    #svuser.AllUserPrint(svuser.AllUserList)
    #svuser.GetNewUsers()
    #svuser.GetAllUserName()
    #svuser.PrintAllUserName(svuser.AllUserName)

    print "Done"
