# Starts tomcat instance only if another tomcat's instance started
# Example:
# tomcat::tomcat_start { 'default' :
#  master_port      => 8080
#  master_service   => tomcat_server_1
#  depended_service => tomcat_server_2
# }

define cluster::service (
	$type              = $::cluster::type,
	$master            = $::cluster::master,
	$depended          = $::cluster::depended,
        $master_port       = undef,
	$master_service    = undef,
	$depended_service  = undef,
) {
	case $type {
	  'master': {
	            service { "${master_service}": 
	             name   => "${master_service}",
	             ensure => running,
	             }
		   }
	  'depended': {
		     file { '/tmp/ensure_service':
	               ensure  => present,
	               mode    => '755',
	               #source  => "puppet:///modules/cluster/ensure_service",       
		       content => file('cluster/ensure_service'),
		       notify  => File['/tmp/check_service'],
	              }
	             file { '/tmp/check_service':
	               ensure  => present,
	               mode    => '755',
	               #source  => "puppet:///modules/cluster/check_service",
		       content => file('cluster/check_service'),
		       notify  => Exec['service'],
	              }
	             exec {'service':
	              command => "/tmp/check_tomcat ${master} ${master_port} ${depended_service} ${depended}",
		      require => File['/tmp/ensure_service','/tmp/check_service'],
	              }
	         }
	}
}
