#!/bin/bash

while true
do
MPV=$(ps -ef | grep " mpv "| grep -v grep | wc -l )
PUL=$(ps -ef | grep pulseaudio | grep -v grep | wc -l)
echo "mpv : $MPV , pul : $PUL
"
if [ $MPV -eq 0 ]
then

	if [ $PUL -eq 0 ]
	then
		pulseaudio -D 
		RC=$?
		if [ $RC -eq 0 ]
		then
			echo "pulse démarre"
		else
			echo "erreur pulseaudio"
			exit 0
		fi
	else
		echo "pulse déjà démarré"
	fi
	find /srv/musique/musique/ -type f ! -wholename "*podcasts*" | grep -P 'mp3$|flac$' | shuf -n 30 > /tmp/listjour.m3u
	nohup mpv --script-opts=webui-port=8078 --pause /tmp/listjour.m3u --vo=null --script=~/.config/mpv/scripts/webui/main.lua > /tmp/log_mpv.log &
	echo "mpv démarre"
	
else
	echo "mpv déjà démarré"
fi
sleep 200
date
done


