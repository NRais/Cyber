#!/bin/bash

# Generate the directory structure
# NOTE: we must use bash and not zsh interpretter for the following line to correctly generate the folder structure
mkdir -p /opt/WellingtonClinic/{staff/{administrators,nurses,receptionists,doctors},scripts,patients}

# Copy the scripts to the scripts folder now. This is a necessary assumption or else the scripts folder is empty.
cp -a scripts/ /opt/WellingtonClinic/ 

## ADDITIONAL ASSUMPTIONS ##

# NOTE: The briefing stated that the Administrator should own all files. However, the Administrator group does not exist when staff files are generated.
# To allow the administrator to own these files please generate the Administrator role before running staff-create.sh
#
# Ex: 
# $ groupadd Administrators
# $ useradd pasa1995
# $ usermod -g Administrators pasa1995
# $ usermod -G sudo,root pasa1995
# $ su - pasa1995


# NOTE: Additionally, the receptionist is specified to create patient files in the briefing. If this is done they will be owned by the receptionist. 
# To allow receptionists to create files owned by the administrators add the following line to the sudoers file:
#
# %Receptionists ALL=NOPASSWD: /opt/WellingtonClinic/scripts/register-patient.sh
#
# Then the receptionist can run the registration via:
#
# $ sudo -g Administrator ./register-patient.sh