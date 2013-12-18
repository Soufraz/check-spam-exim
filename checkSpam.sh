#!/bin/bash

LIMIT=250

FROZEN=`exim -bpc`
#echo $FROZEN

if [ $FROZEN -gt $LIMIT ];
then
        ACCOUNT=`exim -bp | awk '{print $4}' | sort | uniq -c | sort -nk1 | tail -2 | head -1 | awk '{print $2}'`
        ./swaks -s 'mail.yoursite.com' -f 'emailfrom@yoursite.com' -t 'emailto@yoursite.com' \
         -au 'emailfrom@yoursite.com' -ap 'from-email-password' --header "Subject: SUSPECT SPAM!!" -body $ACCOUNT
        #echo $ACCOUNT
else
        ACCOUNT=`exim -bp | awk '{print $4}' | sort | uniq -c | sort -nk1 | tail -2 | head -1 | awk '{print $2}'`
        ./swaks -s 'mail.yoursite.com' -f 'emailfrom@yoursite.com' -t 'emailto@yoursite.com' \
         -au 'emailfrom@yoursite.com' -ap 'from-email-password' --header "Subject: JUST A TEST YET!!" -body "All beautiful!"
        #echo $ACCOUNT
fi
