#!/bin/bash
#Number of Addresses to Create
total=500
#Do Eeet
echo "Will Create $total Addresses"
for ((n=0;n<$total;n++))
do
 denarius.daemon getnewaddress >> address.txt
 sleep 1
 done
#Get Balance
denarius.daemon getbalance
balance=$(denarius.daemon getbalance)
echo "Wallet Balance: $balance D"
send=$(echo "($balance-0.1) / $total"|bc -l)
round=$(printf '%.*f\n' 8 $send)
echo "Amount to Send per Address: $round D"
#Append " and end " per line
sed 's/^/"/' address.txt >> pre.txt
sed 's/$/":'"$round"',/' pre.txt >> end.txt
sed '$ s/,$//g'  end.txt >> final.txt
rm pre.txt
rm end.txt
echo "Address List: address.txt"
echo "Sendmany List copy from: final.txt"
