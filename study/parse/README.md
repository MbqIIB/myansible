# set parse
```
yum install npm
npm install -g parse-dashboard

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https

firewall-cmd --permanent --add-port=4040/tcp
firewall-cmd  --add-port=4040/tcp

parse-dashboard --appId yourAppId --masterKey yourMasterKey --serverURL "https://localhost/parse"  --appName optionalName

https://172.31.250.21:4040/parse
$ openssl req -newkey rsa:2048 -new -nodes -keyout key.pem -out csr.pem
$ openssl x509 -req -days 365 -in csr.pem -signkey key.pem -out server.crt

openssl genrsa -out privatekey.pem 1024
openssl req -new -key privatekey.pem -out certrequest.csr
openssl x509 -req -in certrequest.csr -signkey privatekey.pem -out certificate.pem


parse-dashboard --config parse-dashboard.json  --sslKey key.pem  --sslCert server.crt

or 
parse-dashboard --config parse-dashboard.json  --allowInsecureHTTP True
http://172.31.250.21:4040/parse


npm install -g parse-server
yum install mongodb-server mongodb
vim /etc/selinux/config 
setenforce 0

firewall-cmd --permanent --add-port=27017/tcp
firewall-cmd  --add-port=27017/tcp
systemctl enable mongod
systemctl start mongod
systemctl status mongod

netstat -nap | grep 27017

firewall-cmd --permanent --add-port=1337/tcp
firewall-cmd  --add-port=1337/tcp

nova secgroup-list-rules default
nova secgroup-add-rule default tcp 4040 4040 0.0.0.0/0
nova secgroup-add-rule default tcp 1337 1337 0.0.0.0/0
nova secgroup-add-rule default tcp 27017 27017 0.0.0.0/0

mongo
 use parse;
> db.createUser( { user: "linzhbj", pwd: "passw0rd", roles: ["readWrite", "dbAdmin" ] })
Successfully added user: { "user" : "linzhbj", "roles" : [ "readWrite", "dbAdmin" ] }

mkdir /parse
mkdir -p /parse/server
mkdir -p /parse/data/db
mkdir -p /parse/data/configdb
mkdir -p /parse/dash


curl -X POST -H "X-Parse-Application-Id: myAppId" -H "Content-Type: application/json" -d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' http://localhost:1337/parse/classes/GameScore
{"objectId":"GHe8C8sGbw","createdAt":"2017-06-30T11:13:31.891Z"}
curl -X GET -H "X-Parse-Application-Id: myAppId"   http://localhost:1337/parse/classes/GameScore/

```
ref:
[parse-dashboard](https://github.com/yongjhih/docker-parse-dashboard)

http://www.jianshu.com/p/d52e9514c839
http://blog.gaoyuan.xyz/2014/05/14/a-trouble-in-request-https-in-curl/
http://man.linuxde.net/curl
https://stackoverflow.com/questions/7885785/using-openssl-to-get-the-certificate-from-a-server
https://github.com/parse-community/parse-server-example
http://www.cnblogs.com/274914765qq/p/4836782.html
http://www.jianshu.com/u/0de49886c353
http://www.jianshu.com/p/d52e9514c839
https://www.howtoing.com/install-parse-server-on-ubuntu/






