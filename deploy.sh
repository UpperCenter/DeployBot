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

# Install Some Important Tools
/bin/echo -e "\e[1;33mInstalling Additional Tools...\e[0m"
sleep 2s
sudo apt install figlet lolcat update-motd zip unzip software-properties-common fail2ban apache2-utils -y
/bin/echo -e "\e[1;32mInstalation Complete!\e[0m"

echo ""

# Installing CertBot Stuff
/bin/echo -e "\e[1;33mAdding CertBot PPA...\e[0m"
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install certbot python-certbot-nginx 
/bin/echo -e "\e[1;32mCertBot PPA Added & Installed!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s

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
sleep 3
/bin/echo -e "\e[1;32mVersion Confirmed!\e[0m"

# Wait 5 Seconds
sleep 5s

echo ""

# Securing MySQL
/bin/echo -e "\e[1;33mStarting Secure MySQL Installer...\e[0m"
echo ""
/bin/echo -e "\e[1;31mENTER ROOT PASSWORD!!\e[0m"
sudo mysql_secure_installation
/bin/echo -e "\e[1;32mSecure Instalation Complete!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s

# Restore MySQL Backup
/bin/echo -e "\e[1;33mRestoring MySQL Database & Tables...\e[0m"
echo ""
mysqladmin -u root -p create infern_data
echo ""
/bin/echo -e "\e[1;33mDatabase Created...\e[0m"
echo ""
mysql -u root -p infern_data < SQL-Backup.sql
echo ""
/bin/echo -e "\e[1;32mRestore Complete!\e[0m"
sleep 2s 

echo ""

# Add MySQL User Details
/bin/echo -e "\e[1;33mAdd New User & Rights...\e[0m"
sleep 2
echo ""
mysql -u root -p
echo ""
sleep 2
/bin/echo -e "\e[1;32mUser Created!\e[0m"

################################
# Installing PHP & Requirements
################################

echo ""

# Installing PHP from APT
/bin/echo -e "\e[1;33mInstalling PHP 7.2 And Requirements...\e[0m"
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

echo ""

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
sudo rm -rf /etc/nginx/conf.d/default
echo ""
/bin/echo -e "\e[1;32mMirrorWood.conf Done!\e[0m"
echo ""
sleep 1
/bin/echo -e "\e[1;32mAll Transfers Complete!\e[0m"
sleep 6s
echo ""

# Move Downloaded Nginx Configs To Correct Folder
/bin/echo -e "\e[1;33mTesting & Restarting Nginx Services...\e[0m"
nginx -t | systemctl restart nginx.service
/bin/echo -e "\e[1;32mServices Restarted & All Tests Passed!\e[0m"
sleep 8s

echo ""

# Downloading PHP Backup Utility
/bin/echo -e "\e[1;33mDownloading PHPBU...\e[0m"
wget http://phar.phpbu.de/phpbu.phar
chmod +x phpbu.phar
sudo mv phpbu.phar /usr/local/bin/phpbu
phpbu --version
echo ""
/bin/echo -e "\e[1;32mPHP Backup Utility Installed!\e[0m"
echo ""

# Wait 5 Seconds
sleep 5s 

# Creating PHPBU Folder
/bin/echo -e "\e[1;33mCreating PHPBU Folder...\e[0m"
sudo mkdir -p /var/www/mysql-backup
/bin/echo -e "\e[1;32mPHP Backup Utility Folder Created!\e[0m"

echo ""

# Moving PHPBU To Folder
/bin/echo -e "\e[1;33mMoving PHPBU Config To Correct Folder...\e[0m"
sudo mv Configs/backup.xml /var/www/mysql-backup/backup.xml
/bin/echo -e "\e[1;32mMove Complete!\e[0m"

echo ""

# Wait 3 Seconds
sleep 3s 

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
echo ""
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
git clone https://github.com/UpperCenter/Update-MOTD.git
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

# Downloading PHPMyAdmin
/bin/echo -e "\e[1;33mDownloading & Installing Latest PHPMyAdmin File From Source...\e[0m"
echo ""
cd
cd /usr/share
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.zip
echo ""
unzip phpMyAdmin-4.9.0.1-all-languages.zip
mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin
sudo chown -R www-data:www-data /usr/share/phpmyadmin
sudo chmod -R 755 /usr/share/phpmyadmin
echo ""
/bin/echo -e "\e[1;32mPHPMyAdmin Downloaded & Installed!\e[0m"

cd
echo ""

# Setting Security Page
/bin/echo -e "\e[1;33mCreating PHPMA Password...\e[0m"
htpasswd -c /etc/nginx/.htpasswd infernette
/bin/echo -e "\e[1;32mPassword Created!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s 

# Disable Root Login PHPMA
/bin/echo -e "\e[1;33mDisabling PHPMyAdmin Root Login...\e[0m"
cd
cd /usr/share/phpmyadmin
sudo mv config.sample.inc.php config.inc.php
/bin/echo -e "\e[1;33mAdd $cfg['Servers'][$i]['AllowRoot'] = FALSE;...\e[0m"
sleep 8s
nano config.inc.php
cd
systemctl restart nginx.service
systemctl restart php7.2-fpm.service
echo ""
/bin/echo -e "\e[1;32mRoot Login Disabled!\e[0m"
sleep 2s

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

# Wait 5 Seconds
sleep 5s

echo ""

# Moving To Laravel Folder
/bin/echo -e "\e[1;33mMoving to /var/www/laravel...\e[0m"
cd /var/www/laravel/
/bin/echo -e "\e[1;32mDone!\e[0m"
sleep 2s

echo ""

# Remove Vendor File
/bin/echo -e "\e[1;33mRemoving Vendor File...\e[0m"
sudo rm -rf vendor/
/bin/echo -e "\e[1;33mFile Deleted...\e[0m"

echo ""

# Make .env File
/bin/echo -e "\e[1;33mMake .ENV File...\e[0m"
sudo mv Env-Example .env
/bin/echo -e "\e[1;32m.env File Created!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s

# Installing Composer
/bin/echo -e "\e[1;33mInstalling Composer...\e[0m"
echo ""
composer install --no-dev
echo ""
/bin/echo -e "\e[1;32mComposer Dependencies Installed!\e[0m"

# Wait 5 Seconds
sleep 5s 

echo ""

# Setting Folder Permissions
/bin/echo -e "\e[1;33mSetting Folder Permissions...\e[0m"
sudo chown -R :www-data /var/www/laravel
sudo chmod -R 775 /var/www/laravel/storage
sudo chmod -R 775 /var/www/laravel/bootstrap/cache
/bin/echo -e "\e[1;32mPermissions Set!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s 

# Restarting Nginx Services
/bin/echo -e "\e[1;33mRestarting Services...\e[0m"
systemctl restart nginx.service
systemctl restart php7.2-fpm.service
/bin/echo -e "\e[1;32mServices Restarted!\e[0m"

# Generating Enc Keys
echo ""
/bin/echo -e "\e[1;33mGenerating New Encryption Key...\e[0m"
echo ""
php artisan key:generate
/bin/echo -e "\e[1;32mKey Created!\e[0m"

# Wait 5 Seconds
sleep 5s 

echo ""

# Clearing Artisan Cache
/bin/echo -e "\e[1;33mClearing Artisan Cache...\e[0m"
php artisan config:clear
php artisan config:cache
echo ""
/bin/echo -e "\e[1;32mCache Cleared!\e[0m"

# Wait 5 Seconds
sleep 5s 

# Restarting Nginx Services
/bin/echo -e "\e[1;33mRestarting Services...\e[0m"
systemctl restart nginx.service
systemctl restart php7.2-fpm.service
/bin/echo -e "\e[1;32mServices Restarted!\e[0m"

echo ""

figlet MOST SERVER SHIT DONE | lolcat

echo ""

# Wait 5 Seconds
sleep 5s 

echo ""

# Adding APP KEY Again Because Fuck Me Thats Why
/bin/echo -e "\e[1;33mGenerating APP KEY Again Because It Never Works 1st Time...\e[0m"
cd
cd /var/www/laravel
php artisan key:generate
echo ""
php artisan config:clear
echo ""
php artisan config:cache

/bin/echo -e "\e[1;32mAPP KEY Added & Cache Cleared!\e[0m"

echo ""

# Downloading Cron Files
/bin/echo -e "\e[1;33mDownloading Crons...\e[0m"
sudo mkdir -p /var/www/crons
git clone https://github.com/UpperCenter/Crons.git
echo ""
/bin/echo -e "\e[1;32mDownload Complete!\e[0m"

echo ""

# Creating Cron Folder & Moving
/bin/echo -e "\e[1;33mCreating Cron Folders & Moving...\e[0m"
sudo mv Crons/* /var/www/crons/
/bin/echo -e "\e[1;32mCrons Moved!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s 

# Adding Cron Scripts To Cron
echo ""
/bin/echo -e "\e[1;33mInstalling Crons...\e[0m"
echo ""
/bin/echo -e "\e[1;31mCOPY THESE NOW!!\e[0m"
echo ""
echo ""
sleep 10
echo "*/30 * * * *  php /var/www/crons/run_scours.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "*/30 * * * *  php /var/www/crons/run_creche.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "*/5 * * * *  php /var/www/crons/run_battle.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "00 00 * * *  php /var/www/crons/run_contests.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "59 23 * * *  php /var/www/crons/run_raffle_clicks.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "59 23 * * sat  php /var/www/crons/run_clans.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "10 * * * *  php /var/www/crons/run_areas.php > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "10 3 * * *  php  /usr/local/bin/phpbu --configuration=/var/www/mysql-backup/backup.xml > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "0 2 * * * php /var/www/crons/run_weather > /var/www/crons/logs/errors.log 2>&1"
echo ""
echo "0 19 * * * php /var/www/crons/run_weather > /var/www/crons/logs/errors.log 2>&1"
echo ""
sleep 10s
echo ""
crontab -e
echo ""
/bin/echo -e "\e[1;32mCrontab Updated!\e[0m"

echo ""

/bin/echo -e "\e[1;33mInstalling MirrorWood CertBot Certificate...\e[0m"
sudo certbot --nginx
echo ""
/bin/echo -e "\e[1;33mTesting Auto Renew...\e[0m"
echo ""
sudo certbot renew --dry-run
/bin/echo -e "\e[1;32mSSL Certificate Installed & Tested!\e[0m"

# Cleaning Up Un-needed Files
/bin/echo -e "\e[1;33mPerforming Final Cleanup...\e[0m"
cd
sudo rm /usr/share/phpMyAdmin-4.9.0.1-all-languages.zip
sudo rm SQL-Backup.sql
sudo rm -rf Crons/
sudo rm -rf MirrorWood/
sudo rm -rf Update-MOTD/
/bin/echo -e "\e[1;32mFiles Removed!\e[0m"

echo ""

# Wait 5 Seconds
sleep 5s 

/bin/echo -e "\e[1;33mPerforming Full Final Reboot In 10 Seconds...\e[0m"
/bin/echo -e "\e[1;33m10\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;33m9\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;33m8\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;33m7\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;33m6\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;31m5\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;31m4\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;31m3\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;31m2\e[0m"
sleep 1
echo ""
/bin/echo -e "\e[1;31m1\e[0m"
sleep 1
echo ""

sudo reboot now

# TO DO
# Add CertBot stuff
# Add Blowfish to PHPMyAdmin

echo ""