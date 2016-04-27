#/etc/puppetlabs/code/environments/production/modules/ibm_installation_manager/manifests/windows/install.pp

class ibm_installation_manager::install (
$pkg_folder="C:\ProgramData\IBM\Installation Manager\uninstall",
$pkg = "uninstallc.exe",)

{

 package { "${pkg}":
   ensure   => installed,
   source   => "\\${pkg_folder}\\${pkg}",
   require  => File["\\${pkg_folder}"],
 }

}
