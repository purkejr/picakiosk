#!/bin/bash

# Update packages
sudo apt-get update

# Install necessary packages
sudo apt-get install -y python3-pip chromium-browser xdotool

# Install Tkinter for Python3
sudo apt-get install -y python3-tk

# Install Anydesk
wget -qO- https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt-get update
sudo apt-get install anydesk

# Save Python script to a file
cat > /home/spica/kiosk.py <<EOF
#!/usr/bin/env python3
import tkinter as tk
from tkinter import messagebox
import os
import getpass

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

    with open(kiosk_file_path, 'r') as file:
        lines = file.readlines()

    for i in range(len(lines)):
        if lines[i].lstrip().startswith("/usr/bin/chromium-browser"):
            leading_spaces = len(lines[i]) - len(lines[i].lstrip())
            lines[i] = " " * leading_spaces + "/usr/bin/chromium-browser --noerrdialogs --kiosk " + new_url + "\n"
            break

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

# Save Bash script to a file
cat > /home/spica/kiosk.sh <<EOF
#!/bin/bash
while true; do
    if ! pgrep chromium-browser > /dev/null; then
        /usr/bin/chromium-browser --noerrdialogs --kiosk https://google.com
    fi
    sleep 1s
done
EOF

# Make Python and Bash scripts executable
chmod +x /home/spica/kiosk.py /home/spica/kiosk.sh 