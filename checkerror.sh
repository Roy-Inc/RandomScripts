#!/bin/bash
#Description: A simple script to monitor errors in postgresql log files
#Dependencies: Needs the command sendmail to be working. 
#To use this command simply put the below line in your crontab
#* * * * * <path_to>/checkerror.sh <your@email.id> >/dev/null 2>&1
#Obviously you can change the logfile name and the grep keyword to use it with any log file of your desire
#Feel Free to exploit it
if tail -n +`cat /var/logchecker.tmp` /var/log/postgresql/postgresql-9.4-main.log | grep "ERROR:"; then
        echo "Subject: New errors found in the $Hostname postgreSQL Log file" > /tmp/mail.tmp
        echo "The Error was found at `date`" >> /tmp/mail.tmp
        cat /tmp/mail.tmp | /usr/sbin/sendmail -v $1
else
        echo "No New errors dude"
fi
wc -l /var/log/postgresql/postgresql-9.4-main.log | awk  '{print $1}' > /var/logchecker.tmp
