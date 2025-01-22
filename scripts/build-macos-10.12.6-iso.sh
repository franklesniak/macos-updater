# Thanks to Cody Krieger for providing a workaround for the busted macOS Sierra
# installer
# See: https://krieger.io/creating-bootable-macos-sierra-installation-media-on-macos-catalina/

OS_NAME="macOS Sierra"
OS_VERSION="10.12.6"

# In the "Use a web browser for older versions" section on this website:
# https://support.apple.com/en-us/102662
# download macOS Sierra 10.12 (InstallOS.dmg).
# Make sure the file downloaded is named "InstallOS.dmg" and is in your Downloads
# folder.
#
# Alternatively, run the following to perform the download:
curl -o "$HOME/Downloads/InstallOS.dmg" http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg

# Mount the newly-downloaded InstallOS.dmg disk image
hdiutil attach "$HOME/Downloads/InstallOS.dmg" -noverify -nobrowse -mountpoint /Volumes/Install\ macOS

# Extract the contents of the installer package to your desktop
pkgutil --expand-full /Volumes/Install\ macOS/InstallOS.pkg "$HOME/Desktop/InstallOS"

# Unmount the InstallOS.dmg file
hdiutil detach /Volumes/Install\ macOS

# Delete the downloaded InstallOS.dmg
rm "$HOME/Downloads/InstallOS.dmg"

# Copy .app to your /Applications folder
sudo ditto "$HOME/Desktop/InstallOS/InstallOS.pkg/Payload/Install $OS_NAME.app" "/Applications/Install $OS_NAME.app"

# Copy InstallESD.dmg to the SharedSupport directory within the installer app bundle
cp "$HOME/Desktop/InstallOS/InstallOS.pkg/InstallESD.dmg" "/Applications/Install $OS_NAME.app/Contents/SharedSupport"

# Delete the extracted contents of the installer package from the desktop
rm -rf "$HOME/Desktop/InstallOS"

# Fix the bundle version string in the .app Info.plist
sed -i '' -e 's/12\.6\.06/12.6.03/' "/Applications/Install $OS_NAME.app/Contents/Info.plist"

# Create a blank drive of 21000mb with a Single Partition - Apple Partition Map
hdiutil create -o "/tmp/macOS-$OS_VERSION.cdr" -size 21000m -layout SPUD -fs HFS+J

# Mount the blank drive
hdiutil attach "/tmp/macOS-$OS_VERSION.cdr.dmg" -noverify -nobrowse -mountpoint /Volumes/install_build

# Copy the installation media to the blank drive
sudo "/Applications/Install $OS_NAME.app/Contents/Resources/createinstallmedia" --volume /Volumes/install_build --applicationpath "/Applications/Install $OS_NAME.app" --nointeraction

# Unmount the volume automatically mounted from the .app
hdiutil detach "/Volumes/Install $OS_NAME"

# Delete the .app
sudo rm -rf "/Applications/Install $OS_NAME.app"

# Create a sparseimage
hdiutil convert "/tmp/macOS-$OS_VERSION.cdr.dmg" -format UDSP -o "/tmp/macOS-$OS_VERSION"

# Remove the no-longer-needed .cdr.dmg file
rm "/tmp/macOS-$OS_VERSION.cdr.dmg"

# Auto-size the sparseimage
hdiutil resize -size `hdiutil resize -limits "/tmp/macOS-$OS_VERSION.sparseimage" | tail -n 1 | awk '{ print $1 }'`b "/tmp/macOS-$OS_VERSION.sparseimage"

# Convert the sparseimage to ISO/CD master
hdiutil convert "/tmp/macOS-$OS_VERSION.sparseimage" -format UDTO -o "/tmp/macOS-$OS_VERSION"

# Remove the no-longer-needed sparseimage
rm "/tmp/macOS-$OS_VERSION.sparseimage"

# Rename the ISO image and move it to the desktop
mv "/tmp/macOS-$OS_VERSION.cdr" "$HOME/Desktop/macOS-$OS_VERSION.iso"

#######################################################################################
# To install macOS Sierra 10.12.6 in a virtual machine, boot the virtual machine to the
# ISO then select your language. Make sure the virutal machine has an Internet
# connection. Using the menu, select Utilities, then Terminal. Once in Terminal, run
# the following command:
# ntpdate -vu time.apple.com
# This ensures your virtual machine has the correct time. Once the time is correct,
# you can now install macOS Sierra 10.12.6. Exit Terminal by clicking the Terminal menu
# and selecting Quit Terminal. Then, click the Install macOS menu item to begin the
# installation process.
