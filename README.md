# NASA-Wallpaper

A simple project to fetch and use NASA's stunning daily images as wallpapers. This repository contains code and utilities that download NASA images (e.g., APOD, EPIC) and optionally set them as the desktop background.

If you cloned this repository to explore or extend wallpaper automation using NASA data, this README will help you get started.

Table of contents
- About
- Features
- Requirements
- Getting a NASA API key
- Installation
- Configuration
- Usage
- Example: Fetch APOD (curl)
- Scheduling (optional)
- Contributing
- License
- Acknowledgements

About
-----
NASA-Wallpaper is intended to make it easy to download NASA imagery (such as the Astronomy Picture of the Day) and apply it as a wallpaper on your machine or device. The project can be used as:
- a command-line utility
- a small desktop app
- a learning example for using the NASA Open APIs

Features
--------
- Download NASA APOD (Astronomy Picture of the Day)
- Download other NASA image sources (EPIC, Image and Video Library) — extendable
- Save images locally with metadata (title, date, explanation)
- (Optional) Set the downloaded image as the system wallpaper (platform-specific scripts)

Requirements
------------
- A working environment for the project's language (update below: Python / Node / Swift / etc.)
- Internet access
- A NASA API key (free). See next section.

Getting a NASA API key
----------------------
1. Go to https://api.nasa.gov
2. Sign up and generate an API key.
3. Keep the key handy — you'll add it to your environment or a config file.

Installation
------------
Python (example)
```bash
# create venv
python3 -m venv .venv
source .venv/bin/activate

# install dependencies
pip install -r requirements.txt
```

Node.js (example)
```bash
# install packages
npm install
# or
yarn install
```

Configuration
-------------
Create a .env file in the project root or export environment variables:

Example .env
```
NASA_API_KEY=DEMO_KEY_OR_YOUR_REAL_KEY
DOWNLOAD_DIR=./images
```

Usage
-----
Python
```bash
# Download today's APOD
python3 scripts/fetch_apod.py

# Download and set as wallpaper (macOS)
python3 scripts/fetch_apod.py --set-wallpaper
```

Node.js
```bash
# Run the fetch script
node src/fetchApod.js

# OR using npm script
npm run fetch
```

Example: Fetch APOD with curl
----------------------------
You can test the NASA APOD API directly with curl:

```bash
curl "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true"
```

This returns JSON describing today's picture and a URL to the image. Replace DEMO_KEY with your API key.

Saving and setting wallpaper
--------------------------------------
- macOS: you can use AppleScript/osascript to change wallpaper.
- Linux (GNOME): gsettings can be used to change the background.
- Windows: PowerShell or third-party utilities can set the wallpaper.

Example (macOS) — set a downloaded image as wallpaper:
```bash
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/path/to/file.jpg"'
```

Scheduling (optional)
---------------------
To keep your wallpaper updated automatically:
- Use cron (Linux/macOS) or Task Scheduler (Windows) to run the fetch script daily.
- Example cron job (runs at 8:00 AM daily)
```cron
0 8 * * * /usr/bin/python3 /path/to/repo/scripts/fetch_apod.py --set-wallpaper >> /var/log/nasa-wallpaper.log 2>&1
```

Contributing
------------
Contributions are welcome! Please:
1. Open an issue to discuss changes.
2. Fork the repository and make your changes on a feature branch.
3. Open a pull request describing your changes.

Please include:
- What you changed
- Why it helps
- How to test


License
-------
This repository does not include an explicit license file yet. Also note that images downloaded from NASA APIs are subject to NASA's usage policies — check the API docs for attribution and reuse rules.

Acknowledgements
----------------
- NASA Open APIs — https://api.nasa.gov
- Thanks to contributors and maintainers
