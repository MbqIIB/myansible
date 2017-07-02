import os,sys
import json,httplib
connection = httplib.HTTPSConnection('172.31.250.21', 1337)
connection.connect()
#connection.request('POST', '/parse/classes/GameScore', json.dumps({
connection.request('POST', '/parse/classes/linzhbj', json.dumps({
    "score": 1337,
    "playerName": "Sean Plott",
    "cheatMode": False,
    "username": "linzhbj" 
    }), {
        "X-Parse-Application-Id": "myAppId",
        "X-Parse-REST-API-Key": "myMasterKey",
        "Content-Type": "application/json"
        })
results = json.loads(connection.getresponse().read())
print results
