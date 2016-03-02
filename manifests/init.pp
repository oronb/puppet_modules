#cluster_2

class cluster2 (   
      $service = undef,
      $master  = undef,
      $port    = 8080,
     
) {
        exec { 'start ${service}':
               command => "/etc/init.d/${service} start; exit 1; echo 'finish success' > %2",
	       onlyif  => "/bin/nc -zv ${master} ${port}",
	       unless  => "/etc/init.d/${service} status",
               tries   => "5",
	       try_sleep => "10",
	}
        exec { 'stop ${service}':
               command => "/etc/init.d/${service} stop",
               unless  => "/bin/nc -zv ${master} ${port}",
	       onlyif  => "/etc/init.d/${service} status",
	}
}
