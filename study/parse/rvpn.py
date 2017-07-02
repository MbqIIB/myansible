#!/usr/bin/env python
# -*- coding:utf-8 -*-
import json
import logging
import requests
#from django.conf import settings

PARSE_SERVER_URL = "https://172.31.250.21/parse"
PARSE_SERVER_FUNCTION_URL = PARSE_SERVER_URL + '/parse'
PARSE_APP_ID = "myAppId"
PARSE_API_KEY = "axug9slvknxc0wsce0hizy7ay7rvwlvq"


def parse_cloud_function(function_name=None, params=None):
    if not function_name or not params:
        return False
    function_url = "%s/%s" % (PARSE_SERVER_FUNCTION_URL, function_name)
    header = {
        "X-Parse-Application-Id": PARSE_APP_ID,
        "X-Parse-REST-API-Key": PARSE_API_KEY,
        "Content-Type": "application/json"
    }

    try:
        ret = requests.post(url=function_url, headers=header, data=json.dumps(params))
        print ret
        response = json.loads(ret.text)
    except Exception, exc:
        print "debug", exc.message
        return False

    return response


if __name__=='__main__':
    print "test restful https"
    user_id="linzhbj"
    username="linzhbj@cn.ibm.com"
    ret=parse_cloud_function('getOrCreateUser', {"user_id": user_id, "user_name": username})
    print ret
