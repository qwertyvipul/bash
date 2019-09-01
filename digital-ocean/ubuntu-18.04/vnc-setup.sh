#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04

# Install the desktop environment and VNC server
echo installing the desktop environment and VNC server 
apt-get update
apt install xfce4 xfce4-goodies
apt install tightvncserver
vncserver

# Configure the VNC server
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

cat >~/.vnc/xstartup <<EOL
#!/bin/bash
xrdb ${HOME}/.Xresources
startxfce4 &
EOL

sudo chmod +x ~/.vnc/xstartup
vncserver