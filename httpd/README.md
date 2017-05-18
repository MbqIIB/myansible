# deploy httpd in ansible node
```
yum install -y httpd
systemctl status httpd
systemctl start httpd
firewall-cmd --list-all
firewall-cmd --permanent --add-service=httpd
firewall-cmd --list-service
firewall-cmd --reload
```
