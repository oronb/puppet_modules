#install Artifactory

class artifactory_i::install (
  $artifactory_type               = $artifactory_i::params::artifactory_type,
  $version                        = $artifactory_i::params::version,
  $user                           = $artifactory_i::params::user,
  $group                          = $artifactory_i::params::group,
  $source                         = $artifactory_i::params::source,
  $destination                    = $artifactory_i::params::destination,
  $ensure                         = $artifactory_i::params::ensure,
  $package_artifactory_name       = $artifactory_i::params::package_artifactory_name,
  $repo_type                      = $artifactory_i::params::repo_type,
  $repo_source                    = $artifactory_i::params::repo_source,
  $repo_provider                  = $artifactory_i::params::repo_provider,
) inherits artifactory_i::params{

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
