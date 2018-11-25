#!/bin/sh
printf "
   _____                   __
  / ___/____  ____  ____ _/ /_  ____ _____  ____  ____  ____
  \__ \/ __ \/ __ \/ __ `/ __ \/ __ `/ __ \/ __ \/ __ \/ __ \
 ___/ / /_/ / / / / /_/ / / / / /_/ / / / / /_/ / /_/ / /_/ /
/____/\____/_/ /_/\__, /_/ /_/\__,_/_/ /_/ .___/\____/\____/
                 /____/                 /_/


"

# Files needed
pwd=`pwd`
. $pwd/unifi-api.sh

# Generation settings
time=60 # Voucher time limit (minutes)
amount=3000 # New vouchers to generate
note=(hieutaocode)
# HTML Settings
line1="WiFi Voucher"
line2="Valid for 60 minutes"

# Generate vouchers
unifi_login
unifi_create_voucher $time $amount $note
unifi_get_vouchers > vouchers.tmp
unifi_logout
vouchers=`awk -F "[,:]" '{for(i=1;i<=NF;i++){if($i~/time\042/){print $(i+1)} } }' vouchers.tmp | sed 's/\"//g'`

for code in $vouchers
do
    line3=${code:0:24}
        create_time1=$line3
        echo " $create_time1" >> time.tmp

done
getvoucher=`awk '!a[$0]++' time.tmp`
echo " $getvoucher" >> final.txt

create_time=`head -n 1 final.txt`
echo $create_time
unifi_login
unifi_get_vouchers $create_time > final.tmp
unifi_logout


vouchers=`awk -F"[,:]" '{for(i=1;i<=NF;i++){if($i~/code\042/){print $(i+1)} } }' final.tmp | sed 's/\"//g'`


echo '<html><head><link rel="stylesheet" href="style.css" /></head><body>' >> vouchers.html

for code in $vouchers
do
    line3=${code:0:5}" "${code:5:10}
    html='<div class="voucher"><div class="line1">'$line1'</div><div class="line2">'$line2'</div><div class="line3">'$line3'</div></div>'
    echo $html >> vouchers.html
done
