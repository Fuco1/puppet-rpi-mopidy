class pulseaudio {

  package { 'pulseaudio': ensure => installed }
  package { 'pulseaudio-module-zeroconf': ensure => installed }
  package { 'avahi-daemon': ensure => installed }

  file_line { '/etc/pulse/default.pa/module-native-protocol-tcp':
    path => '/etc/pulse/default.pa',
    match => '^load-module\ module-native-protocol-tcp',
    line => 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;192.168.10.0/24;10.0.0.0/24',
    require => Package['pulseaudio'],
  }

  file_line { '/etc/pulse/default.pa/module-zeroconf-publish':
    path => '/etc/pulse/default.pa',
    line => 'load-module module-zeroconf-publish',
    require => Package['pulseaudio'],
  }

  # https://www.raspberrypi.org/forums/viewtopic.php?f=38&t=11124
  file_line { '/etc/modules':
    path => '/etc/modules',
    line => 'snd_bcm2835',
  }


  file { '/etc/systemd/system/pulseaudio.service':
    source => 'puppet:///modules/rpi/pulseaudio/pulseaudio.service',
    owner => root,
    group => root,
    mode => 0644,
    ensure => present,
    require => Package['pulseaudio'],
  }

  service { 'pulseaudio':
    enable => true,
    ensure => running,
    provider => systemd,
    require => File['/etc/systemd/system/pulseaudio.service'],
  }

  service { 'avahi-daemon':
    enable => true,
    ensure => running,
    require => Package['avahi-daemon'],
  }

}
