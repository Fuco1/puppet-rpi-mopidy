class librespot {

  file { "${home[$user]}/download": ensure => directory }

  exec { 'install librespot':
    command => "wget https://github.com/herrernst/librespot/releases/download/v20170413-d95c0b3/librespot-linux-armhf-raspberry_pi.zip -O librespot.zip && unzip librespot.zip",
    cwd     => "${home[$user]}/download/",
    creates => "${home[$user]}/download/librespot",
    path    => ['/usr/bin', '/usr/sbin',],
    require => File["${home[$user]}/download"],
  }

  file { "/etc/systemd/system/spotify-connect.service":
    source => "puppet:///modules/rpi/librespot/spotify-connect.service",
    owner => root,
    group => root,
    mode => 0644,
    ensure => present,
    require => Exec['install librespot'],
  }

  service { 'spotify-connect':
    enable => true,
    ensure => running,
    require => File['/etc/systemd/system/spotify-connect.service'],
  }

}
