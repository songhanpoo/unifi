#!/bin/sh

# Files needed
pwd=`pwd`
. $pwd/unifi-api.sh



vouchers=`awk -F "[,:]" '{for(i=1;i<=NF;i++){if($i~/id\042/){print $(i+1)} } }' vouchers.tmp | sed 's/\"//g'`

for code in $vouchers
do
    line3=${code:0:24}
        id=$line3
        echo $id
        unifi_login
        unifi_delete_voucher $id
        unifi_logout
done
