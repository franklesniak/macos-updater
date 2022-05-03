# Determining if a macOS **upgrade** or **update** is required

## Using the Terminal (Command Line Interface/CLI)

At the Terminal, enter the following command to list the available versions of macOS:

    softwareupdate --list-full-installers

The output should look something like the following:
![softwareupdate --list-full-installers shows the available versions of macOS](/docs/list_available_versions_of_macOS_in_Terminal.png)

In this example, the newest available version is `12.3.1`.
Note this version number, as you will need it in a later step.

Finally, in this example, note that the **major** version number is `12`, as you will need to know the latest available major version in a later step.

[Take me back to the list of steps](../README.md)
