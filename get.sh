#!/bin/sh

# Files needed
pwd=`pwd`
. $pwd/unifi-api.sh



vouchers=`awk -F "[,:]" '{for(i=1;i<=NF;i++){if($i~/time\042/){print $(i+1)} } }'$

for code in $vouchers
do
    line3=${code:0:24}
        create_time=$line3
        echo " $create_time" >> time.tmp

done
getvoucher=`awk '!a[$0]++' time.tmp`
echo " $getvoucher" >> final.txt
