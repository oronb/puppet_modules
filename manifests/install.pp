#install Artifactory

class artfiactory::install (
  $artifactory_type               = $artfiactory::params::artifactory_type,
  $version                        = $artfiactory::params::version,
  $user                           = $artfiactory::params::user,
  $group                          = $artfiactory::params::group,
  $source                         = $artfiactory::params::source,
  $destination                    = $artfiactory::params::destination,
  $ensure                         = $artfiactory::params::ensure,
  $package_artifactory_name       = $artfiactory::params::package_artifactory_name,
  $repo_type                      = $artfiactory::params::repo_type,
  $repo_source                    = $artfiactory::params::repo_source,
  $repo_provider                  = $artfiactory::params::repo_provider,
) inherits artfiactory::params{

   if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  user { "${user}":
     ensure => 'present',
     system => true,
     shell  => '/bin/bash',
     home   => '/var/opt/jfrog',
     gid    => "${group}",
  }

  group { "${group}":
     ensure => 'present',
     system => true,
  }

  package { 'wget':
     ensure => 'present'
  }

  exec { "download ${package_artifactory_name}":
    command => "wget -nc ${repo_source}",
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    cwd     => "${source}",
    #require => Package['wget'],
  } 

 if $artifactory_type == "undef" {
    package { "${package_artifactory_name}":
      provider => "${repo_provider}",
      ensure   => "${ensure}",
      source   => "/tmp/${package_artifactory_name}-${version}.${repo_type}",
      require  => Exec["download ${package_artifactory_name}"]
    }
 }
 else { 
         package { "${package_artifactory_name}":
         provider => "${repo_provider}",
         ensure   => "${ensure}",
         source   => "/tmp/${package_artifactory_name}-${version}.${repo_type}",
         require  => Exec["download ${package_artifactory_name}"]
         }   
 }

 file { "${destination}":
    ensure => 'directory',
    mode   => '0775',
    owner  => 'artifactory',
    group  => 'artifactory',
    require => Package["${package_artifactory_name}"]
  } 

}
