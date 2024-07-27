#!/bin/bash

set -e

DATA_ROOT_DIR=/mydata
DATA_DIR=$DATA_ROOT_DIR/myproj
#EMBARCADERO_DIR=$DATA_DIR/Embarcadero

MY_GROUP=$(id -gn)
SAVE_FILE_NAME=$USER-embarcadero.tar.gz
#TMP_SAVE_FILE=$DATA_DIR/$SAVE_FILE_NAME
SAVE_DIR=/proj/$MY_GROUP
SAVE_FILE=$SAVE_DIR/$SAVE_FILE_NAME

if [ -d "$DATA_ROOT_DIR" ]; then
    echo "INFO: Found $DATA_ROOT_DIR!"
else
    echo "ERROR: Did not find $DATA_ROOT_DIR! Exiting."
    exit -1
fi

if [ -f "$SAVE_FILE" ]; then
    echo "INFO: Found $SAVE_FILE!"
else
    echo "ERROR: Did not find previous work ($SAVE_FILE)! Exiting."
    exit -1
fi

# setup permissions before unpacking
sudo mkdir -p $DATA_DIR
sudo chown -R $USER $DATA_DIR
sudo chgrp -R $MY_GROUP $DATA_DIR

# Decompress previous work
tar -xvf $SAVE_FILE --directory $DATA_DIR
mv $DATA_DIR$DATA_DIR/* $DATA_DIR
