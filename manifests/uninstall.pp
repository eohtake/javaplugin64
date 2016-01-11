class javaplugin64::uninstall (
  $uninstall_string  = $javaplugin64::params::uninstall_string,
  $uninstall_message = $javaplugin64::params::uninstall_message,
) inherits javaplugin64::params {

  exec { 'Uninstall Previous Version' :
    command     => "MsiExec.exe /qn /X$uninstall_string /norestart",
    path        => 'C:\windows\system32',
  }

  notify { 'Success! ':
    name => $uninstall_message,
  }

  case $::javaplugin64 {
    /\.*Java 8 Update 66/: { include javaplugin64::current_version_message }
    default: {}
  }
}
