#!/usr/bin/env bash

###################################################################
# Script Name : bandwith
# Description : Script to monitor network bandwith in i3blocks.
# Args        : $1 interval between updates, in seconds
# Author      : CarlesCN
# E-mail      : carlesbioinformatics@gmail.com
# License     : GNU General Public License v3.0
###################################################################

set -e -u -o pipefail

[[ $# -gt 0 ]] && timer=$1 || timer=1

while true;
  do cat /proc/net/dev;
  sleep "$timer";
done | awk -v timer="$timer" \
'
  function printDelta(bytes, last) {
      bits = (bytes - last) * 8

    if(     bits > 1024**3) { printf "%3iGb", (bits / (1024 ** 3) * timer) }
    else if(bits > 1024**2) { printf "%3iMb", (bits / (1024 ** 2) * timer) }
    else if(bits > 1024)    { printf "%3iKb", (bits / 1024) * timer}
    else                    { printf "%4ib", bits * timer}
  }

  /^enp3s0:/ {
	printDelta($2,  lastR); printf " "
	printDelta($10, lastT); printf "\n"

    lastR = $2;
    lastT = $10;
  }
  fflush(stdout)
'
