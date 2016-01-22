# Class: javaplugin64::params
#
#
# Set variables for installation path, package name, install options, current
# version message, uninstall strings and uninstall messages.
#

class javaplugin64::params {
  $pkg_name                = 'Java 8 Update 71 (64-bit)'
  $source_path             = 'C:\apps\plugins\java64\jre-8u71-windows-x64.exe'
  $install_options         = '/s'
  $current_version_message = 'The most recent version of Java is installed!'

  case $::javaplugin64 {
    /\.*Java 8 Update 60/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418060FF}'
      $uninstall_message = 'The version 8 update 60 was uninstalled'
    }

    /\.*Java 8 Update 65/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418065FF}'
      $uninstall_message = 'The version 8 update 65 was uninstalled'
    }

    /\.*Java 8 Update 51/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418051FF}'
      $uninstall_message = 'The version 8 update 51 was uninstalled'
    }

    /\.*Java 8 Update 45/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418045FF}'
      $uninstall_message = 'The version 8 update 45 was uninstalled'
    }

    /\.*Java 8 Update 40/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418040FF}'
      $uninstall_message = 'The version 8 update 40 was uninstalled'
    }

    /\.*Java 8 Update 31/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418031FF}'
      $uninstall_message = 'The version 8 update 31 was uninstalled'
    }

    /\.*Java 8 Update 25/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418025FF}'
      $uninstall_message = 'The version 8 update 25 was uninstalled'
    }

    /\.*Java 7 Update 55/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86417055FF}'
      $uninstall_message = 'The version 7 update 55 was uninstalled'
    }

    /\.*Java 7 Update 51/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86417051FF}'
      $uninstall_message = 'The version 7 update 51 was uninstalled'
    }

    /\.*Java 7 Update 45/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86417045FF}'
      $uninstall_message = 'The version 7 update 45 was uninstalled'
    }

    /\.*Java 7 Update 25/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86417025FF}'
      $uninstall_message = 'The version 7 update 25 was uninstalled'
    }

    /\.*Java 7 Update 21/: {
      $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86417021FF}'
      $uninstall_message = 'The version 7 update 21 was uninstalled'
    }

    default: {}
  }
}
