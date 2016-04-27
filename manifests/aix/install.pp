#init.pp

define ibm_installation_manager::windows::install (
$package_folder=undef,
$source = undef,
$install_tempdir_windows = "C:\Windows\Temp",
$log_file = "log",
$options="-log ${log_file} -acceptLicense"
$pkg = "installc.exe",){

 file { "${install_tempdir_windows}\\${pkg}":
  ensure => present,
  source => "puppet:///modules/test/${pkg}",
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
 }

 package { "${pkg}":
   ensure   => installed,
   source   => "${install_tempdir_windows}\\${package_folder}\\${pkg}",
   require  => File["${install_tempdir_windows}\\${pkg}"],
   install_options => ['/${options}'],
   }
}
