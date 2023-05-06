#!/bin/sh

######################
#    CREATE STAFF    #
######################

# [GROUPS] setup staff groups
groupadd Doctors
groupadd Nurses
groupadd Receptionists
groupadd ActiveReceptionists
groupadd Administrators

# [USERS] create our staff
# NOTE: we don't yet generate home directories or passwords as this is just a structural setup, these should be created for full staff functionality.
useradd mate1997
useradd brki2018
useradd mada1993
useradd labo2002
useradd lubl2004
useradd phmc2008
useradd ansm2002
useradd pasa1995

# add our staff to the groups
usermod -g Doctors mate1997
usermod -g Doctors brki2018
usermod -g Doctors mada1993
usermod -g Doctors labo2002
usermod -g Nurses lubl2004
usermod -g Nurses phmc2008
usermod -g Receptionists ansm2002
usermod -g ActiveReceptionists ansm2002

# [DIRECTORIES] generate directories for each staff member
mkdir /opt/WellingtonClinic/staff/doctors/mate1997/
mkdir /opt/WellingtonClinic/staff/doctors/brki2018/
mkdir /opt/WellingtonClinic/staff/doctors/mada1993/
mkdir /opt/WellingtonClinic/staff/doctors/labo2002/
mkdir /opt/WellingtonClinic/staff/nurses/lubl2004/
mkdir /opt/WellingtonClinic/staff/nurses/phmc2008/
mkdir /opt/WellingtonClinic/staff/receptionists/ansm2002/
mkdir /opt/WellingtonClinic/staff/administrators/pasa1995/

# [FILES] generate files for each staff
echo "Mary Teresa, 03/08/1953, 1997, 173 Rnd street Kelburn, m.theresa@yahoo.com, 04528293" > /opt/WellingtonClinic/staff/doctors/mate1997/sbasicinfo.log
echo "Breana Kipling, 03/08/1991, 2018, 4548 River Road HugoTown Auckland 5513, szzh8@tempmail.net, 071943668" > /opt/WellingtonClinic/staff/doctors/brki2018/sbasicinfo.log
echo "Mandy Dannel, 15/12/1965, 1993, 343 Norma Avenue Dayton Napier 6731, mandydl@gmail.com, 052637445" > /opt/WellingtonClinic/staff/doctors/mada1993/sbasicinfo.log
echo "Lance Bourne, 07/04/1970, 2002, 25 Ferguson Street Franklin Greytown 8567, lancb@outlook.com, 083736456" > /opt/WellingtonClinic/staff/doctors/labo2002/sbasicinfo.log
echo "Lucia Blakeley, 11/09/1980, 2004, 935 Massachusetts Avenue Hamilton 4562, lucyblak@outlook.com, 38347463" > /opt/WellingtonClinic/staff/nurses/lubl2004/sbasicinfo.log
echo "Phil McGraw, 15/04/1984, 2008, 45 Razyn Street Petone Lower Hutt 8435, philmcg@gmail.com, 02384756" > /opt/WellingtonClinic/staff/nurses/phmc2008/sbasicinfo.log
echo "Andy Smith, 13/09/1974, 2002, 58 Foster avenue Wellington 5011, smith.andy74@gmail.com, 07284756" > /opt/WellingtonClinic/staff/receptionists/ansm2002/sbasicinfo.log
echo "Pauline Sanderson, 08/03/1993, 1995, 2452 Randolph Street Bedford Auckland 7752, paulsand@admins.co.nz, 03747543" > /opt/WellingtonClinic/staff/administrators/pasa1995/sbasicinfo.log


# [ADMIN]
# The assumption here is that the administrator user who owns all the files is root:
# A) there has to be an Administrator to make the Administrator role; and 
# B) it would be a security issue for Pauline to own the files.
#
# However, if this assumption is not correct please see commands in file-system-setup.sh to allow the user pasa1995 to own the file structure.

usermod -g Administrators pasa1995
usermod -G sudo,root pasa1995