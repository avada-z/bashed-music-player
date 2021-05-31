#!/usr/bin/bash
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
printf '\nSelect the number of music file\n\nq to quit;\n\np to create playlist; \n:'
read SONG
if [ "$SONG" = "q" ]
then
rm testochka.txt testochkatmp.txt playlist.tmp testtest.txt
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
else
echo Selected file is ${FILES[$SONG]}
ffplay "${FILES[$SONG]}"
fi
done
rm testochka.txt testochkatmp.txt playlist.tmp testtest.txt
exit 0