#!/bin/bash

echo "Finally, it's time to actually build the darknet store. We will be creating a folder in /var/www to hold the files. We'll call it /var/www/thevault but you could name it anything you like."

# Get the current working directory
CWD=$(pwd)
VAULT_DIR="$CWD/the_vault"
TARGET_DIR="/var/www/thevault"

# Remove the target directory if it exists
if [ -d "$TARGET_DIR" ]; then
    echo "Removing existing directory $TARGET_DIR..."
    sudo rm -rf "$TARGET_DIR"
fi

# Create the main directory
echo "Creating directory $TARGET_DIR..."
sudo mkdir "$TARGET_DIR"

# Change ownership and permissions
CURRENT_USER=$(whoami)
CURRENT_GROUP=$(id -gn)

# Create necessary subdirectories
echo "Creating necessary subdirectories..."
sudo mkdir -p "$TARGET_DIR/public"
sudo mkdir -p "$TARGET_DIR/bootstrap/cache"
sudo mkdir -p "$TARGET_DIR/storage"
sudo mkdir -p "$TARGET_DIR/storage/public/products"

# Change ownership and permissions
echo "Setting ownership and permissions..."
sudo chown -R $CURRENT_USER:$CURRENT_GROUP "$TARGET_DIR/public"
sudo chmod 755 /var/www
sudo chmod -R 755 "$TARGET_DIR/bootstrap/cache"
sudo chmod -R 755 "$TARGET_DIR/storage"
sudo chmod -R 755 "$TARGET_DIR/storage/public/products"

# Check if the artisan file exists and create storage link
if [ -f "$VAULT_DIR/artisan" ]; then
    echo "Creating storage link..."
    cd "$VAULT_DIR"
    php artisan storage:link
else
    echo "Error: Could not find artisan file. Make sure you are in the correct directory."
    exit 1
fi

# Check for Composer dependencies and install if necessary
if [ ! -d "$VAULT_DIR/vendor" ]; then
    echo "Vendor directory does not exist. Running 'composer install'..."
    composer install --working-dir="$VAULT_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Composer install failed. Please check for errors."
        exit 1
    fi
fi

# Copy contents from the_vault to /var/www/thevault
echo "Copying contents from $VAULT_DIR to $TARGET_DIR..."
if [ -d "$VAULT_DIR" ]; then
    sudo cp -rf "$VAULT_DIR/"* "$TARGET_DIR/"
else
    echo "Error: the_vault directory does not exist."
    exit 1
fi

echo "Setup completed successfully."
