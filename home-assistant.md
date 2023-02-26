Utilisation HomeAssistant pour piloter l'audio
=

- permettre la gestion de la playlist (prev, next, volume...)

dans lovelace ajouter un onglet qu'on associe au webui de mpv :
choisir un onglet panneau (1 seule carte), ajouter une carte web et coller l'url de mpv webui
  http://homeassistant.lan:8078
  remplacer homeassistant.lan par le nom ou l'adresse ip locale de home assistant.


- connecter une enceinte :
  - on/off prise pilotée : ajouter un switch classique pour allumer/éteindre

  - association de l'enceinte à mpv webui :
il faut envoyer via un shell l'ordre :
  bluetoothctl connect  [adressemac]

ça peut se réaliser par l'exécution d'un shell associé directement à un bouton homeassistant, ou via nodered par exemple :

  - avec nodered : assez simple (quoi, que ?)
il faut créer un bouton nodered exposé (qui apparaîtra dans home assistant) : ça suppose que nodered soit installé, configuré, communique avec homeasssitant (token long terme créé).
chaque bouton d'enceinte peut être associé à un numéro (0,1, 2... selon l'enceinte par simplicité) qui est "vidé" sur msg.payload par exemple puis envoyé à un exec pour exécuter la commande shell avec en argument le msg.payload.

ensuite l'exécution du shell lancera le connect !
et la musique passera sur l'enceinte.

