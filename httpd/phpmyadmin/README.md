# phpmyadmin

``` shell
yum install php phpmyadmin

update all :  /etc/httpd/conf.d/phpMyAdmin.conf
     <RequireAny>
#       Require ip 127.0.0.1
#       Require ip ::1
        Require all granted
     </RequireAny>

# change config
$cfg['Servers'][$i]['host']          = 'localhost'; // MySQL hostname or IP address
$cfg['Servers'][$i]['port']          = '';          // MySQL port - leave blank for default port
$cfg['Servers'][$i]['controluser']   = '';          // MySQL control user settings
$cfg['Servers'][$i]['controlpass']   = '';          // access to the "mysql/user"

service httpd restart
```
