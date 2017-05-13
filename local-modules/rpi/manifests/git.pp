class git {

  file { "${home[$user]}/.gitconfig":
    source => "puppet:///modules/rpi/git/.gitconfig",
    owner => $user,
    group => $user,
    mode => 0644,
    ensure => present
  }

}
