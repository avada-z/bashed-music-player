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
ls | grep .txt | tee testochkatmp.txt &>/dev/null
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
echo Selected file is ${FILES[$SONG]}
cat "${FILES[$SONG]}"
done