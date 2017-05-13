class rpi {

  include mopidy
  include git

  package { 'vim': ensure => installed }
  package { 'rpi-update': ensure => installed}
}
