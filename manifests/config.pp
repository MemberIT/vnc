class vnc::config (
    $username               =  $vnc::vncusername,
    $ensure                 =  $vnc::ensure,
    $userpassword           =  $vnc::userpassword,                #pass password as hash
    $vncpassword            =  $vnc::vncpassword,                 #pass password as string
    $comment                =  "managed by puppet",
    $managehome             =  true,
) inherits ::vnc {
    validate_string($comment,$username)
    validate_re($ensure, '^present$|^absent$')
    validate_bool($managehome)
   
    if ($username != 'undef') {  
        user { "user creation":
           name             => $username,
           ensure           => $ensure,
           password         => $userpassword,
           managehome       => $managehome,
           comment          => $comment,
           before           => File['password_script'],
        }
        file { "password_script":
           ensure           =>  file,
           path             =>  "/home/${username}/vnc_passwd.sh",
           mode             =>  '0755',
           content          =>  template('vnc/password_fo_vnc.erb'),
           require          =>  User['user creation'],
        }
        case $::operatingsystem {
           'CentOS',
           'RedHat' :  {  
             exec { "set_vnc_pass":
                command     =>  "/usr/bin/bash /home/${username}/vnc_passwd.sh ${vncpassword} && /usr/bin/rm /home/${username}/vnc_passwd.sh",
                require     =>  File['password_script'],
                before      =>  File['xstartup file'],
             }
           }
           /^(Debian|Ubuntu)$/: { 
             exec { "set_vnc_pass":
                command     =>  "/bin/bash /home/${username}/vnc_passwd.sh ${vncpassword} && /bin/rm /home/${username}/vnc_passwd.sh",
                require     =>  File['password_script'],
                before      =>  File['xstartup file'],
             }
           }
        }
        case $::operatingsystem {
           /^(Debian|Ubuntu)$/: {
             file { "xstartup file":
                ensure      =>  present,
                mode        =>  '0755',
                content     =>  template('vnc/xstartup.erb'),
                path        =>  "/home/${username}/.vnc/xstartup",
                owner       =>  $username,
                group       =>  $username,
             }
           }
           'CentOS',
           'RedHat' :  {
              file { "xstartup file":
                ensure      =>  present,
                mode        =>  '0755',
                content     =>  template('vnc/xstartup_rpm.erb'),
                path        =>  "/home/${username}/.vnc/xstartup",
                owner       =>  $username,
                group       =>  $username,
              }
           }
        }
        file { "/home/${username}/.fluxbox/":
           ensure           => directory,
           owner            => $username,
           group            => $username,
           mode             => '0755',
           before           => File['menu file'],
        }
        case $::operatingsystem {
           /^(Debian|Ubuntu)$/: {
             file { "menu file":
               name         =>  "/home/${username}/.fluxbox/menu",
               ensure       =>  present,
               content      =>  template('vnc/menu.erb'),
               owner        =>  $username,
               group        =>  $username,
             }
           }
           'CentOS',
           'RedHat': {
              file { "menu file":
                name        =>  "/home/${username}/.fluxbox/menu",
                ensure      =>  present,
                content     =>  template('vnc/menu_rpm.erb'),
                owner       =>  $username,
                group       =>  $username,
              }
           }
        }     
    }
}
