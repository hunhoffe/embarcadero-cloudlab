#!/bin/bash

set -e

DATA_DIR=/mydata/myproj
EMBARCADERO_DIR=$DATA_DIR/Embarcadero

MY_GROUP=$(id -gn)
SAVE_FILE_NAME=$USER-embarcadero.tar.gz
TMP_SAVE_FILE=$DATA_DIR/$SAVE_FILE_NAME
SAVE_DIR=/proj/$MY_GROUP
SAVE_FILE=$SAVE_DIR/$SAVE_FILE_NAME

if [ -d "$DATA_DIR" ]; then
    echo "INFO: Found $DATA_DIR!"
else
    echo "ERROR: Did not find $DATA_DIR! Exiting."
    exit -1
fi

if [ -d "$EMBARCADERO_DIR" ]; then
    echo "INFO: Found $EMBARCADERO_DIR!"
else
    echo "ERROR: Did not find $EMBARCADERO_DIR! Exiting."
    exit -1
fi

if [ -d "$SAVE_DIR" ]; then
    echo "INFO: Found $SAVE_DIR!"
else
    echo "ERROR: Did not find $SAVE_DIR! Exiting."
    exit -1
fi

# Create compressed version of current archive
tar -czvf $TMP_SAVE_FILE $EMBARCADERO_DIR

# save in persistent cloudlab storage
mv $TMP_SAVE_FILE $SAVE_FILE
