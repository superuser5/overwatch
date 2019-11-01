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
echo "Welcome to the Masscan Data Joiner (Master-by-Bob-Ross-With-Happy-Trees-V1.3-Join-At-The-Knee)." | pv -qL 15
echo ""
# Begin
# ******************************************************************
echo 'Loading Variables...' | pv -qL 15
# Les Variables;
#
# Colours
lightgreen='\033[1;32m'
lightpurple='\033[1;35m'
red='\033[0;31m'
nc='\033[0m'
#
#Creds
user='yourusername'
pass='yourpassword'
#
# -- End Vars --
printf "+  ${lightgreen}OK${nc}\n\n"
#
# ******************************************************************

mysql --user=$user --password=$pass -e "USE overwatch;show tables;" 2>/dev/null
echo ""
read -p "Which table would you like to put the join into? (caps sensitive):  " tblname
echo ""
echo "Calculating amount of records to Join into $tblname:"
echo ""
mysql --user=$user --password=$pass -e "USE overwatch;select count(*) from ipaddr;" 2>/dev/null
mysql --user=$user --password=$pass -e "USE overwatch;select count(*) from portnumbers;" 2>/dev/null
mysql --user=$user --password=$pass -e "USE overwatch;select count(*) from banner;" 2>/dev/null
echo ""
printf "+  Executing your query on: ${lightgreen}$tblname${nc}...\n"
echo ""
mysql --user=$user --password=$pass -e "USE overwatch;insert into $tblname select * from banner natural join ipaddr natural join portnumbers order by id;" 2>/dev/null
echo ""
printf "*** ${lightgreen}Import Complete${nc} ***\n"
echo ""
mysql --user=$user --password=$pass -e "USE overwatch;select count(*) from $tblname;" 2>/dev/null
