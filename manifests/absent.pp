#/etc/puppetlabs/code/environments/production/modules/ibm_installation_manager/manifests/windows/install.pp

class ibm_installation_manager::absent (
$installation_folder="C:\Documents and Settings\All Users\Application Data\IBM\Installation Manager\uninstall",
$install_tempdir_windows = "C:\Windows\Temp",
$action = "uninstallc.exe",)

{

 Exec {
   path => 'C:\Windows\System32' 
 }

 file { "package.ps1":
  ensure => present,
  path   => "$install_tempdir_windows\\package.ps1",
  source => "puppet:///modules/ibm_installation_manager/package.ps1",
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
  notify => Exec['uninstall'],
 }

  exec { 'uninstall':
    command      => "cmd.exe /c $action",
    cwd          => "${installation_folder}",
    #refreshonly     => true,
    onlyif => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File $install_tempdir_windows\\package.ps1",
    require => File["package.ps1"],
  }

}
