class rpi {

  include mopidy
  include git

  package { 'vim': ensure => installed }
}
