#!/usr/bin/env python3
	
# NOTE: This script can be run only by nurses. It is designed to register a new patient by creating files/folders necessary.
#
# THIS SCRIPT IS DESIGNED FOR TASK 13 AND EXPANDED IMPLEMENTATION
#
# - When run this script will create an additional file 'pprescription-info.log'
# - This file will act as a record of prescription info so nurses do not gain read access to medical info
#
# This script assumes python3 is installed (since it is installed on all ecs machines), if it is not installed please run "apt-get install python3"

import os

## FUNCTIONS ##
# NOTE: functions defined before main method because it is not possible to forward-declare in python. Don't bully pls, I had to learn python while doing this assignment.

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

# function to request registered doctors info
def getRegisteredDoctors():
	registeredDoctor = input("\nRegistered Doctors (seperated by comma):")
	return registeredDoctor.split(",");
	# ------------------
	
# function that parses a patient id from a fullname and date of birth
def getPatientID(name, date):
	
	parsedDate = date.replace("/", "")
	parsedName = name[0] + name[-1]
		
	return parsedName + parsedDate;
	# ------------------
	
# function to create a file with the input data
def create_patient(patientID, vars, docs):
 
	# create the directory for the patient
	basic = '/opt/WellingtonClinic/patients/' + patientID + '/pbasicinfo.log'
	medical = '/opt/WellingtonClinic/patients/' + patientID + '/pmedicalrecord.log'
	prescription = '/opt/WellingtonClinic/patients/' + patientID + '/pprescription-info.log'
	os.makedirs(os.path.dirname(basic), exist_ok=True)
	
	f = open(basic, "w")
	f.write(listToString(vars) + "," + listToString(docs))
	f.close()
	
	g = open(medical,"w")
	g.close()
	
	h = open(prescription,"w")
	h.close()
	# ------------------

# parent function which calls all the necessary steps
def generate_patient(vars):
	fullname = vars[0]+vars[1]
	dateOfBirth = vars[2]
	myid = getPatientID(fullname, dateOfBirth)
	
	docs = getRegisteredDoctors()
	
	create_patient(myid,vars,docs)
	# ------------------
	
###################	
	
# main method

# prompt the user to enter information
continuePrompt = input("Enter the following information about the patient as prompted, (press Y to continue N to exit or paste the full patient details as a CSV to automatically parse):\n")

# print(f'You entered {continuePrompt}')

# Y launches the input
if continuePrompt == 'Y':
	fname = input("First Name:")
	lname = input("Last Name:")
	fullname = fname+lname
	dateOfBirth = input("Date of Birth:")
	gender = input("Gender:")
	address = input("Physical Address:")
	email = input("Email:")
	phone = input("Phone:")
	
	vars = [fname, lname, dateOfBirth, gender, address, email, phone]

	generate_patient(vars)
	# ------------------
	
# N terminates the function
elif continuePrompt == 'N':
	print("\nTerminate")
	# ------------------
	
# if they enter something else we will assume they want it parsed as a CSV
# NOTE: this is mostly for ease of testing purposes and in reality would be removed as functionality so the staff don't break anything.

# we expect the comma seperated file to contain 7 arguments:
# First Name
# Last name
# Date of Birth
# Gender
# Physical Address
# Email
# Phone
else:

	vars = continuePrompt.split(",")
	print(vars)
	
	generate_patient(vars)
	# ------------------
