class pulseaudio {

  package { 'pulseaudio': ensure => installed }

  file_line { '/etc/pulse/default.pa':
    path => '/etc/pulse/default.pa',
    line => 'load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1',
    require => Package['pulseaudio'],
  }

}
