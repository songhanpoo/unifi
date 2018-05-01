#!/bin/bash

#######################################################################
# A simple script for remotely rebooting a Ubiquiti UniFi access point
# Version 2.3 (Mar 28, 2018)
# by Steve Jenkins (http://www.stevejenkins.com/)
#
# Requires bash and sshpass (https://sourceforge.net/projects/sshpass/)
# which should be available via dnf, yum, or apt on your *nix distro.
#
# USAGE
# Update the user-configurable settings below, then run ./uap_reboot.sh from
# the command line. To reboot on a schedule, create a cronjob such as:
# 45 3 * * * /usr/local/bin/unifi-linux-utils/uap_reboot.sh > /dev/null 2>&1 #Reboot UniFi APs
# The above example will reboot the UniFi access point(s) every morning at 3:45 AM.
#######################################################################

# USER-CONFIGURABLE SETTINGS
username=admin
password=ubntSBVN
known_hosts_file=/dev/null
uap_list=( 10.7.1.50 10.7.1.51 10.7.1.52 10.7.53 10.10.1.50 10.10.1.51 10.11.1.50 10.11.1.51 10.12.1.50 10.13.1.5010.14.1.50 10.14.1.51 10.16.1.50 10.17.1.50 10.17.1.51 10.18.1.50 10.19.1.50 10.20.1.50 10.21.1.50 10.21.1.51 10.22.1.50 10.22.1.51 10.22.1.52 10.22.1.53 10.22.1.54 10.23.1.50 10.23.1.51 10.24.1.50 10.24.1.51 10.24.1.52 10.25.1.50 10.25.1.51 10.75.1.50 10.76.1.50 10.76.1.51 10.77.1.50 10.78.1.50 10.78.1.51 10.79.1.50 10.79.1.51 10.80.1.50
)

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE
for i in "${uap_list[@]}"
do

	echo "Rebooting UniFi access point at $i..."
	if sshpass -p $password ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" reboot; then
                echo "Reset $i thanh cong!" 1>&2
	else
                echo "reset $i khong thanh cong" 1>&2
	fi
done
exit 0
