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
echo "Welcome to the Masscan Importer (Master-by-Bob-Ross-With-Happy-Trees-V1.3)." | pv -qL 15
echo ""
# Begin
# ******************************************************************
echo 'Loading Variables...' | pv -qL 15
# Les Variables;
#
# Scan Files:
allscans='/root/scripts/circus/raw_outputs/archive/public1/public1.log'
# Sanitised File
san='/root/scripts/circus/temp/san.log'
# Do I need to explain this one?
nocommas='/root/scripts/circus/temp/nomorecommas.csv'
# Processing Files
outfileone='/root/scripts/circus/temp/outfileone.csv'
fileonedone='/root/scripts/circus/temp/outfileonedone.csv'
fileoneready='/root/scripts/circus/temp/outfileoneready.csv'
outfiletwo='/root/scripts/circus/temp/outfiletwo.csv'
filetwodone='/root/scripts/circus/temp/outfiletwodone.csv'
outfilethree='/root/scripts/circus/temp/outfilethree.csv'
filethreedone='/root/scripts/circus/temp/outfilethreedone.csv'
#
# To be sent to SEC-HQ-01 for processing...
sendfile='/root/scripts/circus/temp/sendfile.csv'
#
# Move files because of 'secure file priv'
fileoneimport='/var/lib/mysql-files/fileone.csv'
filetwoimport='/var/lib/mysql-files/filetwo.csv'
filethreeimport='/var/lib/mysql-files/filethree.csv'
#
# Colours
lightgreen='\033[1;32m'
lightpurple='\033[1;35m'
red='\033[0;31m'
nc='\033[0m'
#
user='yourusername'
pass='yourpassword'
#
# -- End Vars --
printf "+  ${lightgreen}OK${nc}\n\n"
#
# ******************************************************************
#
echo "Gathering all responding devices' headers/banners..." | pv -qL 15
# -- THIS SECTION GETS ASSIGNS ID NUMBERS AND GATHERS PORT NUMBER VALUES ONLY --
# Sanitise the input;
cat $allscans | grep -E "banner tcp" >> $san
#
if [ ! -f "$san" ]
then
        printf "+  ${red} SANITISED FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Sanitised file created: ${lightgreen}OK${nc}\n\n"
#
echo "Removing commas from the source file..." | pv -qL 15
# Remove Commas ( , )
sed 's/,/ /g' $san > $nocommas
if [ ! -f "$nocommas" ]
then
        printf "+  ${red} SOURCE FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Source file created: ${lightgreen}OK${nc}\n\n"
#
echo "Gathering the port numbers..." | pv -qL 15
# Gather Columns;
#columns $1 & $2 are now deprecated, due to $1 & $2 being "open" & "banner"; useless!
#cat $nocommas | awk -vORS=, '{ print $1,$2,$3 } ' >> $outfileone # Outputs with no new lines
cat $nocommas | awk -vORS=, '{ print $3 } ' >> $outfileone # Outputs with no new lines
sed 's/,/,\n/g' $outfileone > $fileonedone # Now with new lines
if [ ! -f "$fileonedone" ]
then
        printf "+  ${red} PORT FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Port file created: ${lightgreen}OK${nc}\n\n"
#
echo "Assigning IDs to the port numbers..." | pv -qL 15
#Assign IDs
#
i=0 ; while read; do   printf '%d %s\n' $(( ++i )) ", $REPLY"; done < $fileonedone > $fileoneready
if [ ! -f "$fileoneready" ]
then
        printf "+  ${red} PORT ID FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Port ID file created: ${lightgreen}OK${nc}\n\n"
#
# -- THIS SECTION ASSIGNS ID NUMBERS AND RETURNS THE IP ADDRESSES --
echo "Gathering the [IPv4] IP addresses..." | pv -qL 15
cat $nocommas | awk '{ print $4} ' >> $outfiletwo
if [ ! -f "$outfiletwo" ]
then
        printf "+  ${red} IP ADDRESS FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  IP Address file created: ${lightgreen}OK${nc}\n\n"
#
echo "Assigning IDs to the IP Addresses..." | pv -qL 15
#Assign IDs
#
d=0 ; while read; do   printf '%d %s\n' $(( ++d )) ", $REPLY"; done < $outfiletwo > $filetwodone
if [ ! -f "$filetwodone" ]
then
        printf "+  ${red} IP ADDRESS ID FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  IP ID file created: ${lightgreen}OK${nc}\n\n"
#
# -- NOTICE FOR USER --
printf "*************************${red}X${nc}*************************\n"
echo "This import function has sent off the list of IPs "
printf "To: ${lightgreen}SEC-HQ-01/root/scripts/circus/screenshotlist.txt${nc}\n"
printf "*************************${red}X${nc}*************************\n"
# -- THIS SECTION ASSIGNS ID NUMBERS AND RETURNS THE BANNERS --
echo "Gathering all banners/headers... [this may take some time...]" | pv -qL 15
cat $nocommas | awk '{ print $5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20} ' >> $outfilethree

if [ ! -f "$outfilethree" ]
then
        printf "+  ${red} BANNER FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Banner file created: ${lightgreen}OK${nc}\n\n"
#
echo "Assigning IDs to the banners/headers..." | pv -qL 15
#Assign IDs
f=0 ; while read; do   printf '%d %s\n' $(( ++f )) ", $REPLY"; done < $outfilethree > $filethreedone
if [ ! -f "$filethreedone" ]
then
        printf "+  ${red} BANNER ID FILE NOT FOUND!!!${nc}\n\n"
        echo "exiting"
        exit
fi
        printf "+  Banner ID file created: ${lightgreen}OK${nc}\n\n"
#
# ******************************************************************
#
# MySQL is a B****
mv $fileoneready $fileoneimport
mv $filetwodone $filetwoimport
mv $filethreedone $filethreeimport
#
# -- CLEAR PREV --
#
while true; do
    read -p "Do you wish to continue? This will remove current eentries and will move them to: /root/scripts/circus/dbbackups/overwatch-backup-on$(date +%F_%R).sql (Y/n):  " yn
    case $yn in
        [Yy]* ) echo "Backing up previous imports..." | pv -qL 15; mysqldump --user="$user" --password="$pass" overwatch > "/root/scripts/circus/dbbackups/overwatch-backup-on$(date +%F_%R).sql" 2>/dev/null ; printf "${lightgreen}OK${nc}\n"; echo "Truncating previous data..." pv -qL 15; mysql --user=$user --password=$pass -e "USE overwatch;truncate table portnumbers;" 2>/dev/null;mysql --user=$user --password=$pass -e "USE overwatch;truncate table ipaddr;" 2>/dev/null;mysql --user=$user --password=$pass -e "USE overwatch;truncate table banner;" 2>/dev/null; printf "+  ${lightgreen}OK${nc}\n\n" ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
# -- IMPORT THE SUCKERS! --
echo "Beginning Import Function..." | pv -qL 15
echo ""
echo "Importing the port numbers..." | pv -qL 15
#port numbers
mysql --user=$user --password=$pass -e "USE overwatch;LOAD DATA INFILE '/var/lib/mysql-files/fileone.csv' INTO TABLE portnumbers FIELDS TERMINATED BY ','  LINES TERMINATED BY '\n'" 2>/dev/null
printf "+  ${lightgreen}OK${nc}\n"
echo "Port Numbers Count;"
mysql --user=$user --password=$pass -e "USE overwatch;SELECT COUNT(*) FROM portnumbers;" 2>/dev/null
echo "Importing the IP addresses..." | pv -qL 15
#ip addresses
mysql --user=$user --password=$pass -e "USE overwatch;LOAD DATA INFILE '/var/lib/mysql-files/filetwo.csv' INTO TABLE ipaddr FIELDS TERMINATED BY ','  LINES TERMINATED BY '\n'" 2>/dev/null
printf "+  ${lightgreen}OK${nc}\n"
echo "IP Address Count;"
mysql --user=$user --password=$pass -e "USE overwatch;SELECT COUNT(*) FROM ipaddr;" 2>/dev/null
echo "Importing the banners..." | pv -qL 15
#banners
mysql --user=$user --password=$pass -e "USE overwatch;LOAD DATA INFILE '/var/lib/mysql-files/filethree.csv' INTO TABLE banner FIELDS TERMINATED BY ','  LINES TERMINATED BY '\n'" 2>/dev/null
printf "+  ${lightgreen}OK${nc}\n"
echo "Banners Count;"
mysql --user=$user --password=$pass -e "USE overwatch;SELECT COUNT(*) FROM banner;" 2>/dev/null
#
# Join Le Data; R U MAD?!!?!?!?!?!?!
#mysql --user=$user --password=$pass -e "USE overwatch;SELECT * FROM portnumbers NATURAL JOIN ipaddr NATURAL JOIN banner;"
#
#
#
rm -rf $san $outfileone $fileonedone $outfiletwo $filetwodone $outfilethree $filethreedone $fileoneimport $filetwoimport $filethreeimport $nocommas $sendfile
#
#
#
# Done?
printf "${lightgreen} Have some happy trees...${nc}\n\n"

cat happytrees.txt | lolcat

exit
