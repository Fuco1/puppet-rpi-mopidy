class rpi {

  class { 'python' :
    version    => 'system',
    pip        => 'present',
    dev        => 'present',
  }

  include mopidy
  include librespot
  include pulseaudio
  include git

  package { 'vim': ensure => installed }
  package { 'rpi-update': ensure => installed}
}
