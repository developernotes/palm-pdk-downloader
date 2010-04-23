#!/bin/bash


########################################
#### Enter the name of the file or  ####
#### directory to be sent to device ####
#### APP="<name of app file or dir>"####
#### Ex: APP="APPDIR"		    ####
########################################
APP="geoDownloader"

########################################
#### Enter the relative path to the ####
#### executable here.		    ####
#### EXEC="<relative/path/to/exec>" ####
#### Ex: EXEC="APPDIR/myapp_exec"   ####
########################################
EXEC=""

if [ "$APP" == "" ];then
	echo "The application file/directory name is not set. Please edit this script to specify the APP variable."
	exit 1
fi

if [ "$EXEC" == "" ];then
        echo "The executable file name is not set. Please edit this script to specify the EXEC variable."
        exit 1
fi

./buildit_for_device.sh

scp -r -P 10022 $APP root@localhost:/media/internal/$APP
novacom run file:///media/internal/$EXEC
