# Resource: artifactory::artifact
#
# This resource downloads Maven Artifacts from Artifactory
#
# Parameters:
# [*ensure*] : If 'present' checks the existence of the output file (and downloads it if needed), if 'absent' deletes the output file, if not set redownload the artifact
# [*gav*] : The artifact groupid:artifactid:version (mandatory)
# [*packaging*] : The packaging type (jar by default)
# [*classifier*] : The classifier (no classifier by default)
# [*repository*] : The repository such as 'public', 'central'... (defaults to 'releases' or 'snapshots' depending on the version specified in gav
# [*output*] : The output file (defaults to the resource name)
#
# Actions:
# If repository is set, its setting will be honoured.
# If repository is not set, its value is derived from the version contained in *gav*.  If the *gav* version is a SNAPSHOT then the repository will be set to 'snapshots', otherwise it will be 'releases'.
# If ensure is set to 'present' the resource checks the existence of the file and download the artifact if needed.
# If ensure is set to 'absent' the resource deleted the output file.
# If ensure is not set or set to 'update', the artifact is re-downloaded.
#
# Sample Usage:
#   class artifactory {
#     url      => 'http://artifactory.domain.com:8081',
#     username => 'user',
#     password => 'password',
#   }
#
#   artifactory::artifact {'Zabbix JMX client':
#     ensure => present,
#     gav    => 'org.kjkoster:zapcat:1.2.8',
#     output => '/usr/share/java/zapcat.jar',
#   }
#
#   artifactory::artifact {'/usr/share/java/jna.jar':
#     ensure     => present,
#     repository => 'thirdparty-releases',
#     gav        => "net.java:jna:3.4.1",
#   }
#
#   artifactory::artifact {'/tmp/distribution.tar.gz':
#     ensure      => present,
#     gav         => 'com.domain.procect:distribution:0.9.2-SNAPSHOT',
#     packaging   => 'tar.gz',
#     timestamped => true,
#   }
#
define artifactory::artifact (
  $user         = undef,
  $password     = undef,
  $url          = undef,
  #$ensure      = present,
  $jenkins_build = undef,
  $repository    = undef,
  $output        = undef,
  $path          = undef,
  $type          = undef,

)   {
#     if $url == '' {
#    fail('Cannot initialize the Artifactory class - the url parameter is mandatory')
#  }
#   $artifactory_url = $url
#
#   if ($user != '') and ($password == '') {
#    fail('Cannot initialize the Artifactory class - both username and password must be set')
#  } elsif ($user == '') and ($password != '') {
#    fail('Cannot initialize the Artifactory class - both username and password must be set')
#  } elsif ($user == '') and ($password == '') {
#    $authentication = false
#  } else {
#    $authentication = true
#    $user = $username
#    $pwd = $password
  #}
 
#  file { '/opt/artifactory-script':
#    ensure => directory
#  }
        #class { 'artifactory::artifact': }

  Exec { path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'], }
	
	file { "/tmp/download_artifactory.sh":
	       source  => "puppet:///modules/artifactory/download_artifactory.sh",	  
	       owner    => 'root',
  	       mode     => '0777'
	}
	file { "/${output}/${jenkins_build}":
                source  => "puppet:///modules/artifactory/${jenkins_build}"
        }
	file { "/tmp/unzip.sh":
               source  => "puppet:///modules/artifactory/unzip.sh",
               owner    => 'root',
               mode     => '0777'
        }

	
	exec {'download artifactory':
		command => "/tmp/download_artifactory.sh ${url} ${repository} ${output} ${user} ${password} ${jenkins_build}"
              }
	
        if $type == "zip"
	{
		exec {'unzip':
			command => "/tmp/unzip.sh ${path} ${jenkins_build} ${output}"
		 }
	}
  }
