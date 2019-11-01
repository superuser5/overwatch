#!/bin/bash
# ------------------------------------------------------------------
# Created and Maintained by Daniel Ward, for research purposes ONLY.
#          For the exclusive usage of Securitech Systems.
# ------------------------------------------------------------------
#
#
# -- BUCKLE YOUR SEATBELTS!! --
#  ________________.----------.________________
#  |                |   //\\   |            \   |
#  |                |  <<()>>  |o   o   o    )  |
#  |________________|   \\//   |____________/___|
#                   `----------'
#
# ------------------------------------------------------------------
# **************
# Les Variables;
#
scdir='/root/scripts/circus/screenshots'
sclist='/root/scripts/circus/screenshotlist.txt'
procfile='/root/scripts/circus/temp/procfile.csv'
prepfile='/root/scripts/circus/temp/prepfile.csv'
prepfile1='/root/scripts/circus/temp/prepfile1.csv'
prepfile2='/root/scripts/circus/temp/prepfile2.csv'
prepfile3='/root/scripts/circus/temp/prepfile3.csv'
prepfile4='/root/scripts/circus/temp/prepfile4.csv'
prepfile5='/root/scripts/circus/temp/prepfile5.csv'
prepfile6='/root/scripts/circus/temp/prepfile6.csv'
prepfile7='/root/scripts/circus/temp/prepfile7.csv'
final='/root/scripts/circus/screenshotlist/screenshotfile.sh'
#
# Colours
lightgreen='\033[1;32m'
lightpurple='\033[1;35m'
red='\033[0;31m'
nc='\033[0m'
#
# ------------------------------------------------------------------
# Begin doing the thing;
# ************************************************************************************************************
#
echo "Welcome to the proper-screenshotter, here, we strive to achieve the screenshots" | pv -qL 30
echo ""
echo "Loading in the latest data..." | pv -qL 30
cat $sclist > $procfile
echo ""
if [ ! -f "$procfile" ]
then
        printf "+  ${red} Processing file not found! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Processing file generated at $(date): ${lightgreen}OK${nc}\n\n"
#
#
echo "Adding the primary suffixes to $procfile" | pv -qL 30
sed -e 's/$/" -r phantomjs -o screenshots\/ ; chmod 777 -R screenshots\//' $procfile >> $prepfile
echo ""
if [ ! -f "$prepfile" ]
then
        printf "+  ${red} Primary Suffixes not added! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Primary Suffixes added at $(date): ${lightgreen}OK${nc}\n\n"
#
#
echo "Adding the main prefixes to $procfile" | pv -qL 30
sed -i -e 's/^/python webscreenshot.py "http:\/\//' $prepfile
echo ""
#
#--------------------------------------------------------------------------------------------------------------------------------------------------------
# Process the file for output
echo "More suffixes into $prepfile..." | pv -qL 30
sed -e 's/$/;rsync -avzh screenshots\/*.png* argus@panoptes.is-a-geek.org:\/home\/argus\/public\/;rm screenshots\/*.png*/' $prepfile >> $prepfile1
echo ""
if [ ! -f "$prepfile1" ]
then
        printf "+  ${red} Secondary Suffixes not added! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Secondary Suffixes added at $(date): ${lightgreen}OK${nc}\n\n"
#
#
echo "Formatting your file..." | pv -qL 30
#
sed 's/;mv/";mv/g' $prepfile1 > $prepfile2
if [ ! -f "$prepfile1" ]
then
        printf "+  ${red} Primary Stage of file processing failed! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Primary Processing Stage Completed at $(date): ${lightgreen}PASSED${nc}\n\n"
#
sed 's/mvscreenshot/mv screenshot/g' $prepfile2 > $prepfile3
if [ ! -f "$prepfile2" ]
then
        printf "+  ${red} Secondary Stage of file processing failed! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Secondary Processing Stage Completed at $(date): ${lightgreen}PASSED${nc}\n\n"
#
sed 's/png;convert\/root\//png; convert \/root\//g' $prepfile3 > $prepfile4
if [ ! -f "$prepfile3" ]
then
        printf "+  ${red} Third Stage of file processing failed! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Third Processing Stage Completed at $(date): ${lightgreen}PASSED${nc}\n\n"
#
sed 's/png\/root\//png \/root\//g' $prepfile4 > $prepfile5
if [ ! -f "$prepfile4" ]
then
        printf "+  ${red} Fourth Stage of file processing failed! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Fourth Processing Stage Completed at $(date): ${lightgreen}PASSED${nc}\n\n"
#
sed 's/jpg"/jpg/g' $prepfile5 > $prepfile6
if [ ! -f "$prepfile5" ]
then
        printf "+  ${red} Fifth Stage of file processing failed! ${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Fifth Processing Stage Completed at $(date): ${lightgreen}PASSED${nc}\n\n"
#
#
#What we need to print in total: 'python webscreenshot/webscreenshot.py "http://$ip"'
echo ""
#
uniq $prepfile6 > $prepfile7
# ************************************************************************************************************
echo "Results (top 10 lines): " | pv -qL 30
tail -10 $prepfile7
#
echo ""
#
# ************************************************************************************************************
echo "Splitting $prepfile6 into chunks of 10,000..." | pv -qL 30
split -l 10000 $prepfile7 /root/scripts/circus/screenshotlist/temp/
echo "Buttering the toast..."
sed -i '1 i\#!\/bin\/bash' screenshotlist/temp/*
echo ""
# ************************************************************************************************************
ls /root/scripts/circus/screenshotlist/temp/*
#echo ""
# ************************************************************************************************************
#echo "Removing temp files..." | pv -qL 30
rm $procfile $prepfile $prepfile1 $prepfile2 $prepfile3 $prepfile4 $prepfile5 $prepfile6 $prepfile7
# ************************************************************************************************************
echo "Have some happy little trees..." | pv -qL 30
cat happytrees.txt | lolcat
echo ""
exit
# FOR THE LOVE OF GOD PLEASE DON'T EXECUTE THIS ON YOUR MACHINE, IT WAS CREATED AS A TEST AND IT WORKED.
# echo "Executing on $(cat prepfile7 | wc -l) addresses..." | pv -qL 30
# bash $prepfile7
