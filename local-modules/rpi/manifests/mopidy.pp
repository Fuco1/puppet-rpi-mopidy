class mopidy {

  package { 'libffi-dev': ensure => installed }

  python::pip { 'cffi':
    ensure => '1.10.0',
    owner => 'root',
    require => [
                Class['python'],
                Package['libffi-dev'],
                ],
  }

  apt::source { 'mopidy':
    location => 'http://apt.mopidy.com/',
    release => 'jessie',
    repos => 'main contrib non-free',
    key => {
      id => '9E36464A7C030945EEB7632878FD980E271D2943',
      server => 'hkp://keyserver.ubuntu.com:80',
    },
    include => { src => false },
    pin => 400
  }
  ->
  package { [
             'mopidy',
             'mopidy-spotify',
             ]:
    ensure => installed,
    require => Python::Pip['cffi'],
  }

  # Mopidy configuration to use pulseaudio
  file_line { '/etc/mopidy/mopidy.conf/pulseaudio1':
    path => '/etc/mopidy/mopidy.conf',
    line => '[audio]',
    require => Package['mopidy'],
  } ->
  file_line { '/etc/mopidy/mopidy.conf/pulseaudio2':
    path => '/etc/mopidy/mopidy.conf',
    after => '\[audio\]',
    line => 'output = pulsesink server=127.0.0.1'
  }

  # mpd configuration
  file_line { '/etc/mopidy/mopidy.conf/mpd1':
    path => '/etc/mopidy/mopidy.conf',
    line => '[mpd]',
    require => Package['mopidy'],
  } ->
  file_line { '/etc/mopidy/mopidy.conf/mpd2':
    path => '/etc/mopidy/mopidy.conf',
    after => '\[mpd\]',
    line => 'hostname = ::'
  }

}
