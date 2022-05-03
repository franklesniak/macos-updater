# Determining if a macOS **upgrade** or **update** is required

## Using the Terminal (command line interface/CLI)

### First, determine the newest available version of macOS

At the Terminal, enter the following command to list the available versions of macOS:

    softwareupdate --list-full-installers

The output should look something like the following:
![softwareupdate --list-full-installers shows the available versions of macOS](/docs/list_available_versions_of_macOS_in_Terminal.png)

In this example, the newest available version is `12.3.1`.
Note this version number, as you will reference it later in this process.

Finally, in this example, note that the **major** version number is `12`.
You will need to know the latest available major version later in this process.

### Next, determine the currently running version of macOS

At the Terminal, enter the following comand to list the currently installed version of macOS:

    sw_vers -productVersion

The output should look something like the following:
![sw_vers -productVersion shows the currently-installed version of macOS](/docs/show_currently_installed_version_of_macOS_in_Terminal.png)

In this example, the currently-installed version is `12.2.1`.
Note this version, as you will need it later in this process.

Finally, in this example, the **major** version is `12`.
Note this currently installed major version because, again, you will need it in later in the process.

### Knowing the lastest version and the currently installed version of macOS, determine if you need to **upgrade** or **update** the installed version of macOS

If the *latest available major version* is greater than the *currently installed major version*, then you will need to **upgrade** macOS.

 > In the example provided, the *latest available major version* and the *currently installed major version* were both 12, so there was no need to upgrade macOS.

If you don't need to **upgrade** macOS but the *newest available version* of macOS is greater than the *currently installed version*, then an **update** is required.

> In the example provided, a macOS upgrade was not required.
However, the newest available version of macOS was 12.3.1 and the currently installed version of macOS was 12.2.1.
Therefore, in the example, a macOS update is required.

[Take me back to the list of steps](../README.md)
