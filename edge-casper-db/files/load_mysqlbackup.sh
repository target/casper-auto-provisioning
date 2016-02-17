#!/bin/bash

# Restart AutoFS to fix bug
#sudo service autofs restart

# Wait for mount point to come online
sleep 5;

sudo rm -rf /tmp/backup*

# Copy most recent backup from mount point and dump into new vm
cd /mnt/EDGE/Casper_Database_Backups || exit
fn=$(ls -t | head -n1)
cp -f -- "$fn" /tmp/backup.sql.gz

# Unzip
sudo gzip -d /tmp/backup.sql.gz
