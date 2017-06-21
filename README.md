# VNC module for Puppet

Module to manage the vnc server.

It will install vncserver, fluxbox and also browser, default browser is "google-chrome",
and also configure the user and fluxbox and start the vncserver service 

**usage**:
  Install and configure vnc server
  ```puppet 
      class { 'vnc': 
        vncusername       => 'vncuser',
        userpassword      => '$1$qCmU0a$a9Q6W/fDzU6zQI42/Z2s',
        vncpassword       => 'password',
        vncport           =>  5900,
      }
  ```

**Hiera Usage**:
```
 -'vnc'
    vnc::vncusername:   'test1'
    vnc::userpassword:  '$1$qCmU0a$a9Q6W/fDzU6zQI42/Z2s'
    vnc::vncpassword:   'password'
    vnc::vncport:       '5901'
```
**NOTE**: You have to pass the plaintext password for **vncpassword** param.

you can pass hash to the **userpassword** param, use this command "$openssl passwd -1" to generate md5 hash.


To change default browser to firefox , just change the following param
```
     #usage in manifest
     browser1    =>  firefox    #for ubuntu
     browser2    =>  firefox    #for centos
```
``` 
     #usage in hiera
     vnc::browser1: firefox 	#for ubuntu
     vnc::browser2: firefox     #for centos
```

Module is successfully tested on Ubuntu14-64b and CentOS7-64b.

**NOTE**: You can not use multiple vncdisplay.

**NOTE**: please reboot the server after finished the catalog.

**Thank you , Have a great day!**

