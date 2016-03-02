#init.pp

class cluster (
        $type                   = undef,
        $master                 = undef,
        $depended               = undef,
) {
 file {'/tmp/test-puppet':
 ensure => present,
 content => "$type $master $depended",
 }
}
