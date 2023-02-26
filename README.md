# multiroom
lecture bluetooth via réseau local sur multiples enceintes

prérequis : 
- serveur linux :
  - avec carte son :
sur une carte nom pré-équipée de sortie audio, il est possible d'ajouter un module usb avec in/out basique ou une carte pci...
  - installation pulseaudio opérationnelle :
dans alsamixer la carte doit apparaitre par f6 la selectionner comme carte par défaut

  - bluetooth : 
 bluethoothctl

1) configurer le serveur :
% bluetoothctl 
Agent registered
[CHG] Controller 00:1A:XX:XX:XX:XX Pairable: yes

indique que la clé usb est reconnue et est en écoute.

sinon : passer en root avec rfkill pour vérifier que le port n'est pas bloqué :
sudo rfkill
ID TYPE      DEVICE     SOFT     HARD
 0 bluetooth hci0   débloqué débloqué

si hci0 est indiqué bloqué, rfkill unblock 0 résoud le problème (à ajouter au script de reboot du serveur)

2) apairer les clients bt (une seule fois)
on doit obtenir :
[SANWU Audio]# paired-devices

Device CC:XX:XX:XX:71:XX [AV] Samsung Soundbar K335 K-Series

Device 18:XX:XX:XX:XX:XX XLeader A8

Device 00:XX:XX:XX:XX:XX SANWU Audio

pour ajouter une enceinte :

	scan on

va lister les équipements qui communiquent
	scan off si tout est visible

puis
 trust [adressemac]
pour faire confiance à un appareil

 pair [adressemac] 
pour l'associer

et lors de l'utilisation de l'enceinte (à chaque fois) 
 connect [adressemac]

le prompt de bluetoothctl change pour indiquer entre [] le nom de l'enceinte connectée. 
à partir de là le son alsa passe sur cette enceinte.

   -mpv comme player via le réseau local :

1) mpv server lancé sur le serveur peut transmettre la musique sur le réseau
apt install mpv

télécharger sur le web le paquet mpv-webui pour avoir une interface web

ajouter dans ~/.config/mpv/mpv.conf 
	
	scripts-append=~/.config/mpv/scripts/webui

et extraire webui dans le dossier ~/.config/mpv/scripts/webui


ensuite il reste à lancer la commande :
	
	nohup mpv --script-opts=webui-port=8078 --pause /tmp/listjour.m3u --vo=null --script=~/.config/mpv/scripts/webui/main.lua > /tmp/log_mpv.log &

(incluse dans le script mpvserver.sh à adapter selon les besoins)

lorsqu'il tourne ouvrir la page http://adresseiplocale:8078 dans un navigateur pour consulter mpv lancer les pistes ajuster le volume ...

