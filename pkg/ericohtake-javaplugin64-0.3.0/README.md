# Java Plugin 64 - Install Module for Puppet
[![Puppet Forge](https://img.shields.io/badge/puppetforge-v0.3.0-blue.svg)](https://forge.puppetlabs.com/ericohtake/javaplugin64)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What javaplugin64 affects](#what-javaplugin64-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with javaplugin64](#beginning-with-javaplugin64)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Limitations](#limitations)
7. [Development](#development)

## Overview

This module installs the most recent version of Java Plugin (JRE) 64 bits. Version 8 update 66.
It also removes some older versions, as for example version 8 update 65. To see the full list, please refer to the reference section at the end of this page.

## Module Description

The module javaplugin64 solves the installation challenge that Java Runtime Environment presents to us.
To install a Java Plugin is pretty simple, however, a newer installation doesn't remove/upgrades the older versions automatically, which makes versions of Java to pile up in the system.

To make things even more challenging, to silent uninstall Java Plugins, we must provide the uninstall string found in Windows Registry and for each version the string changes!
This module finds out first, what is the version current installed in the system, and then provide an uninstall string if this version is meant to be uninstalled.
For clarity sake, the module only removes the versions provided in the `javaplugin64::params` class, but don't worry, you can provide your own versions and uninstall strings there.

To solve this problem a facter fact was created to run against the registry collecting versions of Java Plugin installed in a system.

The main class `javaplugin64` installs the latest Java version informed in the parameters.

After the installation, if another version of Java Plugin is found, the uninstaller class `javaplugin64::uninstall` is called which has its parameters fed by a case statement in the `javaplugin64::params` class.

Then, 2 messages will be issued, one stating the version that was uninstalled, and another saying the recent version was found in the system.

## Setup

### What javaplugin64 affects

* It will create a new facter fact in the system exposing versions of Java Plugin 64-Bits installed in the system.

* It installs a Java Plugin 64 bits in the system.

* It will uninstall a Java Plugin version that matches the parameters found in `javaplugin64::params`

* It might overwrite a Java Plugin configuration in a system. For example security prompts and turning on updates notification.

### Setup Requirements

* Since this module depends 100% on the facter fact `$::javaplugin64` *pluginsync* must be enabled.

* If the installer source comes from a network path, make sure the systems running the Puppet agent have full access to it.

* If you need to uninstall a version that is not listed in the classes available, add it to the `javaplugin64::params` class.

* If you need to install a different version of Java, not covered by this module, change/add it to the params class `javaplugin64::params`

### Beginning with javaplugin64

* To test, copy the module to your module path, and run `puppet apply` on its *examples* folder.

* Or after copying the module to your module path, classify your nodes on your the `site.pp file`.

* Put the installer on the folder `C:\apps\plugins\java64\jre-8u66-windows-x64.exe`.

* Or provide your installer source path overriding `$javaplugin64::params::source_path` param.

## Usage

- If you place the Java Plugin installer in the default source folder, you just need to include the class in your `site.pp` file:

```puppet
# C:\ProgramData\PuppetLabs\code\environments\production\manifests\site.pp
#
# Default installer folder and most recent Java Plugin name:
# C:\apps\plugins\java64\jre-8u66-windows-x64.exe

node 'default' {
   class { 'javaplugin64': }
}
```

- Do you have a different installer source folder or file name? No problem! Override the `$javaplugin64::params::source_path` parameter:

```puppet
node 'default' {
  class { 'javaplugin64':
    source_path => 'C:\users\you\desktop\jre-8u66-windows-x64.exe',
  }
}
```

- When a new version of Java Plugin is available, (or the silent install switch changes) you just need to override the parameters:

```puppet
node 'default' {
  class { 'javaplugin64':
    pkg_name        => 'Java 9 Update 25 (64-bit)',
    source_path     => 'C:\apps\plugins\java64\jre-9u25-windows-x64.exe',
    install_options => "/q",
  }
}
```

- As an example run `puppet apply C:\ProgramData\PuppetLabs\code\environments\production\manifests` to install Java during tests and then follow the workflow to test with your ENC *before* sending to production.

- This module has been tested on Foreman 1.9.2 and Puppet Enterprise 2015.3 executed well on 200+ nodes running Windows 7 and Windows 10

- You may want to remove versions code that will not be used in your infrastructure to make the `javaplugin64::params` cleaner.

## Expanding

### When to expand

* You will want to expand this module when a new version of Java Plugin is released or when you want to uninstall a version that is not present in the `javaplugin64::params` class.

* To make this module capable of removing another Java Plugin version, find out the uninstall string for the version you want to remove, then add it to the case statement at `javaplugin64::params`
 It is not possible to override the parameters for the uninstaller, since it is only executed after an include on the `javaplugin64` class.

```puppet
class javaplugin64::params {
  $pkg_name        = 'Java 8 Update 66 (64-bit)'
  $source_path     = 'C:\apps\plugins\java64\jre-8u66-windows-x64.exe'
  $install_options = "/s"

  case $::javaplugin64 {
    /\.*Java 8 Update 60/: { $uninstall_string  = '{26A24AE4-039D-4CA4-87B4-2F86418060F0}'   # << Adapt the regex to your Java Plugin version and change to the appropriate uninstal string.
                             $uninstall_message = 'The version 8 update 60 was uninstalled'  # << Change the message accordingly.
    }
  }
}
```

## Reference

* Versions uninstalled by this module:

Please check the `params.pp` file.

* Facter fact included under `lib\facter` folder

`$::javaplugin64`

* Parameters that can be overridden:

`$pkg_name`
`$source_path`
`$install_options`

* Classes

`javaplugin64`

`javaplugin64::params`

`javaplugin64::uninstall`

`javaplugin64::current_version_message`

## Limitations

- This module uninstall only Java Plugin 64-Bits versions.

## Development

* Clone this module and if you want to add features to it, please, send a pull request.
* You can fork it and post your own version, give the credit if you think you I deserve it. :-)
