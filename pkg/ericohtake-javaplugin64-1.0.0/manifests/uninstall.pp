# Class: javaplugin64::uninstall
#
# Uninstalls Java Plugin 64 if a version if provided in javaplugin64::params
#
# It will pass an uninstall string to the msiexe command.
#
# The message confirming the uninstall will be issued.
# One more check is done issuing that sys is also updated with newest version.

class javaplugin64::uninstall (
  $uninstall_string  = $javaplugin64::params::uninstall_string,
  $uninstall_message = $javaplugin64::params::uninstall_message,
) inherits javaplugin64::params {

  exec { 'Uninstall Previous Version' :
    command => "MsiExec.exe /qn /X${uninstall_string} /norestart",
    path    => 'C:\windows\system32',
  }

  notify { 'Success! ':
    name => $uninstall_message,
  }

  case $::javaplugin64 {
    /\.*Java 8 Update 71/: { include javaplugin64::current_version_message }
    default: {}
  }
}
