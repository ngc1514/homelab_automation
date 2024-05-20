#!/bin/bash
set -x
apt update && apt upgrade -y

termRes=$(tail -50 /var/log/apt/history.log)
result=$(echo $?)
date=$(date)
recipient="configure_email_here"

if [ $result == 0 ]; then
        echo "${date} - Updated. " >> updater.log
        subject="PiHole Update Success"
        body="${date} - Updated successfully. Last 50 lines of APT history.log: \n ${termRes}"
else
        echo "${date} - Update encountered an error. "  >> updater.log
        subject="PiHole Update Failure"
        body="${date} - Update encountered an error. Last 50 lines of APT history.log: \n ${termRes}"
fi

echo -e "subject:${subject}\n\n${body}" | sendmail -t $recipient
