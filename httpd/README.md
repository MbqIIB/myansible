# deploy httpd in ansible node
```
yum install -y httpd
systemctl status httpd
systemctl start httpd
firewall-cmd --list-all
firewall-cmd --permanent --add-service=httpd
firewall-cmd --list-service
firewall-cmd --reload

rhel:
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-port=80/tcp
```
