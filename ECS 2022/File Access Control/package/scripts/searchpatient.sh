#!/usr/bin/env python3

import glob
	
# NOTE: This script can be run only by receptionists (excluding nurses). It is designed to search medical records for doctors.
# This script assumes python 3.5+ is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"

root_dir = '/opt/WellingtonClinic/patients/'



### FUNCTIONS ###

# function to search all patient folders and all medical logs in the folders and find any listings of the correct doctor
def recurseAllFiles():

	patientList = []

	# root_dir needs a trailing slash (i.e. /root/dir/)
	for filename in glob.iglob(root_dir + '**/pbasicinfo.log', recursive=True):
		print("FILE" + filename)
		
		if checkFileForName(doctorName, filename):
			
		 
	return patientList
	#-------------------

# function to get the doctor ID from the doctor's name
def getDoctor(firstname, lastname):

	# first calculate the initial string of the doctor
	startOfID = firstname[0] + firstname[1] + lastname[0] + lastname[1]
	
	# then find folders that suit
	for file in glob.glob('/opt/WellingtonClinic/staff/doctors/' + startOfID + "*"):

		# go check the acutal log file to ensure this is the right user
		if checkFileForName(firstname + lastname, file):
			return file

	
	# else we have found nothing
	return ''
	# ------------------
	
# function to check the sbasicinfo.log file for the doctors's name
def checkFileForName(doctorName, fileName):
	
	f = open(fileName + '/sbasicinfo.log', "r")
	contents = f.read().split(",")
	
	if doctorName == contents[0] + " " + contents[1]:
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
	
	
	
	
###############

# main method

# first query the fullname/username of a Doctor
name = input("What doctor would you like to query? (seperate first and last name with a space)").split(" ")
firstname = name[0]
lastname = name[1]

doctor = getDoctor(firstname, lastname)
	
# now we take the doctors name and go find all occurances
patients = recurseAllFiles(doctor)

# output the results
print("Doctor \t\t\t\t Patients\n")
print(f"{name} ({doctor}) \t\t\t\t ")
print(listToString(patients))