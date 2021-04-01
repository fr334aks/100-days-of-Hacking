### Write up for Lame Machine HTB

Lame was scanned and found to be running 

FTP                   21
SSH                   22
SMB                 139
SMB over TCP  445




Enumerating SMB using smbclient, A persistent  error “(Error NT_STATUS_UNSUCCESSFUL)”  slowed the progress after carefull enumeration it was detected that the SMB version running on the host was a V1 , 
and a proper instruction has to be sent with “smbclient”   which is declaring the version for smbclient should probe at 

the propers syntax that eventually worked : smbclient -L //10.10.10.3/ -N --option='client min protocol=NT1'
More of the files in the SMB share are log files with irrelevant data

Lookin up the scan again , i thought of a cafefull examinations of the services running , checking "Samba 3.0.20-Debian"  whci is running the SMB service 
we figured the service is vulnerable to a direct root exploit 

“
Samba "username map script" Command Execution
”


running the exploit we get a direct root shell on LAME , ans submitted the flags 
## YiPeeee

Time to User:  1 Hour 
Time to Root : 1 Hour 
