#!/bin/bash

BYTEBASE="Bytebase"
STASHPAD="Stashpad"

BB_FOLDER=~/.config/Bytebase
SP_FOLDER=~/.config/Stashpad

REALM="data.realm"
CONFIG="config.json"

if [ ! -d "$SP_FOLDER" ]; then
  echo
  echo "Please install $STASHPAD before running this script."
  exit 1
fi

echo
echo "If you are currently editing or writing to a byte inside $BYTEBASE submit it and then hit enter to continue..."

 read ACCEPT

BB_RUNNING=`pgrep $BYTEBASE`

if [ "$BB_RUNNING" != "" ]
  then
    echo "Stopping $BYTEBASE..."
    killall $BYTEBASE
fi

SP_RUNNING=`pgrep $STASHPAD`

if [ "$SP_RUNNING" != "" ]
  then
    echo "Stopping $STASHPAD..."
    killall $STASHPAD
fi

REALM_FILE="$BB_FOLDER/$REALM"

if [ -f "$REALM_FILE" ]; then
  echo
  echo "Copying realm data file..."
  cp -f "$REALM_FILE" "$SP_FOLDER"
fi

CONFIG_FILE="$BB_FOLDER/$CONFIG"

if [ -f "$CONFIG_FILE" ]; then
  echo
  echo "Copying config file..."
  cp -f "$CONFIG_FILE" "$SP_FOLDER"
fi

echo
echo "Complete. You may now open Stashpad"
