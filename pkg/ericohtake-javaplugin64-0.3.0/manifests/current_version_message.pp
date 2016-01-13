# Class: javaplugin64::current_version_message
#
#
# Notifies the system, after a version uninstall, that there is a current
# version installed.
#
#

class javaplugin64::current_version_message (
  $current_version_message = $javaplugin64::params::current_version_message,
) inherits javaplugin64::params {

  notify {$current_version_message:}
}
