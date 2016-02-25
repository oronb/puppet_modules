#java.pp
class artifactory_i::java (
$package_java_name    = $artifactory_i::params::package_java_name
) inherits artifactory_i::params {
   package { "${package_java_name}":
   #provider => $repo_type,
   ensure   => 'installed',
    }
}

