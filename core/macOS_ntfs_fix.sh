#!/bin/bash
# Using Docker on MacOS is a bit complicated cause osxfs is slower than ntfs for mounting shared folders.
# That's why you need to launch this little fix to prevent everything and dev smoothly.
# 
# 
# Be sur to remove from Docker -> Preferences -> Shared Folder everything ( /Users, /volumes, /Privates) except /tmp.
#


# Clean /etc/exports — prevent error from old VM exports (Vagrant, ...)
sudo cp /etc/exports /etc/exports.backup
sudo rm /etc/exports
sudo touch /etc/exports

# Clean /tmp/d4m-* — flush old d4m's cache folders
sudo rm -R /tmp/d4m-*

# Fetch d4m-ntfs
cd ~
git clone https://github.com/IFSight/d4m-nfs ~/d4m-nfs
cd ~/d4m-nfs
echo $STARCOMMAND_PATH:$STARCOMMAND_PATH > ./etc/d4m-nfs-mounts.txt

# Apply d4m-nfs
./d4m-nfs.sh -q

cd $STARCOMMAND_PATH
printf "\n	✔  MacOS NTFS fix applied with success. \n"
