#!/bin/sh

export INSTALL_PATH="/opt/server"
mkdir /opt/server/cfg
/usr/local/bin/acc-settings.sh


cd $INSTALL_PATH
wine accServer.exe
