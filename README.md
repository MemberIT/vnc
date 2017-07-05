# VNC module for Puppet

Module is going to manage the vnc server 

Module is successfully tested on Ubuntu 14 and CentOS 7.

It will install vncserver fluxbox and also google-chrome is the default browser.
also configure of user and fluxbox and create boot startup script to start on runtime.

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

you can pass hash to the **userpassword** param using this command "$openssl passwd -1" to generate md5 hash.

**NOTE**: You have to pass the plaintext password for **vncpassword** param.
**NOTE**: You can not use multiple vncdisplay,

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

**Thank you , Have a great day!**

