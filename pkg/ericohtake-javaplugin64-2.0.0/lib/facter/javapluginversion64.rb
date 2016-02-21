#!/usr/bin/ruby
#
#
# author: Eric Ohtake
#
# The custom fact fetches the Java Plugin 64 bits version currently installed on the system.
#
# Example of the keys name found for each Java Plugin Version:
# - Key for the version v8u65 HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\4EA42A62D9304AC4784BF2681408560F
# - Key for the version v8u66 HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Installer\Products\4EA42A62D9304AC4784BF2681408660F
#
# You may want to install other versions on a testing machine and investigate its keys.



Facter.add('javaplugin64') do
  confine :kernel => :windows
  begin

    if RUBY_PLATFORM.downcase.include?('mswin') or RUBY_PLATFORM.downcase.include?('mingw32')
      require 'win32/registry'

      # This regex holds the Java version/update key string up to the where it is the same for all versions.
      regexp = '4EA42A62D9304AC4784BF268140.*'

      javaplugin64 = ''

      # Preparing the array that will hold the keys found in registry.
      versionkeys = Array.new

        # Opens the registry key, and uses the regex to match the root of the key. Then add all the matches to the array.
        Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\\Classes\\Installer\\Products') do | version |
          version.each_key do | key |
            if /#{regexp}/ =~ key
            versionkeys << key
            end
          end
        end

      # Uses the key found above to open the values accordingly to the version.
      versionkeys.each do | versionkey |
        Win32::Registry::HKEY_LOCAL_MACHINE.open("SOFTWARE\\Classes\\Installer\\Products\\#{versionkey}") do |reg|
          reg.each do | name,type,data |
            if name.eql?('ProductName')
              javaplugin64 << data.concat('; ')
            end
          end
        end
      end
    end
  end
  setcode do
    javaplugin64.chomp('; ')
  end
end