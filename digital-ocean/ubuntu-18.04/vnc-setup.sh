#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04

# Install the desktop environment and VNC server
echo installing the desktop environment and VNC server 
sudo apt-get update
sudo apt install xfce4 xfce4-goodies
sudo apt install tightvncserver
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

# Run VNC as a system service
echo Running VNC as a system service
sudo bash -c "cat >/etc/systemd/system/vncserver@.service" <<EOL
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=${USER}
Group=${USER}
WorkingDirectory=/home/${USER}

PIDFile=/home/${USER}/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOL

sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1
sudo systemctl status vncserver@1
