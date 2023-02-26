#!/bin/bash
# boucle infinie lancé en mode démon, le process tourne en tache de fonds et vérifie régulièrement (sleep 200 : temps de pause)
# l'état de pulseaudio : programme principal qui diffuse le son
# et l'état de mpv : transmet la musique au travers du réseau
while true
do
MPV=$(ps -ef | grep " mpv "| grep -v grep | wc -l )
PUL=$(ps -ef | grep pulseaudio | grep -v grep | wc -l)
echo "mpv : $MPV , pul : $PUL
"
# si mpv ne tourne pas 
if [ $MPV -eq 0 ]
then
	# on vérifie si pulse tourne
	if [ $PUL -eq 0 ]
	then
		# pulseaudio ne tourne pas il faut le lancer
		pulseaudio -D 
		RC=$?
		if [ $RC -eq 0 ]
		then
			echo "pulse démarre"
		else
			# tentative avortée de démarrage
			echo "erreur pulseaudio"
			exit 0
		fi
	else
		# tout va bien pour pulse
		echo "pulse déjà démarré"
	fi
	# réactualisation d'une playlist aléatoire à planifier via crontab pour réactualisation planifiée
	find /srv/musique/musique/ -type f ! -wholename "*podcasts*" | grep -P 'mp3$|flac$' | shuf -n 30 > /tmp/listjour.m3u
	#   /emplacement réseau nas/                                       /fin nom fichiers/                /nom playliste/
	#                                 /enlève les podcasts de la liste/                       /nombre de titres 30/
	nohup mpv --script-opts=webui-port=8078 --pause /tmp/listjour.m3u --vo=null --script=~/.config/mpv/scripts/webui/main.lua > /tmp/log_mpv.log &
	#                             /port web/           /playliste/                                                              /log de mpv/
	echo "mpv démarre"
	
else
	echo "mpv déjà démarré"
fi
sleep 200
date
done


