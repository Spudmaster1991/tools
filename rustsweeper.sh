!/bin/bash
if [ "$1" == "" ]
then
echo "You forgot an netwrok address!"
echo "Syntax: ./rustsweep.sh 192.168.1 500"
elif [ "$2" == "" ]
then
echo "Input number of threads"
echo "Syntax ./rustsweep.sh 192.168.1 500"
else
start=$SECONDS
mkdir rustscan_results
for ip in `seq 1 254`; do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> ./rustscan_results/ips.txt &
done
cat ./rustscan_results/ips.txt
while read ipline; do
echo Scanning $ipline
rustscan -t $2 -T 1500 $ipline >> ./rustscan_results/$ipline.txt
done < ./rustscan_results/ips.txt
runtime=$(($SECONDS - $start))
ipnumb=$(wc -l ./rustscan_results/ips.txt | cut -d " " -f 1)

echo "--------!FINISHED!---------"
echo "Scanned $ipnumb IPs in $runtime seconds."
echo "---------------------------" 
fi
