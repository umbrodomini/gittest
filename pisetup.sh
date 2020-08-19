#! /bin/bash
echo "Installing Git if you dont have one"
sudo apt-get install git -y >> /dev/null
echo "Starting Setup!"
curl -LJO https://raw.githubusercontent.com/umbrodomini/gittest/master/settings.json
echo -n "Enter IP address: "
read ipaddress
ipaddress=$ipaddress/24
echo $ipaddress

start_time="$(date -u +%s)"

echo Updating repos
sudo apt-get update >> logs.txt 
if [ $? -eq 0 ]; then
echo "Update Successful"
else echo &tail logs.txt
fi
echo Upgrading Pi
sudo apt-get upgrade -y  >> logs.txt
if [ $? -eq 0 ] ; then
echo "Upgrade Successful"
else echo &tail logs.txt
fi
echo Installing transmission-daemon nmap curl ntfs-3g git awscli zip
sudo  apt-get install transmission-daemon nmap curl ntfs-3g git awscli zip -y >> logs.txt  2>&1
echo "install successfull"
echo "creating Book local directory and changing permissions"
sudo mkdir /media/Book
sudo chmod 0777 /media/Book
echo Getting UUID of sda1
book=$(sudo blkid -o value -s UUID /dev/sda1)
echo UUID : $book
echo creating automount on fstab
echo UUID=$book /media/Book ntfs-3g defaults,auto,users,rw,nofail 0 0 | sudo tee -a /etc/fstab  
echo "successfully appended to /etc/fstab"

echo stopping transmission-daemon
sudo systemctl stop transmission-daemon
sudo cp /home/pi/settings.json /etc/transmission-daemon/
echo enabling transmission-daemon
sudo systemctl enable transmission-daemon
echo starting transmission-daemon
sudo systemctl start transmission-daemon
printf "Transmission Configured Successfully"


printf "interface eth0\n\
static ip_address=$ipaddress\n\
static routers=192.168.1.1\n\
static domain_name_servers=192.168.1.1" | sudo tee -a  /etc/dhcpcd.conf
printf "/n"
echo "static IP address set to  $ipaddress"

echo "SETUP COMPLETE!"
echo some housekeeping....
#rm -rf  pisetup* settings.json
echo "DONE!!"

end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for process"


