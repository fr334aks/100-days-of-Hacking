DAY 0x01
A journey of a thousand steps starts with one steps
a master has failed more times than a beginner has startes
Malware analysis and reverse enginerring use the same knoledge set but difrent aplications

i will first start day one by metniong things that seem important to remember 
and check on once you have so that this file can become a cheat cheat of sorts :-)

Archtecture this is used to describe the size of the busses(<i>this is the device that transmit info</i>)   that a computer has
mainly x86 also known as 32 bit,i386 ps( i preffer this one,its not very complex);
2.arm,
3.amd64,64bit,x86-64 (it is the best of the three)

eddianes this refers to the how the computer stores data big edian stores data in a sane way
that is left to right while little edian breaks the laws of reletivity by going backwords ,right to left

also files are usualy separated into parts while compling called sections
.text this parts contains the assembly code that runs the code

<h3>debugers</h3>

static analysis -this is analyzing code without tunning it.

now i am new to this but i prefer gidra over radare (this is a tough place and you need all the freinds you can get)
on ida i haven't bought it but from my experience with it installing plugins is not straight forward also ghidra has a dragon for a logo what else do you want!'
honorable mention objdump -this program is just meta it dumps object file 

dynamic analysis -this is running code while trybug to uderstand how it runs
radare,windbg and gdb


<h3>Assembly</h3>
i will go throuth this in detail in the next day
i have interacted with nasm which uses the intel syntax
assembly sintax
i know of two sytaxes as for now 
atnt and intel
intel is most preferred :just use this one even the machine you ae using is intel
atnt has a diffrent flow to intel but its a free world you can still use it ..:though choices have consequences like missing out on such a wonderfull blog
<h3>os</h3>
diffrent operating systems use difrent libraries and thus makes reverse enginerritng code difrent to some extent  
for windows incase you get a library you donot know use the microsoft developers page while for my linux people just use man comand to know about the file