#!/bin/bash

RECORDINGS_DIR=$1

# Find latest modified directory
_lastdir=$(find /config/recordings -mindepth 1 -maxdepth 1 -type d  -exec stat --printf="%Y\t%n\n" {} \; | sort -n -r | head -1 | cut -f2)

# Rename the directory
if [ -r ${_lastdir} ]; then
        mv ${_lastdir} /config/recordings/$(date +%Y-%m-%d_%H:%M)
fi

# Find files in directory
_recording=$(find /config/recordings/$(date +%Y-%m-%d_%H:%M) -type f -name "*.mp4" -exec basename {} .mp4 \;)

# Send file(s) list
#echo -e "Hi ,\n\nNew conference recording is available:\n\n ${_recording}" | mailx -s "New #conference recording" your@email.com

# Move the .mp4 file & delete the folder
mv /config/recordings/$(date +%Y-%m-%d_%H:%M)/*.mp4 /config/recordings/

# ffmpeg need some time to finalize the .mp4 - then remove old folder
#sleep 1m
#cd ~/.jitsi-meet-cfg/jibri/recordings/
#find . -maxdepth 1 -mindepth 1 -type d -exec rm -rf '{}' \;


exit 0
