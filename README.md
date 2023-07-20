# picakiosk

Usage
This script is intended to be run on a freshly installed Ubuntu 22.04 LTS system for setting up a dedicated kiosk system. It can be adjusted and modified to work with other versions of Ubuntu or different Linux distributions. The kiosk system it creates is ideal for use in a range of applications such as public information points, digital signage, or any other situation where you need to display specific web content in a controlled manner.

It uses chromium-browser for the main browser. It uses a python script to run the GUI. 
The GUI has a verification system, if the user passes it he can change the URL that the KIOSK app shows. 



For it to autostart you must add a "STARTUP APPLICATIONS" entry to the system and if you want you can add a keyboard shortcut for the gui through the settings menu. 

STARTUP APPLICATIONS ENTRY COMMAND:
"bash kiosk.sh"

KEYBOARD SHORTCUT COMMAND:
"python3 kiosk_gui.py" 


Minor things are needed to set manually but i left them to your personal preference. 

In KIOSK.SH you can change your password for the GUI. 


Plan for next release:
-improving the passwword system so that verification is not basic
-improving the manual setup to automatic setup for keyboard shortcut and startup applications entry





Features
Essential Packages Installation: The script begins by updating the system package lists. It then checks and installs several necessary software packages to facilitate the creation and functionality of the kiosk system. These packages include:

chromium-browser: The open-source version of Google Chrome, used for the web-based kiosk system.

xdotool: A command-line X11 automation tool, necessary for simulating keyboard input and mouse activity, moving and resizing windows, etc.

x11-utils: A collection of utility programs supplied with the X Window System, used for maintaining GUI applications.

unclutter: A program to hide the mouse cursor when it's not in use, thereby reducing visual distraction.

python3-tk: A Python 3 binding to the Tk GUI toolkit, used for creating the GUI to manage the kiosk system settings.

AnyDesk Installation: AnyDesk, a remote desktop software that allows for remote access, collaboration, and technical support, is downloaded and installed using its official repository. This adds the capability to remotely control and manage the kiosk system.

Kiosk Shell Script Creation: The script creates kiosk.sh, a shell script designed to ensure that the Chromium Browser runs persistently in kiosk mode, opening a specified URL. If the Chromium Browser process is killed or stops for any reason, this script will automatically restart it.

GUI for Kiosk Settings: A Python-based GUI, kiosk_gui.py, is created, allowing for secure settings management of the kiosk system. It requires a specified password to access. Once unlocked, you can easily change the URL that the Chromium Browser opens in the kiosk mode.

File Permissions: The script assigns the necessary permissions to kiosk.sh and kiosk_gui.py, making them executable.

Git Installation: The script checks if Git is installed, and if not, installs it. This allows for version control and easier updates if you're planning to maintain and update the scripts over time.




