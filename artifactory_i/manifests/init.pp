# == Class: artifactory
#
# This class installs and configures artifactory
#
#
# === Parameters
#
# [*ensure*]
#   String.  Version of artifactory to be installed or latest/present
#   Default: latest
#
# [*version*]
#   String.  Version of artifactory to be installed or latest/present
#   Default: latest
#
# [*java_version*}
#   String.  Version of java be installed or latest/present
#   Default: latest
#
# === Examples
#
# * Installation:
#     class { 'artifactory': }
#
#
# === Authors
#   Oron Bortman <oronb:orong1234@gmail.com
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class artifactory_i(
  $ensure           = 'latest',
  $version          = '4.4.3',
  $java_version     = '8',
  $ajp_port         = '8019',
) {
  
  class { 'artifactory_i::java': } ->
  class { 'artifactory_i::install': } ->
  class { 'artifactory_i::config': } ->
  class { 'artifactory_i::service': }

}
