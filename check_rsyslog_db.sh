#!/bin/bash
# 
# 'check_rsyslog_db' a Bash script to check writing in an rsyslog database
#
# 
# Copyright: (c) 2021, Mickaël Duchet <sodbaveka@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Mickaël DUCHET (aka sodbaveka)
#
# History:
# - 0.1: add options
#
#==================================================
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor Boston, MA 02110-1301,  USA
#
# http://www.gnu.org/licenses/gpl.txt
#
#==================================================
# Debug mode
#set -x 
#
program_name="check_rsyslog_db";
program_version="0.1";
program_date="03/2021";
#
# Programs argument management
#-----------------------------
while getopts ":hv" option; do
	case $option in
		h) # display Help
			printf "$program_name $program_version\n";
			printf "usage: $program_name [options]\n";
			printf " -h: Print the command line help\n";
			printf " -v: Print the program version\n";
			#printf " -w <int>: Warning value (number of SYN_RECV)\n";
			#printf " -c <int>: Critical value (number of SYN_RECV)\n";
			exit;;
		v) # Display the version
			printf "$program_name $program_version ($program_date)\n";
			exit;;
		\?) # incorrect option
			echo "Error: Invalid option"
			exit;;
	esac
done

# Main program
#-------------


# clear variable
result=" "

# save timestamp
testlog=`date +%s`

# make entry in the system log
logger -p local7.info -t testlog -s $testlog

# 5 second pause
sleep 5

# check new entry in rsyslog database
result=`mysql -u root -h localhost -D Syslog -e "SELECT Syslogtag, Message FROM SystemEvents WHERE Syslogtag=\"testlog:\" AND Message=CONCAT(\" \", \"$testlog\")"`

if [ -n "$result" ]
then
    echo "OK - rsyslog database in working order"
    exit 0
else
    echo "CRITICAL - rsyslog database out of order"
    exit 2
fi
