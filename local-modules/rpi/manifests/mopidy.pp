class mopidy {

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
             ]: ensure => installed }

}
