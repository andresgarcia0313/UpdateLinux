#!/bin/bash
# Script to clean temporary files in Kubuntu
sudo -v
# Install BleachBit 
sudo apt install bleachbit -y
# Clean system temporary files
sudo apt-get clean
# Set execution permission
chmod +x ./01Clean.sh
# Clean apt cache
sudo apt-get autoclean
# Clean trash bin
rm -rf ~/.local/share/Trash/*
# Clean user's temporary folder
rm -rf ~/.cache/*
# Clean thumbnails cache
rm -rf ~/.thumbnails/*
# Clean BleachBit
bleachbit --clean --all
sudo bleachbit --clean --all
# Show completion message
echo "Temporary files cleaned successfully 😊🚀"
