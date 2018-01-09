#!/bin/bash

# Author:   Stephen Bygrave - wegotoeleven
# Name:     jssSetup.sh
#
# Purpose:  Sets up a Tomcat, MySQL and a JSS based on the JSS webapp from Jamf
# Usage:    Vagrant Shell provisioner
#
# Version 1.0.0, 2018-01-07
#   SB - Initial Creation

# Use at your own risk. wegotoeleven will accept no responsibility for loss or
# damage caused by this script.

##### Set variables

# Do not change the below variables
logFile="/vagrant/logs/vagrantBuild.log"
logProcess="dplabSetup"

##### Declare functions

writelog ()
{
    /usr/bin/logger -is -t "${logProcess}" "${1}"
}

echoVariables ()
{
    writelog "Log Process is ${logProcess}"
    writelog "Log file is stored at ${logFile}"
}

installRequired ()
{
    # Update Package Manager
    apt update >> "${logFile}" 2>&1

    # Install OpenJDK, Tomcat, Unzip and Avahi
    writelog "Installing Apache 2..."
    apt install -y apache2 unzip avahi-daemon >> "${logFile}" 2>&1
}

configureApache ()
{
    # Create server folders
    mkdir -p /vagrant/server/Packages

    # Setup Available Site
    service apache2 stop
    writelog "Configuring Available Site..."
    sed -i "s/<VirtualHost \*:80>/<VirtualHost \*:8081>/g" "/etc/apache2/sites-available/000-default.conf"
    sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/vagrant\/server/g" "/etc/apache2/sites-available/000-default.conf"
    sed -i "s/ErrorLog \${APACHE_LOG_DIR}\/error.log/ErrorLog \/vagrant\/logs\/error.log/g" "/etc/apache2/sites-available/000-default.conf"
    sed -i "s/CustomLog \${APACHE_LOG_DIR}\/access.log combined/CustomLog \/vagrant\/logs\/access.log combined/g" "/etc/apache2/sites-available/000-default.conf"
    sed -i "/DocumentRoot/a \ \ \ \ \ \ \ \ <Directory /vagrant/server> \n\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Require all granted \n\ \ \ \ \ \ \ \ <\/Directory>" "/etc/apache2/sites-available/000-default.conf"

    # Change Apache port
    sed -i "s/Listen 80/Listen 8081/g" "/etc/apache2/ports.conf"

    # Start Tomcat
    service apache2 start
}

##### Run script

if [[ ! -d "/vagrant/logs" ]];
then
    mkdir "/vagrant/logs"
fi
chmod 777 "/vagrant/logs"

echoVariables
installRequired
configureApache
# configureJamfProServer

writelog "Script completed."
