#!/bin/bash

# Update system packages
sudo yum update -y || sudo apt update -y

# Install Apache and Git
if command -v yum &> /dev/null; then
    sudo yum install -y httpd git
    sudo systemctl enable httpd
    sudo systemctl start httpd
elif command -v apt &> /dev/null; then
    sudo apt install -y apache2 git
    sudo systemctl enable apache2
    sudo systemctl start apache2
else
    echo "Unsupported OS"
    exit 1
fi

# Clean default web root
sudo rm -rf /var/www/html/*

# Copy website files to Apache web root
sudo cp -r . /var/www/html/

# Set correct permissions
sudo chown -R apache:apache /var/www/html || sudo chown -R www-data:www-data /var/www/html
cd /var/www/html/
sudo rm deploy-website.sh

echo "Website deployed successfully!"
