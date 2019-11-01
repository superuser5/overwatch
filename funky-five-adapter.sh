#!/bin/bash
#-----------------------------------------------------------------------------------
#                             Created by Daniel Ward
#Going further down the rabbit hole of Overwatch... This thing just builds itself...
#-----------------------------------------------------------------------------------
#Load in Les Variables;
green='\u001b[32m'
yellow='\u001b[33m'
red='\033[31m'
cyan='\x1b[36m'
nc='\033[0m'
screenshotlistdir='/root/scripts/circus/screenshotlist/temp/'
echo ""
echo ""
printf "${cyan}--------------------------${nc}${red}x${nc}${cyan}-------------------------${nc}\n"
echo ""
echo "Beginning the funky five adapter..."
echo ""
echo "Instance Run Begin: $(date)"
echo ""
threshold='5'
if [ $(ls $screenshotlistdir | wc -l) -gt $threshold ]
then
        printf "${green}There are more than 5 files in: ${nc}${yellow}$screenshotlistdir${nc}\n"
        echo "listing containing directory..."
        ls $screenshotlistdir
        rm dirshow.txt
        i=0;
        for f in /root/scripts/circus/screenshotlist/temp/*;
        do
            d=/root/scripts/circus/screenshotlist/temp/$(printf %03d $((i/5+1)));
            mkdir -p $d;
            mv "$f" $d;
            cp /root/scripts/circus/resource.tar.gz $d;
            tar -zxvf $d/resource.tar.gz -C $d;
            rm $d/resource.tar.gz
            let i++;
        done
else
        printf "${red}looking empty, sarge... No files found!\n"
        printf "${nc}${green}o${nc}${cyan}.${nc}${yellow}O${nc}\n"
        echo "listing $screenshotlistdir"
        ls $screenshotlistdir
fi
echo ""
echo "Instance Run Completed at: $(date)"
echo ""
printf "${cyan}--------------------------${nc}${red}x${nc}${cyan}-------------------------${nc}\n"
echo ""
echo ""
#
