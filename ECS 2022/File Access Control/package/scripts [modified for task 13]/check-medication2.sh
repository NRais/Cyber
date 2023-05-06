#!/usr/bin/env python3
	
# NOTE: This script can be run only by nurses. It is designed to list the medication for a patient and doctor who prescribed it.
#
# THIS SCRIPT IS DESIGNED FOR TASK 13 AND EXPANDED IMPLEMENTATION
#
# - When run this script will access the new file 'pprescription-info.log' instead of 'pmedicalrecord.log'
# - This file will act as a record of prescription info so nurses do not gain read access to medical info
#
#
# This script assumes python3 is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"

import glob

## FUNCTIONS ##

# function to get the patient ID from the patient name
def getPatientID(patientName):
	# first calculate the first and last letters
	startOfID = patientName[0] + patientName[-1]
	
	# then find folders that suit
	for file in glob.glob('/opt/WellingtonClinic/patients/' + startOfID + "*"):

		# go check the acutal log file to ensure this is the right user
		if checkFileForName(patientName, file):
			return file

	
	# else we have found nothing
	return ''
	# ------------------
	
# function to check the pbasicinfo.log file for the patient's name
def checkFileForName(patientName, fileName):
	
	f = open(fileName + '/pbasicinfo.log', "r")
	contents = f.read().split(",")
	
	#print('CONTENTS: ' + contents[0] + " " + contents[1] + " versus " + patientName)
	
	if patientName == contents[0] + " " + contents[1]:
		return True
	else:
		return False
	# ------------------
	
# function to append the doctor to the patient's basicinfo file
def checkPatientMedication(patient):
	filename = patient + '/pprescription-info.log'
	
	# append doctors to file
	f = open(filename, "r")
	
	lines = f.readlines()
	
	# for each line extract the dosage and the doctor
	for l in lines:
		vals = l.split(",")
		
		# error checking
		if len(vals) > 1:
			print("Doctor: " + vals[0] + ", prescribed: " + vals[1])
		
	
	# ------------------

###################


# main method

# query the patient name
name = input("What patient would you like to query? ")

patientID = getPatientID(name)

# find the patient log and output the medications
checkPatientMedication(patientID)
