#!/usr/bin/env python3
	
# NOTE: This script can be run only by administrator. If you are not an admin please close this file and immediately report this access violation to the acting admin.
#
# DETAILS:
#
#  1) Script sets up default rules for what changes in permissions, creations, deletions of files and modifications within WellingtonClinic directory.
#
#  2) If there are already rules setup the second part of this script retrieves the logs of what rules have been triggered.
#
#  3) Once logs have been retrieved we parse the logs to 
#
# This script assumes python3 is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"
# This script will be installing auditd, auditctl, ausearch. auditctl sets the rules and ausearch retrieve the logs to view afterwards.

import glob
import subprocess

## FUNCTIONS ##

def rulesHaveBeenDefined():
	
	rules = # method to analyse system to see if rules are in place
	
	return rules
	# -------------
	

def defineActivateRulesForClinic():

	# install logging library if it is not installed
	subprocess.run(["apt-get", "install", "auditd"])

	# use auditctl to set rules for what to log

	# -------------

	
def disableActiveRulesForClinic():

	# use auditctl to disable logging rules

	# -------------


def retrieveLogFiles():

	# use ausearch to query the log files

	# -------------


def parseLogDump(logdump):

	// output header
	print("USERNAME \t\t\t OBJECT \t\t\t OPERATION \t\t\t date")

	// go through the logdump for each entry
	while "\n" in logdump:
		username = parseUserName(logdump)
		object = parseObject(logdump)
		operation = parseOperation(logdump)
		dateVal = parseDate(logdump)
		
		print(f"{username} \t\t\t {object} \t\t\t {operation} \t\t\t {dateVal}")
		
		# then substring/knock that log off the logdump
		len = logdump.index("\n")
		logdump = logdump[len:]
		

	# -------------

###############


# main method

# check for logging active
if rulesHaveBeenDefined():

	deativate = input("Logging rules active, to retrieve logs type '1', to deactivate logging type '2': ")
	
	if deactivate == '1':
		logdump = retrieveLogFiles()
		
		parseLogDump(logdump)
		
		
	else:
		
		disableActiveRulesForClinic()
		
		print("Logging rules deactivated.")
	
# otherwise activate it
else:
	
	defineActivateRulesForClinic()
	
	print("Logging rules have now been activated.")