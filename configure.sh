#!/bin/bash

# Turn off screensaver
gsettings set org.gnome.desktop.session idle-delay 0

# Configure Keyboard Shortcut ALT+C
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Alt>c'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'/usr/bin/python3 $HOME/kiosk.py'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Kiosk Shortcut'"

# Reload dconf settings
dconf update

# Log end time
echo "$(date): Kiosk script completed" >> "$HOME/kiosk.log"

# Create directory if it doesn't exist
mkdir -p "$HOME/.config/autostart/"

# Add to startup applications
echo "[Desktop Entry]
Name=Kiosk
Exec=$HOME/kiosk.sh
Type=Application
X-GNOME-Autostart-enabled=true
" > "$HOME/.config/autostart/kiosk.desktop"

echo "Kiosk settings configured successfully!"
