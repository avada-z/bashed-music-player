#!/usr/bin/bash
while :
do
ls | grep .mp3 | tee testochkatmp.txt &>/dev/null
readarray -t FILES < testochkatmp.txt &>/dev/null
echo 'Music files in current directory'
nl --starting-line-number=0 testochkatmp.txt > testochka.txt
while IFS= read -r line; do
    echo "$line"
done < testochka.txt
echo
printf '\nSelect the number of music file or q to quit: '
read SONG
if [ "$SONG" = "q" ]
then 
exit 0
fi
FFPLAY='G:\ffmpeg\bin\ffplay.exe'			#ffplay windows binary
echo Selected file is ${FILES[$SONG]}
$FFPLAY "${FILES[$SONG]}"
clear
done