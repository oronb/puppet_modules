#== Class: artifactory::config
#
# This class configures artifactory.  It should not be called directly
#
#
# === Authors
#   Oron Boerman <oronb:orong1234@gmail.com
# * Justin Lambert <mailto:jlambert@letsevenup.com>

class artifactory_i::config (

  $ajp_port           = $::artifactory_i::ajp_port,
  $version            = $::artifactory_i::version,
  $destination        = $artifactory_i::params::destination,

) inherits artifactory_i::params {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { "${destination}/tomcat/conf/server.xml":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    mode    => '0444',
    content => template('artifactory_i/server.xml.erb'),
    #notify  => Class['artifactory::service'],
  }

  file { "/etc${destination}/default":
    ensure  => file,
    owner   => artifactory,
    group   => artifactory,
    content => template('artifactory_i/default.erb')
    #notify  => Class['artifactory::service']
  }
}
