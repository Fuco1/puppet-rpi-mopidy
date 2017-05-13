$home = {
  pi => '/home/pi',
  root => '/root',
}

node default {
  $user = 'pi'

  file { "${home[$user]}": ensure => directory } ->
  user { "$user":
    ensure => present,
    home => "${home[$user]}",
  }

  include apt
  Class['apt::update'] -> Package<| |>

  include rpi

}
