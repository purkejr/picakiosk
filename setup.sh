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
        save_button.grid(row=1, column=0)

def save_changes():
    new_url = url_entry.get()
    kiosk_file_path = "/home/spica/kiosk.sh"

    # Read all lines of the file into a list
    with open(kiosk_file_path, 'r') as file:
        lines = file.readlines()

    # Find the line that starts with "/usr/bin/chromium-browser" and change the URL
    for i in range(len(lines)):
        if lines[i].startswith("/usr/bin/chromium-browser"):
            lines[i] = f"/usr/bin/chromium-browser --kiosk {new_url}\n"
            break

    # Write the modified lines back to the file
    with open(kiosk_file_path, 'w') as file:
        file.writelines(lines)

    messagebox.showinfo("Uspešno", "URL uspešno posodobljen!")

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
