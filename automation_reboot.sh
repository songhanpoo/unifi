#!/bin/bash
printf "
   _____                   __
  / ___/____  ____  ____ _/ /_  ____ _____  ____  ____  ____
  \__ \/ __ \/ __ \/ __ `/ __ \/ __ `/ __ \/ __ \/ __ \/ __ \
 ___/ / /_/ / / / / /_/ / / / / /_/ / / / / /_/ / /_/ / /_/ /
/____/\____/_/ /_/\__, /_/ /_/\__,_/_/ /_/ .___/\____/\____/
                 /____/                 /_/


"
#######################################################################
YOU CAN SCHEDULE REBOOT WITH BELOW EXAMPLE CRONTAB
#crontab -e
45 3 * * 2 /usr/local/bin/unifi/automation_reboot.sh
script will run 3:45 AM Tuesday every week
#######################################################################

# USER-CONFIGURABLE SETTINGS
username=
password=
known_hosts_file=/dev/null
uap_list=( 192.168.*.* ip your access point
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
