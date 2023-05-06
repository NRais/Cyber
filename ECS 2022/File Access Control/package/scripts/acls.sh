#!/bin/sh

######################
#    CREATE ACLS     #
######################

###############
### FOLDERS ###
###############

# set default acls to apply recursively
setfacl -Rm d:g:x /opt/WellingtonClinic/
setfacl -Rm d:o:x /opt/WellingtonClinic/

# allow all to top level folder so they can navigate the file structure
setfacl -m g::x /opt/WellingtonClinic/
setfacl -m o::x /opt/WellingtonClinic/

# set folder acls 
setfacl -m g::x /opt/WellingtonClinic/scripts/
setfacl -m g::r-x /opt/WellingtonClinic/patients/

# NOTE: we would prefer to just use default ACLs here but since the staff have already been created we have to go back and assign them manually. This seems like bad practice. What should be done is default ACLs assigned before staff-create.sh.
# NOTE: we want to recursively give r-x to all directories but do not want to give out execute to files unless they already have it, hence capital X. 
setfacl -Rm g::r-X /opt/WellingtonClinic/staff/ 
setfacl -Rm d:g:r-X /opt/WellingtonClinic/staff/ 

# give receptionist access to write to the patient folder. NOTE: this does not mean they have execute access on files IN the folder.
setfacl -Rm g:Receptionists:rwx /opt/WellingtonClinic/patients/
setfacl -Rm d:g::- /opt/WellingtonClinic/patients/

###############
###  FILES  ###
###############

# sbasicinfo.log
# pbasicinfo.log
# pmedicalrecords.log
# ------
# the permissions assigned for specific staff/patient files are automatically determined by the default permissions. 
# In the case of sbasicinfo.log this will fall under the default permissions assigned for the patients folder.
# In the case of pbasicinfo.log and pmedicalrecords.log their permissions will automatically conform to the default permissions assigned to patients folder (which denies all by default)
#
# During the creation of pbasicinfo.log and pmedicalrecords.log permissions will be given to the correct users as is appropriate.

# file-system-setup.sh
# its too late now to assign perms to the file-system-setup.sh this file is also outside of our folder structure in an unknown location. If there is a concern about other root users accessing the file whe they shouldn't run $ chmod 100 /PATH_TO_FILE/file-system-setup.sh


# start of with ensure all scripts are private. This is equivalent to the not commented out code below. The below code has been left in to note the scripts used.
setfacl -Rm g::- /opt/WellingtonClinic/scripts/

# only the administrator has rights to these, with certain exceptions listed following
#setfacl -m g::- /opt/WellingtonClinic/scripts/staff-create.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/acls.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/audit.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/register-patient.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/assign-doc.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/search-patient.sh
#setfacl -m g::- /opt/WellingtonClinic/scripts/search-doctor.sh

setfacl -m g:ActiveReceptionists:rx /opt/WellingtonClinic/scripts/register-patient.sh 		# any active receptionists including nurses
setfacl -m g:ActiveReceptionists:rx /opt/WellingtonClinic/scripts/assign-doc.sh 			# any active receptionists including nurses
setfacl -m g:Receptionists:rx /opt/WellingtonClinic/scripts/search-patient.sh				# only the receptionist NOT active nurses
setfacl -m g:Receptionists:rx /opt/WellingtonClinic/scripts/search-doctor.sh				# only the receptionist NOT active nurses


# visit.sh
# the registered doctors have access to this. It will be assigned on a case by case basis. For now no one can access.
setfacl -m g::- /opt/WellingtonClinic/scripts/visit.sh

# check-medication.sh
# I don't believe doctors should have access to this even though the matrix says R.
setfacl -m g:Nurses:rx /opt/WellingtonClinic/scripts/check-medication.sh

###############
###  ADMIN  ###
###############

# Finally ensure the admin roles have full access
setfacl -Rm g:Administrator:rwx /opt/WellingtonClinic/
setfacl -Rm d:g:Administrator:rwx /opt/WellingtonClinic/