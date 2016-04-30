# == Class: installation_manager
#
# Manages the installation of IBM Install Manager
#
# === Parameters
#
# [*deploy_source*]
#   Specifies whether this module should deploy the source or not. If set to
#   false, the InstallationManager installer is assumed to be already available
#   at $source_dir
#
#   Defaults to false.
#
# [*source*]
#   Source to the compressed archive from IBM. Required if 'deploy_source' is
#   true.
#
# [*target*]
#   Full path to install to.  Defaults to /opt/IBM/InstallationManager
#
# [*source_dir*]
#   Location to the InstallationManager installation directory - either from
#   the extracted archive or a manually extracted archive.  The 'installc'
#   tool should be inside this directory.
#
# [*options*]
#   Installation options to pass to the installer.
#   Defaults to: -acceptLicense -sP -log /tmp/IM_install.${date}.log.xml \
#     -installationDirectory ${target}
#
# [*user*]
#   User to run the installer as.  Defaults to 'root'
#
# [*group*]
#   Group to run the installer as.  Defaults to 'root'
#
# [*timeout*]
#   A timeout for the exec resource that installs IBM Installation Manager.
#   Installing it can take a while.  The default is '900'.
#   If you encounter issues where the exec has exceeded timeout, you may need
#   to increase this.
#
# === Examples
#
# class { 'installation_manager':
#   source     => '/mnt/IBM/IM.zip',
# }
#
# === Authors
#
# Author Name <beard@puppetlabs.com>
#
# === Copyright
#
# Copyright 2015 Puppet Labs, Inc, unless otherwise noted.
#
class ibm_installation_manager (
 $status           = undef,
 $package          = "IBM Installation Manager",
 $install_folder   = "Install_Mgr_V1.6.2",
 $source           = "puppet:///modules/ibm_installation_manager/Install_Mgr_V1.6.2",
 $tempdir          = "C:\Windows\Temp",
 $install_options  = "-log installation_manager -acceptLicense",
 $uninstall_folder = "C:\Documents and Settings\All Users\Application Data\IBM\Installation Manager\uninstall", )

) {
  case $osfamily {

  'Windows': {
	include ibm_installation_manager::windows
  }
 }
}

