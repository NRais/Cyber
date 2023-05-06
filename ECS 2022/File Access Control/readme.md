[redacted]	CYBR 371 Assignment 1	[redacted]


**CYBR 371 ASSIGNMENT 1**

Nathanael Rais

**Notes**:** Please find on subsequent pages answers to Task 1 (access control matrix), Task 4 (acls) and Task 13 (nurse privacy protection).

**Assignment Description:**

Please find in the zip file attached the *file-system-setup.sh* which will be run by the root user or an Administrator created prior to the project. The following additional scripts for tasks 3-12 can be found in the folder “scripts”:

![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.001.png)

It is assumed this folder is unzipped to the directory containing *file-system-setup.sh*, so that they can be copied into the /scripts/ folder that is created.

Tasks have been completed using a combination of bash and python 3, shebang headers in the files and import statements for libraries used (where appropriate) have been included.

A large number of assumptions have been made in the completion of this assignment as the assignment handout was incomplete and lacking information in many areas. These assumptions are discussed in the comments found in scripts/python files.

Thank you very much.


**Task 1 – Access Matrix**

**(10 Marks) Create an access matrix of the directories shown in Figure 1 and created by the script file-system-setup.sh (see task 2). For each directory (group of directories) justify the permissions given (e.g., why did you have to give rwx permission to X directory for X staff). The permissions set on these directories must follow the principle of least privilege.**


|<p>***Directories***</p><p>***/Roles***</p>|*Staff*|*Scripts*|*Patients (and subdirectories)*|<p>*Wellington*</p><p>*Clinic*</p>|*Staff/Administrators*|*Staff/Nurses*|*Staff/Receptionists*|*Staff/Doctors*|
| :- | :- | :- | :- | :- | :- | :- | :- | :- |
|*Owner*|Administrator|Administrator|Administrator|Administrator|Administrator|Administrator|Administrator|Administrator|
|*Administrator*|rwx|rwx |rwx|rwx|rwx|rwx|rwx|rwx|
|*Registered Dr.*|--x|--x|r-x|--x|r-x|r-x|r-x|r-x|
|*Unregistered Dr.*|--x|--x|r-x|--x|r-x|r-x|r-x|r-x|
|*Nurse*|--x|--x|r-x|--x|r-x|r-x|r-x|r-x|
|*Receptionist*|--x|--x|rwx|--x|r-x|r-x|r-x|r-x|

- **Administrators** have (rwx) access to everything so they can make changes.
- **Staff**: This folder contains nothing itself. Needs to be accessible to all clinic staff so that they can navigate to the subfolders. (--x only).
- **Staff/\***: This folder has files that can be accessed by all staff but only administrators can make changes. Staff are allowed to view the folder contents. (r-x only).
- **Scripts**: This folder contains files that some roles will want to execute. Those roles need to be able to access this folder and hence have (--x) permissions. They do not need to be able to see all the files so no read permissions.
- **Patients**: Basic info can be viewed by all staff, so all staff should have access to the folders and subfolders. (r-x) Receptionist should be able to create patients so should have write permissions.
- **Wellington Clinic**: This folder should not be accessed/modified by anyone but admins but all users need to be able to traverse it to reach scripts/other details. (--x)

**Task 4. (5 Marks) Explain in detail where the ACL information of an object is saved on a Linux system (EXT2, 3 and 4 file systems) and how your system keeps track of them.**

ACL stands for Access Control List. It provides additional flexible permissions for file systems. ACL information is metadata associated with file objects. Traditionally stored in separate blocks on the disk and accessed via file inodes you can view acls with the `getfacl` command:

![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.002.png)

Linux systems (ext2/3/4) use an Extended Attribute mechanism so that other kernel and user space extensions are able to link ACLs with their file objects.

In Linux systems each inode has a field called “i\_file\_acl”. If this field is non zero it contains the number of the file system block in which the Extended Attributes are stored for this object. To improve efficiency multiple inodes can point to the same EA block. For traditional mechanisms the workload required by the EA system is very efficient as there is consistently duplicate EAs. Ext3 takes this a further step by keeping a LRU list of recently accessed EA blocks and a table to store location/checksum of EAs. This allows the system to keep track of commonly used EAs for fast lookup.

See below the inode associated with the file:

![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.003.png)

**Task 13. (10 Marks) Nurses having r (read) access to the pmedicalrecord.log file is a serious vulnerability even though the access to information is filtered through the interface (i.e. check-medication.sh) to view the permitted information within the file only. Propose alternative methods to minimize the risk of confidentiality violation of patient’s medical history information and justify the proposed method(s). Discuss in detail how your method would achieve that, implement your solution, and illustrate its effectiveness.**

The most simplistic solution requiring limited alteration to access control model would be to add an additional file to each patient called “pprescription-info.log”. This file would be generated in parallel with pmedicalrecord.log. It would contain only information the receptionists are allowed to view and the receptionist would have read only access to this file. Check-medication.sh would no longer query pmedicalrecord.log, which is currently creating a vulnerability in the data confidentiality. Now the receptionists would never be touching or accessing any information except what was absolutely necessary as per the principle of least privilege.

See check-medication2.sh, register-patient2.sh and visit2.sh for the implementation of this solution. In conjunction with this the acls.sh would be changed so that on patient creation setfacl on pmedicalrecord.sh would give access only to the pbasicinfo.sh not pmedicalrecord.sh (default permissions deny all except execute access then grant permissions to pbasicinfo.sh on creation).

![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.004.png)![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.005.png)

The illustration that this solution is effective is quite simple. The nurse now no longer can read the pmedicalrecord.log file, because they don’t have read access:

![](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.006.png)

***Bonus Marks Alternative Solution:***

A less robust solution that could also be implemented involves adding a line to the sudoers file located in “/etc/sudoers”:

![How Can I Sudo Another User Without A Password?](Aspose.Words.239ee2d3-3048-41c1-96d5-2e83898f05a2.007.png)

This file allows us to define additional privileges and system rights to users. This could allow us to deny all permissions to the receptionist so there is no possibility of data breach or privacy issues. Then in the sudoers file we can specify that the Nurse role can run the specific script “check-mediciation.sh” as administrator (via adding a line such as: “% Receptionists ALL=NOPASSWD: /opt/WellingtonClinic/scripts/check-medication.sh”). This would allow a command such as “sudo -g Administrator ./check-medication.sh” to elevate permissions for the check-medication.sh script to that which has read access of the necessary file systems. This is a less robust solution, requires more user engagement and presents more security vulnerabilities but it has been added to illustrate understanding of access control and alternative options.

Note: **do not** edit the sudoers file directly. Use visudo run as root. 


