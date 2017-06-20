# VNC module for Puppet

Module is going to manage the vnc server 

It will install vncserver fluxbox , and also google-chrome 

**NOTE** : You have to pass the plaintext password for "vncpassword"

check the below usage

#Install and configure vnc server
```puppet 
class { 'vnc': 
     vncusername       => 'vncuser',
     userpassword      => '$1$qCmU0a$a9Q6W/fDzU6zQI42/Z2sE0',
     vncpassword       => 'password',
     vncport           =>  5900,
}
```

**Tested OS** : CentOS 7 and Ubuntu 14

##NOTE:
if you have any error on package installation , please reboot the server 
and try again , it may be issue with package while running updates

and also in CentOS it has an issue with startup script , so if you get any error related to
service start, just reboot server for the first time only not everytime.


