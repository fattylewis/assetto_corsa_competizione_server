#!/bin/sh

export INSTALL_PATH="/opt/server"

/usr/local/bin/acc-settings.sh


cd $INSTALL_PATH
wine accServer.exe