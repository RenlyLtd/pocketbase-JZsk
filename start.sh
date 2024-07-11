#!/bin/sh

# Start PocketCMS to initialize directories
/usr/local/bin/pocketcms serve --http=0.0.0.0:8090 --dir=/root/pocketcms &

# Wait for PocketCMS to create necessary directories
sleep 5

# Stop the PocketCMS server
pkill pocketcms

# Copy hooks after directories are created
cp -r /tmp/pb_hooks /root/pocketcms/
cp -r /tmp/pb_migrations /root/pocketcms/

# Restart PocketCMS
/usr/local/bin/pocketcms serve --http=0.0.0.0:8090 --dir=/root/pocketcms/pb_data
