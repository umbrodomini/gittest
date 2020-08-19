#! /bin/bash
echo "Installing Git if you dont have one"
sudo apt install git -y >> /dev/null
echo fetching the setup script
mkdir pisetup
git clone https://github.com/umbrodomini/gittest.git /home/pi/pisetup
unzip /home/pi/pisetup/piscript.zip -d /home/pi
chmod +x pisetup.sh
./pisetup.sh
echo Starting the setup!
echo SETUP COMPLETE!
echo some housekeeping....
#rm -rf  pisetup* settings.json
echo DONE!!
