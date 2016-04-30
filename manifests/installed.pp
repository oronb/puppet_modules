#/etc/puppetlabs/code/environments/production/modules/ibm_installation_manager/manifests/windows/install.pp

class ibm_installation_manager::installed (
$package_name="IBM Installation Manager",
$pkg_folder="Install_Mgr_V1.6.2",
$source = "puppet:///modules/ibm_installation_manager/Install_Mgr_V1.6.2",
$install_tempdir_windows = "C:\Windows\Temp",
$options="-log installation_manager -acceptLicense",
$install = "installc.exe",)

{
  Exec {
   path => 'C:\Windows\System32' }

 file { "${install_tempdir_windows}\\${pkg_folder}":
  ensure => present,
  source => "${source}",
  #source => "puppet:///modules/ibm_installation_manager/Install_Mgr_V1.6.2_Win_WASV8.5.5",
  recurse => true,
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
  notify => File["package.ps1"],
 }

 file { "package.ps1":
  ensure => present,
  path   => "$install_tempdir_windows\\package.ps1",
  source => "puppet:///modules/ibm_installation_manager/package.ps1",
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
  notify => Exec["install"],
  
 }

  exec {"install":
   command  => "cmd.exe /c $install ${options}",
   cwd          => "${install_tempdir_windows}\\${pkg_folder}",
   #refreshonly  => true,
   logoutput    => true,
    unless => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File $install_tempdir_windows\\package.ps1",
    require      => File["package.ps1"],
  }

}
