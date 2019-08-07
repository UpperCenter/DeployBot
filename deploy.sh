#!/bin/bash

#------------------------------------------------------#
# Made by UpperCenter (https://twitter.com/UpperCenter)
#------------------------------------------------------#

# A "Simple" script that will allow me to deploy a PHP 7.x / Laravel app to a VPS from Github with next to no config.

# Please don't shout at me saying that there are more efficient ways / better scripts out there that I could use. I don't care.

# If you stumble across this script and don't know what you're doing, I take no responsibility for anything that you mess up.

# Check the "licence" file for more information.

# exit when any command fails
set -e
echo ""

# Full System Update
/bin/echo -e "\e[1;33mAttempting Full System Update...\e[0m"
sudo apt update
/bin/echo -e "\e[1;32mFull System Update Complete!\e[0m"

# Wait 3 Seconds
sleep 3s

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

# Changing Timezone
/bin/echo -e "\e[1;33mChanging Timezone...\e[0m"
sudo dpkg-reconfigure tzdata
/bin/echo -e "\e[1;32mTimezone Configured!\e[0m"

echo ""

# Install Some less Important Tools
/bin/echo -e "\e[1;33mAInstalling Additional Tools...\e[0m"
sleep 2s
sudo apt install figlet lolcat update-motd zip unzip fail2ban -y
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

echo ""

# Wait 5 Seconds
sleep 5s

##########################
# MySQL Instalation Section
##########################

# Downloading MySQL Server 8.0
/bin/echo -e "\e[1;33mDownloading MySQL 8.0 .deb File...\e[0m"
curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
/bin/echo -e "\e[1;32mFile Downloaded!\e[0m"

echo ""

# Installing MySQL .deb File
/bin/echo -e "\e[1;33mInstalling MySQL .deb File...\e[0m"
figlet LEAVE DEFAULTS! | lolcat
sleep 6s
sudo dpkg -i mysql-apt-config*
/bin/echo -e "\e[1;32mFile Installed!\e[0m"

echo ""

# Signing MySQL Key
/bin/echo -e "\e[1;33mSigning The MySQL APT Key...\e[0m"
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 8C718D3B5072E1F5
/bin/echo -e "\e[1;32mKey Signature Added!\e[0m"

echo ""

# Wait 3 Seconds
sleep 3s

# Full System Update
/bin/echo -e "\e[1;33mPerforming System Update...\e[0m"
sudo apt update
/bin/echo -e "\e[1;32mUpdate Complete!\e[0m"

echo ""

# Removing DEP File
/bin/echo -e "\e[1;33mRemoving Downloaded .deb File...\e[0m"
sudo rm mysql-apt-config*
/bin/echo -e "\e[1;32mRemove Complete!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s

# INSTALLING MYSQL
/bin/echo -e "\e[1;33mINSTALLING MYSQL...\e[0m"
sudo apt install mysql-server -y
figlet MYSQL INSTALLED!!! | lolcat

echo ""
echo ""

# Checking MySQL Serice Status
/bin/echo -e "\e[1;33mChecking MySQL Service Status...\e[0m"
sudo systemctl status mysql
/bin/echo -e "\e[1;32mStatus 1!\e[0m"

echo ""

# Showing MySQL Version
/bin/echo -e "\e[1;33mChecking MySQL Version...\e[0m"
echo ""
/bin/echo -e "\e[1;31mENTER ROOT PASSWORD!!\e[0m"
sleep 3
mysqladmin -u root -p version
/bin/echo -e "\e[1;32mVersion Confirmed!\e[0m"

# Wait 5 Seconds
sleep 5s

echo ""

# Securing MySQL
/bin/echo -e "\e[1;33mStarting Secure MySQL Installer...\e[0m"
echo ""
/bin/echo -e "\e[1;31mENTER ROOT PASSWORD!!\e[0m"
sleep 3
sudo mysql_secure_installation
/bin/echo -e "\e[1;32mSecure Instalation Complete!\e[0m"

################################
# Installing PHP & Requirements
################################

echo ""

# Installing PHP from APT
/bin/echo -e "\e[1;33mInstalling PHP 7.x And Requirements...\e[0m"
sleep 5s
sudo apt install php-fpm php-mysql php-mbstring -y
/bin/echo -e "\e[1;32mInstalation Complete!\e[0m"
sleep 5s

# Checking Installed PHP Version
/bin/echo -e "\e[1;33mChecking PHP Version...\e[0m"
echo ""
php -v | lolcat
echo ""
/bin/echo -e "\e[1;32mVersion Verified!\e[0m"

echo ""

# Downloading Private GIT Repositories
/bin/echo -e "\e[1;33mDownloading Private GIT Configs...\e[0m"
echo ""
sleep 5s
/bin/echo -e "\e[1;33mPlease Input Config URL:\e[0m"
echo "-->"
read url1
echo ""
sleep 3
git clone $url1
echo ""
/bin/echo -e "\e[1;32mDownload Complete!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s

# Move Downloaded PHP.ini To Correct Folder
/bin/echo -e "\e[1;33mMoving PHP.ini To Correct Folder...\e[0m"
sleep 5s
sudo mv Configs/php.ini /etc/php/7.2/fpm/php.ini
/bin/echo -e "\e[1;32mTransfer Complete!\e[0m"
echo ""

# Wait 5 Seconds
sleep 5s

# Restarting PHP Services
/bin/echo -e "\e[1;33mRestarting PHP Services...\e[0m"
sudo systemctl restart php7.2-fpm.service
/bin/echo -e "\e[1;32mService Restarted!\e[0m"
echo ""

# Checking PHP Status
/bin/echo -e "\e[1;33mChecking New PHP Status...\e[0m"
sudo systemctl status php7.2-fpm.service
echo ""
/bin/echo -e "\e[1;32mCheck Complete!\e[0m"

# Wait 5 Seconds
sleep 5s

# Creating Nginx Log Folders
/bin/echo -e "\e[1;33mCreating Nginx Log Folders...\e[0m"
sudo mkdir /var/www
sleep 2s
sudo mkdir /var/www/nginx
/bin/echo -e "\e[1;32mFolders Created!\e[0m"
echo ""

# Wait 3 Seconds
sleep 3s

# Move Downloaded Nginx Configs To Correct Folder
/bin/echo -e "\e[1;33mMoving Nginx Configs To Correct Folders...\e[0m"
sleep 5s
sudo mv Configs/nginx.conf /etc/nginx/nginx.conf
echo ""
/bin/echo -e "\e[1;32mNginx.conf Done!\e[0m"
sudo mv Configs/mirrorwood.conf /etc/nginx/conf.d/mirrorwood.conf
echo ""
/bin/echo -e "\e[1;32mMirrorWood.conf Done!\e[0m"
echo ""
/bin/echo -e "\e[1;32mAll Transfers Complete!\e[0m"
sleep 6s
echo ""

# Move Downloaded Nginx Configs To Correct Folder
/bin/echo -e "\e[1;33mTesting & Restarting Nginx Services...\e[0m"
nginx -t | systemctl restart nginx.service
/bin/echo -e "\e[1;32mServices Restarted & All Tests Passed!\e[0m"
sleep 8s

echo ""

# Delete Old Configs Folder
/bin/echo -e "\e[1;33mRemoving Old Config Folder...\e[0m"
sudo rm -rf Configs
/bin/echo -e "\e[1;32mFolder Removed!\e[0m"

echo ""

# Downloading FoM Source Code
/bin/echo -e "\e[1;33mDownloading MirrorWood Source Code...\e[0m"
echo ""
sleep 5s
/bin/echo -e "\e[1;33mPlease Source Code Config URL:\e[0m"
echo "-->"
read url2
echo ""
sleep 3
git clone $url2
echo ""
/bin/echo -e "\e[1;32mDownload Complete!\e[0m"

echo ""

# Moving MirrorWood Files To Correct Location
/bin/echo -e "\e[1;33mMoving Source Code...\e[0m"
echo ""
sudo mkdir -p /var/www/laravel
sleep 2s
sudo mv -v MirrorWood/* /var/www/laravel/
sleep 5s
/bin/echo -e "\e[1;32mMove Complete!\e[0m"

echo ""

# Reloading Nginx
/bin/echo -e "\e[1;33mReloading Nginx...\e[0m"
sudo systemctl restart nginx.service
/bin/echo -e "\e[1;32mRestart Complete!\e[0m"

echo ""

# Downloading Private MOTD Repo
/bin/echo -e "\e[1;33mDownloading Private GIT MOTD Repo...\e[0m"
echo ""
sleep 5s
/bin/echo -e "\e[1;33mPlease Input Config URL:\e[0m"
echo "-->"
read url3
echo ""
sleep 3
git clone $url3
echo ""
/bin/echo -e "\e[1;32mDownload Complete!\e[0m"

echo ""

# Removing Old MOTD Files
/bin/echo -e "\e[1;33mRemoving Old MOTD Files...\e[0m"
sudo rm -rf /etc/update-motd.d/*
/bin/echo -e "\e[1;32mDelete Complete!\e[0m"

echo ""

# Moving New MOTD Files To Folder
/bin/echo -e "\e[1;33mAdding New MOTD Files To System...\e[0m"
sudo mv -v Update-MOTD/* /etc/update-motd.d/
/bin/echo -e "\e[1;32mMove Complete!\e[0m"


echo ""

# Wait 5 Seconds
sleep 5s

# Testing Configuration
/bin/echo -e "\e[1;33mUpdating MOTD...\e[0m"
clear
update-motd
echo ""
/bin/echo -e "\e[1;32mUpdate Done!\e[0m"

# Wait 8 Seconds
sleep 8s

echo ""

# Create Temp SWAP File
/bin/echo -e "\e[1;33mCreating Temporary SWAP File...\e[0m"
sudo fallocate -l 8G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo ""
/bin/echo -e "\e[1;32mSWAP Created!\e[0m"

# Wait 5 Seconds
sleep 5s

# Install Composer
/bin/echo -e "\e[1;33mInstalling Composer...\e[0m"
clear
cd ~
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
/bin/echo -e "\e[1;32mComposer Installed!\e[0m"

echo ""

/bin/echo -e "\e[1;33mChecking Composer Status...\e[0m"
clear
composer
echo ""
/bin/echo -e "\e[1;32mComposer Verified!\e[0m"

sleep 5s
