# picakiosk

This was made for a basic kiosk device setup on UBUNTU LTS 22.04 Jammy Jellyfish

Would not recommend running on other distros but you can try and give feedback maybe modify the code.

It uses chromium-browser for the main browser. It uses a python script to run the GUI. 

The GUI has a verification system, if the user passes it he can change the URL that the chromium-browser adds. 

For it to autostart you must add a "STARTUP APPLICATIONS" entry to the system and if you want you can add a keyboard shortcut for the gui through the settings menu. 

Minor things are needed to set manually but i left them to your personal preference. 

In KIOSK.SH you can change your password for the GUI. 

To sum it up. 

The file setup.sh does the following:
-Sets up anydesk on system for remote support.
-Adds necessary packages to run the kiosk.sh, kiosk_gui.py scripts. 
-Sets up chromium to run even if the process ends.
-Creates two files needed for the kiosk app to run and the GUI for changing the url of the kiosk app.


Plan for next release:
-improving the passwword system so that verification is not so basic
-improving the manual setup to automatic setup for keyboard shortcut and startup applications entry


