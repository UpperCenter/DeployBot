#------------------------------------------------------#
# Made by UpperCenter (https://twitter.com/UpperCenter)
#------------------------------------------------------#

# A "Simple" script that will allow me to deploy a PHP 7.x / Laravel app to a VPS from Github with next to no config.

# Please don't shout at me saying that there are more efficient ways / better scripts out there that I could use. I don't care.

# If you stumble across this script and don't know what you're doing, I take no responsibility for anything that you mess up.

# Check the "licence" file for more information.

#!/bin/bash

# exit when any command fails
set -e
echo ""

# Full System Update
/bin/echo -e "\e[1;33mAttempting Full System Update...\e[0m"
sudo apt update
/bin/echo -e "\e[1;32mFull System Update Complete!\e[0m"

# Wait 5 Seconds
sleep 5s

echo ""

# Full System Upgrade
/bin/echo -e "\e[1;33mAttempting Full System Upgrade...\e[0m"
sudo apt full-upgrade -y
/bin/echo -e "\e[1;32mFull Upgrade Comlete!\e[0m"

echo ""

# Remove Old Libs & Dependencies
/bin/echo -e "\e[1;33mAttempting To Remove Old Dependencies...\e[0m"
sudo apt autoremove -y
/bin/echo -e "\e[1;32mAutoremove Complete!\e[0m"

# Wait 5 Seconds
sleep 5s
echo ""

# Install Some less Important Tools
/bin/echo -e "\e[1;33mAInstalling Additional Tools...\e[0m"
sudo apt install figlet lolcat update-motd zip unzip -y
/bin/echo -e "\e[1;32mInstalation Complete!\e[0m"

echo ""

# Add the Nginx Signing Key
/bin/echo -e "\e[1;33mAttempting To Download Nginx Signing Key...\e[0m"
sudo wget https://nginx.org/keys/nginx_signing.key
/bin/echo -e "\e[1;32mDownloaded Nginx Signing Key!\e[0m"

echo ""

# Add The NginX Signing Key To System
/bin/echo -e "\e[1;33mAttempting To Add Signing Key To System...\e[0m"
sudo apt-key add nginx_signing.key
/bin/echo -e "\e[1;32mAdded Signing Key To System!\e[0m"

echo ""

# Add Nginx Sources To Sources.list
/bin/echo -e "\e[1;33mAdding Nginx Source to sources.list...\e[0m"
sudo echo 'deb https://nginx.org/packages/mainline/ubuntu/ bionic nginx' >> /etc/apt/sources.list
/bin/echo -e "\e[1;32mAdded Source!\e[0m"

echo ""
# Wait 5 Seconds
sleep 5s

###########################################################################################################
# Enabling This Causes A URI Parse Error Inside Of sources.list
# Add Nginx Sources To Sources.list
#/bin/echo -e "\e[1;33mAdding Second Nginx Source to sources.list...\e[0m"
#sudo echo 'deb deb-src https://nginx.org/packages/mainline/ubuntu/ bionic nginx' >> /etc/apt/sources.list
#/bin/echo -e "\e[1;32mAdded Second Source!\e[0m"

# echo ""
###########################################################################################################

# Remove Nginx Signing Key
/bin/echo -e "\e[1;33mDeleting Signing Key...\e[0m"
sudo rm nginx_signing.key
/bin/echo -e "\e[1;32mSigning Key Removed!\e[0m"

echo ""

# Perform full Sys Update
/bin/echo -e "\e[1;33mRefreshing Repositories...\e[0m"
sudo apt update
/bin/echo -e "\e[1;32mRepositories Updated!\e[0m"

echo ""
echo ""

# Wait 5 Seconds
sleep 5s

# Install Nginx
/bin/echo -e "\e[1;33mINSTALLING NGINX...\e[0m"
sudo apt install nginx
figlet NGINX INSTALLED!!! | lolcat

echo ""
echo ""

# Check Nginx Version
/bin/echo -e "\e[1;33mChecking Installed Nginx Version...\e[0m"
nginx -v | lolcat

echo ""

# Restart Nginx Service
/bin/echo -e "\e[1;33mInitialising Nginx Service...\e[0m"
sudo systemctl restart nginx
/bin/echo -e "\e[1;32mService Primed!\e[0m"

# Wait 5 Seconds
sleep 5s

echo ""

# Check Nginx Status
/bin/echo -e "\e[1;33mChecking Nginx Service Status...\e[0m"
sudo systemctl status nginx.service
echo ""
curl -I 127.0.0.1
/bin/echo -e "\e[1;32mStatus 1 / Verified!\e[0m"

# Wait 2 Seconds
sleep 2s