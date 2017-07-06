class vnc::service (
      $service_ensure      =  running,
      $service_enable      =  true,
      $vncport             =  $vnc::vncport,
    ){ 
   
      validate_string($service_ensure)
      validate_bool($service_enable)
   
    case $::operatingsystem {
      'CentOS',
      'RedHat' : {
          exec { "check vncport":
             command       => "/usr/bin/sed -i 's/= 5900 +/= ${vncport} +/' /usr/bin/vncserver ",
             onlyif        => ['/usr/bin/test -f /usr/bin/vncserver'],
          }
      }
      /^(Debian|Ubuntu)$/: {
          exec { "check vncport":
             command       => "/bin/sed -i 's/= 5900 +/= ${vncport} +/' /usr/bin/vnc4server",
             onlyif        => ['/usr/bin/test -f /usr/bin/vnc4server'],
          }
      }
    }->
    case $::operatingsystem {
      'CentOS',
      'RedHat' :  {
          file { "startup script":
             ensure        =>  present,
             mode          =>  0755,
             path          =>  '/etc/init.d/vncserver',
             content       =>  template('vnc/vncserver_redhat.erb'),
          }->
          file { "/etc/rc.d/rc3.d/S11vncserver":
             ensure        =>  'link',
             target        =>  '../init.d/vncserver',
             require       =>  File["startup script"],
          }->
          service { 'vncserver startup':
              name          =>  'vncserver',
              ensure        =>  $service_ensure,
              start         =>  "/etc/init.d/vncserver start",
              stop          =>  "/etc/init.d/vncserver stop",
              status        =>  "/etc/init.d/vncserver status",
              pattern       =>  '/etc/init.d/vncserver',
          }
      }
      /^(Debian|Ubuntu)$/: {
          file { "startup script":
             ensure        =>  present,
             mode          =>  0755,
             path          =>  '/etc/init.d/vncserver',
             content       =>  template('vnc/vncserver_debian.erb'),
          }->
          service { 'vncserver startup':
             name           =>  'vncserver',
             ensure         =>  $service_ensure,
             enable         =>  $service_enable,
          }
      }
    }
}
