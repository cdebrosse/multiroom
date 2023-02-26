#!/bin/bash
# débloquer si necessaire le port usb bluetooth
rfkill unblock bluetooth

# au reboot du serveur, une crontab de root peut lancer le mpvserver pour que le démarrage du serveur mpv soit oérationnel
# remplacer {user} par l'utilisateur local

su - {user} -c '/home/{user}/mpvserver.sh &'

# ajouter la ligne suivante avec crontab -e de root sans la # bien sûr
# @reboot /root/reboot.sh > /tmp/reboot.log
