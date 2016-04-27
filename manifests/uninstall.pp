#/etc/puppetlabs/code/environments/production/modules/ibm_installation_manager/manifests/windows/install.pp

class ibm_installation_manager::install (
$pkg_folder="Install_Mgr_V1.6.2_Win_WASV8.5.5",
$source = "puppet:///modules/ibm_installation_manager/${pkg_folder}",
$install_tempdir_windows = "C:\Windows\Temp",
$log_file = "log",
$options="-log ${log_file} -acceptLicense",
$pkg = "installc.exe",)

{

 file { "${install_tempdir_windows}\\${pkg_folder}":
  ensure => present,
  source => "puppet:///modules/test/${pkg_folder}",
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
 }

 package { "${pkg}":
   ensure   => installed,
   source   => "${install_tempdir_windows}\\${pkg_folder}\\${pkg}",
   require  => File["${install_tempdir_windows}\\${pkg_folder}"],
   install_options => ['/${options}'],
 }

}
