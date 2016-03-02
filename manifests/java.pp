#java.pp
class artfiactory::java (
$package_java_name    = $artfiactory::params::package_java_name
) inherits artfiactory::params {
   package { "${package_java_name}":
   #provider => $repo_type,
   ensure   => 'installed',
    }
}

