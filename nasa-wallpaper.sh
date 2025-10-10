#!/bin/bash

# --- CONFIGURATION ---
# Replace this with your own API key from https://api.nasa.gov/
API_KEY="YOUR_NASA_API_KEY_HERE"

# Directory to store the wallpapers
# The script will create this directory if it doesn't exist.
# '~/Pictures/NASA-APOD' is a good choice.
WALLPAPER_DIR="${HOME}/Pictures/NASA-APOD"


# --- SCRIPT LOGIC (No need to edit below this line) ---

# Create the directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Fetch the APOD data from NASA's API
echo "Querying NASA APOD API..."
API_RESPONSE=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=${API_KEY}")

# Check if the API call was successful
if [ -z "$API_RESPONSE" ]; then
    echo "Error: Failed to get a response from NASA API."
    exit 1
fi

# Use jq to check the media type. Exit if it's not an image.
MEDIA_TYPE=$(echo "$API_RESPONSE" | jq -r '.media_type')
if [ "$MEDIA_TYPE" != "image" ]; then
    echo "Today's APOD is a $MEDIA_TYPE, not an image. Exiting."
    exit 0
fi

# Use jq to get the URL of the high-resolution image
IMAGE_URL=$(echo "$API_RESPONSE" | jq -r '.hdurl')
echo "Image URL: $IMAGE_URL"

# Get the filename from the URL
FILENAME=$(basename "$IMAGE_URL")
# Define the full path for saving the image
SAVE_PATH="${WALLPAPER_DIR}/${FILENAME}"

# Download the image using wget
echo "Downloading image to $SAVE_PATH..."
wget -q -O "$SAVE_PATH" "$IMAGE_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to download the image."
    exit 1
fi

# Set the downloaded image as the desktop background for Pop!_OS (GNOME)
# We set it for both light and dark modes.
echo "Setting new wallpaper..."
gsettings set org.gnome.desktop.background picture-uri "file://${SAVE_PATH}"
gsettings set org.gnome.desktop.background picture-uri-dark "file://${SAVE_PATH}"

echo "✅ Success! Your wallpaper has been updated."

exit 0
