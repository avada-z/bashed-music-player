#!/usr/bin/bash
rm testochka.txt testochkatmp.txt playlist.tmp testtest.txt playlists.txt nlpl.txt &>/dev/null
if ! which dialog ffmpeg awk > /dev/null; then
   echo -e "Something not found! Install? (y/n) \c"
   read
   if [ "$REPLY" = "y" ] 
then
      sudo apt install ffmpeg dialog -y >> /dev/null && exit 0
elif [ "$REPLY" = "n" ]
	then
	exit 0
   fi
fi
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
printf '\nSelect the number of music file\n\nq to quit;\n\np to create playlist;\n\npm to enter playlist mode: '
read SONG
if [ "$SONG" = "q" ]
then
rm testochka.txt testochkatmp.txt playlist.tmp testtest.txt &>/dev/null
exit 0
elif [ "$SONG" = "p" ]
then
echo "Name of the playlist: "
read PLAYNAME
echo "Select files to put into playlist (ex. 1 2 4)"
read PLAYSONGS
echo $PLAYSONGS | tr " " "\n" > playlist.tmp
while IFS= read -r line; do
     line=$((line+1)) && echo $line
done < playlist.tmp > testtest.txt
while IFS= read -r line; do
     awk "NR==$line" testochkatmp.txt
done < testtest.txt > "$PLAYNAME".playlist
elif [ "$SONG" = "pm" ]
then
clear
ls | grep .playlist | tee playlists.txt &>/dev/null
readarray -t PLFILES < playlists.txt &>/dev/null
nl --starting-line-number=0 playlists.txt > nlpl.txt
echo "Available playlists: "
echo
echo
while IFS= read -r line; do
     echo $line
done < nlpl.txt
echo
echo Select the playlist: 
read SELECTEDPL
echo Selected file is ${PLFILES[$SELECTEDPL]}
while IFS= read -r line; do
     echo 'Now playing $line' && ffplay $line &>/dev/null
done < ${PLFILES[$SELECTEDPL]}
else
echo Selected file is ${FILES[$SONG]}
ffplay "${FILES[$SONG]}"
fi
done
rm testochka.txt testochkatmp.txt playlist.tmp testtest.txt playlists.txt nlpl.txt &>/dev/null
exit 0