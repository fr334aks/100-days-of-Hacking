Sense was a direct root machine from HTB that started with a port scan showing port 80 http & https 443

the certificate hold no usernames and domain information which led me to bruteforce directory on port 443 usinng gobuster and the "-k" flag to ignore ssl certificate negotation

eventually found username to pfsense on port 80 as rohit, and used pfsense defaut password, 
getting into the admin dashboard , did searchsploit  to find authenticated RCE that led to direct root

Easy but it was difficult to find the username info 


![image](https://user-images.githubusercontent.com/12541755/113688896-59710180-968f-11eb-8009-29ade8d9684d.png)
