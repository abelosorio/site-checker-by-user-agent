#!/bin/bash

# Check site accesibility by User agent.
#

userAgentsURL="https://raw.githubusercontent.com/cvandeplas/pystemon/master/user-agents.txt"
userAgentsFile=/var/tmp/user_agents.txt

# Wget exit status
wgetExitStatus[0]="No problems occurred"
wgetExitStatus[1]="Generic error code"
wgetExitStatus[2]="Parse error"
wgetExitStatus[3]="File I/O error"
wgetExitStatus[4]="Network failure"
wgetExitStatus[5]="SSL verification failure"
wgetExitStatus[6]="Username/password authentication failure"
wgetExitStatus[7]="Protocol errors"
wgetExitStatus[8]="Server issued an error response"

url=$1

[ "x$url" == "x" ] && {
  cat <<FFAA
  Usage:

  $0 <url>
FFAA

  exit 1
}

[ -r $userAgentsFile ] || {
  echo -e "\e[33mDownloading user agents file\e[0m"
  wget -q "$userAgentsURL" -O "$userAgentsFile" || {
    echo "Can't get the user agents file"
    exit 1
  }
}

userAgentsCount=$( wc -l "$userAgentsFile" | cut -d \  -f 1)
counter=1

echo -e "<<< Testing againts \e[32m$userAgentsCount\e[0m user agents. Take it easy >>>\n"

cat "$userAgentsFile" | while read userAgent ; do
  wget --spider -q -U "$userAgent" $url

  result=$?

  [ $result -eq 0 ] && color="[32m" || color="[31m"

  progressPercent=$( printf "%.2f" $( bc -l <<< "($counter/$userAgentsCount)*100" | sed 's/\./,/g' ) )

  echo -en "[$counter/$userAgentsCount $progressPercent%]\t"
  echo -e  "\e$color${wgetExitStatus[$result]}\e[0m\t$userAgent"

  counter=$(( $counter + 1))
done
