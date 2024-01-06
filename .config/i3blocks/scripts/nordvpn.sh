#!/usr/bin/env bash

###################################################################
# Script Name : nordvpn
# Description : Script to monitor the status of NordVPN in i3blocks.
# Args        : None
# Author      : CarlesCN
# E-mail      : carlesbioinformatics@gmail.com
# License     : GNU General Public License v3.0
###################################################################

set -e -u -o pipefail

nordvpn status | awk -F'[ .]' \
'
  # first line has some invisible space prefixed (wtf?)
  /Status:/ {
    if ($6 == "Disconnected") {
      print " Disconnected"
      print "" # short text
      print "#ff0000"
      exit 33 # send alert to i3bar
    }
  }

  /^Hostname:/ {
    print "",$2
    print "" # short text
    print "#00ff00"
  }

'
