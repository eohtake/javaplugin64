# Class: javaplugin64
#
#
# Installs Java Plugin 64 if not present.
# User must provide an installer in the default path or provide a path with her
# own installer.
#

class javaplugin64 (
  $pkg_name         = $javaplugin64::params::pkg_name,
  $source_path      = $javaplugin64::params::source_path,
  $install_options  = $javaplugin64::params::install_options,
  ) inherits javaplugin64::params {

  package { $pkg_name :
    ensure          => installed,
    source          => $source_path,
    install_options => [$install_options],
  }

  # This first "if" is to prevent an error that is raised when this class runs
  # in a host without any version of Java installed yet.
  # When the class runs and installs Java, the facter fact will remain empty
  # until the next Puppet run.
  # Since the fact is empty, it will call the uninstaller class, because it is
  # different from the parameter $pkg_name.
  # If we call this class without any Java Plugin installed, Puppet will
  # produce an error.

  if $::javaplugin64 != '' {

    # This second "if" tests fact $::javaplugin64 against the parameter
    # $pkg_name.
    # If the current version of Java Plugin is not alone in the facter fact,
    # it means that there is an old version of it in the system that must be
    # uninstalled, hence the uninstall class include.

    if $pkg_name != $::javaplugin64 {
      include javaplugin64::uninstall
    }
  }
}
