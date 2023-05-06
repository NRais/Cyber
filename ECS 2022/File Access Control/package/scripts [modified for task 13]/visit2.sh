#!/usr/bin/env python3
	
import glob
	
# NOTE: This script can be run only by registered doctors. It allows a doctor to add an entry to a pmedicalrecord and pprescription-info.
#
# EXAMPLE MEDICAL RECORD: 
# date-of-visit,doctor-examined,healthissue,medication,dosage 
#
# 11/2/2020,mate1997,belly itch ,scratchicilin,2 per day
#
# EXAMPLE PRESCRIPTION:
# doctor-examined, medication
#
# mate1997, scrtachicilin
#
#
# This script assumes python 3.5+ is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"

## FUNTIONS ##

# function to open a file by a certain patientID and add a medical record
def writeToFile(patient, record):

	medical = patient + '/pmedicalrecord.log'
	prescription = patient + '/pprescription-info.log'
	
	f = open(medical, "a")
	f.write("\n" + listToString(record))
	f.close()
	
	# create an alternative shorter list for prescription file
	prescriptions = [ record[1], record[3] ] 
	
	f = open(prescription, "a")
	f.write("\n" + listToString(prescriptions))
	f.close()
	# ------------------
	
# function to get the information to record
def queryInformation():

	datehere = input("Date Visited:")
	doctor = input("Doctor ID:")
	healthissue = input("Health Issue:")
	medication = input("Medication:")
	dose = input("Dose:")
	
	record = [datehere, doctor, healthissue, medication, dose]

	return record
	# ------------------
	
# function to get the patient ID from the patient name
def getPatient(patientName):
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

# function to parse strings together into csv output
def listToString(s): 
    
    # initialize the string as just the first element
    str1 = s[0]
    
    # traverse in the list but not the first element which is already added, adding commas between
    for ele in s[1:]:
        str1 += "," + ele
    
    # return string
    return str1
	# ------------------
	
################

# main method
patient = getPatient(input("What patient would you like to add a doctor visit for? "))

record = queryInformation()

writeToFile(patient, record)
