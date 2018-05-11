#!/bin/sh

sitename=(site1 site2)
# Files needed
#pwd=`pwd`
#. $pwd/unifi-api.sh

for i in ${sitename[@]};do
pwd=`pwd`
. $pwd/${i}.sh

# Generation settings
time=60 # Voucher time limit (minutes)
amount=3000 # New vouchers to generate

# HTML Settings
line1="WiFi Voucher"
line2="Valid for 60 minutes"
author="make by Hieu Hien Hoa"
# Generate vouchers
unifi_login
voucherID=`unifi_create_voucher $time $amount $note`
unifi_get_vouchers $voucherID > vouchers.tmp
unifi_logout

vouchers=`awk -F"[,:]" '{for(i=1;i<=NF;i++){if($i~/code\042/){print $(i+1)} } }' vouchers.tmp | sed 's/\"//g'`

# Build HTML
#if [ -e vouchers.html ]; then
#  echo "Removing old vouchers."
#  rm vouchers.html
#fi

echo '<html><head><link rel="stylesheet" href="style.css" /></head><body>' >> ${i}.html

for code in $vouchers
do
    line3=${code:0:5}" "${code:5:10}
    html='<div class="voucher"><div class="line1">'$line1'</div><div class="line2">'$line2'</div><div class="line3">'$line3'</div><div class="author">'$author'</div></div>'
    echo $html >> ${i}.html
done

echo "</body></html>" >> ${i}.html
done
# Remove tmp
#if [ -e vouchers.tmp ]; then
#  echo "Removing vouchers tmp file."
#  rm vouchers.tmp
#fi
cd /mnt
rm -rf *.html
cd /root/unifi-voucher-generator
cp -rf *.html /mnt/
