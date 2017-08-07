class vnc::install (
      $ensure         =  installed,
      $browser1       =  $vnc::browser1,          #ubuntu default browser chrome
      $browser2       =  $vnc::browser2,          #centos default browser chrome
) inherits ::vnc {
   if $::operatingsystem      == 'Ubuntu' {
      $provider       =  apt
      $apps           =  [ 'fluxbox', 'expect','vnc4server','xfce4' ]

      apt::source { 'google-chrome':
         location     => '[arch=amd64] http://dl.google.com/linux/chrome/deb/',
         release      => 'stable',
         repos        => 'main',
         key     => {
             source   => 'https://dl.google.com/linux/linux_signing_key.pub',
             id       => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
         },
         include => {
               src    => false,
         },
      }-> 
      Class['apt::update'] -> 
      package { "${browser1}":
         ensure       => "${ensure}",
         provider     => "${provider}",
      }->
      package { $apps:
         ensure       => "${ensure}",
         provider     => "${provider}",
      }
   }

   if $::operatingsystem == 'CentOS' {
      $provider       =  yum
      $apps           =  [ 'tigervnc-server','xorg-x11-xinit','fluxbox','xterm','xarchiver','expect', 'liberation-sans-fonts']

      yumrepo { "google chrome repo":
          name        =>  'google-chrome',
          baseurl     =>  'http://dl.google.com/linux/chrome/rpm/stable/$basearch',
          gpgcheck    =>  0,
          enabled     =>  1,
      }  
      package { 'epel-release':
          name        => 'epel-release',
          ensure      => installed,
      }->
      package { "${browser2}" :
          ensure      => "${ensure}",
          provider    => "${provider}",
      }->
      package { $apps:
          ensure      => "${ensure}",
          provider    => "${provider}",
      }
   }	
}
