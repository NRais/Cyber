#!/usr/bin/env python3

import glob
import subprocess

# NOTE: This script can only be run by receptionists. It is designed to add doctors to the patient files.
#
# This script assumes python3 is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"


## FUNCTIONS ##
	
# function to get the doctor ID from the doctor's name
def getRegisteredDoctor(doctorName):

	firstname = doctor.split(" ")[0]
	lastname = doctor.split(" ")[1]

	# first calculate the initial string of the doctor
	startOfID = firstname[0] + firstname[1] + lastname[0] + lastname[1]
	
	# then find folders that suit
	for file in glob.glob('/opt/WellingtonClinic/staff/doctors/' + startOfID + "*"):

		# go check the acutal log file to ensure this is the right user
		if checkFileForName(firstname + lastname, file, "sbasicinfo.log"):
			return file

	
	# else we have found nothing
	return ''
	# ------------------
	
# function to get the patient ID from the patient name
def getPatientID(patientName):
	# first calculate the first and last letters
	startOfID = patientName[0] + patientName[-1]
	
	# then find folders that suit
	for file in glob.glob('/opt/WellingtonClinic/patients/' + startOfID + "*"):

		# go check the acutal log file to ensure this is the right user
		if checkFileForName(patientName, file, "pbasicinfo.log"):
			return file

	
	# else we have found nothing
	return ''
	# ------------------
	
# function to check the pbasicinfo.log file for the staff or patient's name
def checkFileForName(patientName, fileName, type):
	
	f = open(fileName + '/' + type, "r")
	contents = f.read().split(",")
	
	# we do a lower case string comparison to see if the name input actually meets the name included
	if patientName.lower() == contents[0].lower() + " " + contents[1].lower():
		return True
	else:
		return False
	# ------------------
	
# function to append the doctor to the patient's basicinfo file
def editPatientFile(patient, doctorID):
	filename = patient + '/pbasicinfo.log'
	
	# append doctors to file
	f = open(filename, "a")
	f.write("," + doctorID)
	f.close()
	# ------------------
	
def giveDoctorPermissions(doctorID, patientID):
	# NOTE: for file permission modification this can be done directly in python using the subprocess library (if it is installed)
	subprocess.run(["setfacl", "-m", "u:" + doctorID + ":rw", '/opt/WellingtonClinic/patients/'])
	
	# output changes
	print(f"{doctorID} now has permissions to access {patientID} medical record.")


###################	
	

# prompt the user to enter information
patient = input("Enter the patient's name:\n")
doctor = input("Enter the doctor's name (first and last name seperated by a space): \n")

doctorID = getRegisteredDoctor(doctor)

patientID = getPatientID(patient)

if (patientID != ''):
	editPatientFile(patientID, doctorID)
else:
	print("Patient Not Found")
	
giveDoctorPermissions(doctorID, patientID)