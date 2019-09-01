#!/bin/bash

echo Running initial server setup...
echo Logged in as $USER

# Create new user
echo Creating new user
read -p "Enter new UNIX username: " username
'sudo adduser $username'

# Grant administrative privileges
echo Granting administrative privileges
usermod -aG sudo $username

# Set up a basic firewall
echo Setting up a basic firewall
ufw allow OpenSSH
ufw enable
ufw status
