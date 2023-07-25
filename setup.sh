#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y chromium-browser xdotool x11-utils unclutter python3-tk
command -v git >/dev/null 2>&1 || { echo >&2 "Installing Git..."; sudo apt-get install -y git; }

# Install AnyDesk
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install anydesk

# Create the kiosk.sh file
cat << EOF > /home/spica/kiosk.sh
#!/bin/bash
while true; do
    if ! pgrep chromium-browser > /dev/null; then
        /usr/bin/chromium-browser --noerrdialogs --kiosk http://timespace.spica.com
    fi
    sleep 1s
done
EOF

# Make the kiosk.sh file executable
chmod +x /home/spica/kiosk.sh

# Create the kiosk_gui.py file
cat << EOF > /home/spica/kiosk_gui.py
import tkinter as tk
from tkinter import messagebox
import os
import getpass

# Define your password here
PASSWORD = "spica"

def check_password():
    entered_password = password_entry.get()
    if entered_password != PASSWORD:
        messagebox.showerror("Napaka", "Napačno geslo!")
    else:
        password_button.grid_remove()
        password_label.grid_remove()
        password_entry.grid_remove()
        url_label.grid(row=0, column=0)
        url_entry.grid(row=0, column=1)
        save_button.grid(row=1, columnspan=2)

def save_changes():
    new_url = url_entry.get()
    kiosk_file_path = "/home/spica/kiosk.sh"

    # Read all lines of the file into a list
    with open(kiosk_file_path, 'r') as file:
        lines = file.readlines()

    # Find the line that starts with "/usr/bin/chromium-browser" and change the URL
    for i in range(len(lines)):
        if lines[i].startswith("/usr/bin/chromium-browser"):
            lines[i] = "/usr/bin/chromium-browser --noerrdialogs --kiosk " + new_url + "\\n"
            break

    # Write the modified lines back to the file
    with open(kiosk_file_path, 'w') as file:
        file.writelines(lines)

    messagebox.showinfo("Uspešno", "URL uspešno posodobljen! Prosimo, ročno ponovno zaženite brskalnik Chromium, da bodo spremembe začele veljati.")

root = tk.Tk()

password_label = tk.Label(root, text="Geslo:")
password_entry = tk.Entry(root, show='*')
password_button = tk.Button(root, text="Odkleni", command=check_password)

password_label.grid(row=0, column=0)
password_entry.grid(row=0, column=1)
password_button.grid(row=1, columnspan=2)

url_label = tk.Label(root, text="Vnesi URL:")
url_entry = tk.Entry(root)
save_button = tk.Button(root, text="Shrani spremembe", command=save_changes)

root.mainloop()
EOF

# Make the kiosk_gui.py file executable
chmod +x /home/spica/kiosk_gui.py
