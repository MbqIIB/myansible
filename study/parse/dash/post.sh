set -x

#curl -X POST -H "X-Parse-Application-Id: myAppId" -H "Content-Type: application/json" -d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' http://localhost:1337/parse/class/MyApp
#certificate.pem  certrequest.csr  privatekey.pem
#curl  --cacert certs/privatekey.pem \
#curl  --cacert certrequest.csr \
#curl  --cacert  certs/certificate.pem \
#curl  --cacert  /etc/pki/tls/certs/ca-bundle.crt \
#	-X POST -H "X-Parse-Application-Id: myAppId" -H "Content-Type: application/json" -d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' https://localhost:1337/parse/class/MyApp
#

#curl  --cacert  cert.pem \
curl  --cacert  certs/certificate.pem \
      --capath /parse/dash/certs \
	-X POST -H "X-Parse-Application-Id: myAppId" -H "Content-Type: application/json" -d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' https://172.31.250.21:1337/parse/class/MyApp
