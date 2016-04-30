#check.pp
define ibm_installation_manager::windows (
 $status           = undef,
 $package          = "IBM Installation Manager",
 $install_folder   = "Install_Mgr_V1.6.2",
 $source           = "puppet:///modules/ibm_installation_manager/Install_Mgr_V1.6.2",
 $tempdir          = "C:\Windows\Temp",
 $install_options  = "-log installation_manager -acceptLicense",
 $uninstall_folder = "C:\Documents and Settings\All Users\Application Data\IBM\Installation Manager\uninstall", ) 
{

 Exec {
  path => 'C:\Windows\System32' }

 file { "package.ps1":
  ensure => present,
  path   => "${tempdir}\\package.ps1",
  source => "puppet:///modules/ibm_installation_manager/package.ps1",
  owner  => "administrator",
  group  => ["administrators","everyone"],
  mode   => "1777",
 }

 case $status {

  'installed': {

   $action="installc.exe"

    file { "${tempdir}\\${install_folder}":
     ensure => present,
     source => "${source}",   
     recurse => true, 
     owner  => "administrator",
     group  => ["administrators","everyone"],
     mode   => "1777", 
     notify => Exec["install"],
    }
  
   exec {"install":
    command  => "cmd.exe /c $action ${install_options}",
    cwd          => "${tempdir}\\${install_folder}",
    #refreshonly  => true,
    logoutput    => true,
    unless => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File ${tempdir}\\package.ps1 -package \"$package\"",
    require      => File["${tempdir}\\${install_folder}"],
   }

  }

  'absent': {

   $action = "uninstallc.exe"

   exec { 'uninstall':
    command      => "cmd.exe /c $action",
    cwd          => "${uninstall_folder}",
    #refreshonly     => true,
    onlyif => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Executionpolicy Unrestricted -File ${tempdir}\\package.ps1 -package \"$package\"",
    require => File["package.ps1"],
   }

  }
 }
}
