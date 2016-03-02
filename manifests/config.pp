#== Class: artifactory::config
#
# This class configures artifactory.  It should not be called directly
#
#
# === Authors
#   Oron Boerman <oronb:orong1234@gmail.com
# * Justin Lambert <mailto:jlambert@letsevenup.com>

class artfiactory::config (

  $ajp_port           = $::artfiactory::ajp_port,
  $version            = $::artfiactory::version,
  $destination        = $artfiactory::params::destination,

) inherits artfiactory::params {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { "${destination}/tomcat/conf/server.xml":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    mode    => '0444',
    content => template('artfiactory/server.xml.erb'),
    #notify  => Class['artifactory::service'],
  }

  file { "/etc${destination}/default":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    content => template('artfiactory/default.erb')
    #notify  => Class['artifactory::service']
  }
}
