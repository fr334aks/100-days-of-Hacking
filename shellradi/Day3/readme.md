##       Phase 1: Information gathering
 
I will be going through gathering all the information about the target network that is necessary for me to break in.
Like performing network mapping using Nmap and discover live hosts within a
given IP address range, discovering listening services that are running on network ports bound to those hosts. 
Then i’ll learn to interrogate these individual services for specific information, including but not limited to the following:

-  Software name and version number
-  Current patch and configuration settings
-  Service banners and HTTP headers
-  Authentication mechanisms


Alongside Nmap i will be using other powerful open source
pentest tools such as the Metasploit framework CrackMapExec (CME), Impacket, and
many others to further enumerate information about network targets, services, and
vulnerabilities that you can take advantage of to gain unauthorized access to restricted
areas of the target network.


##    Phase 2: Focused penetration

I will be compromising hosts and controlling  the network from the inside, since  i have identified 
vulnerable attack vectors throughout the environment.
I will learn several types of attack vectors that will
result in some form of remote code execution (RCE) on vulnerable targets. RCE means
you can connect to a remote command prompt and type commands to your  
compromised victim that will be executed and will send output back to you at your prompt.
I will learn how to deploy custom web shells using vulnerable web 
applications.
I will compromise and take control over database servers, web servers, file shares, work-
stations, and servers residing on Windows and Linux operating systems.


##   Phase 3: Post-exploitation and privilege escalation
  
 After i learn how to compromise several vulnerable hosts within my target environment, 
 it’s time to take things to the next level . I like to refer to
 these initial hosts that are accessible via a direct access vulnerability as level-1 hosts.
 This phase of the engagement is all about getting to level-2.
 Level-2 hosts are targets that were not initially accessible during the focused 
 penetration phase because you couldn’t identify any direct weaknesses within their 
 listening services. But after you gained access to level-1 targets, you found information or
 vectors previously unavailable to you, which allowed you to compromise a newly accessible
 level-2 system. This is referred to as pivoting.
 
I will learn post-exploitation techniques for both Windows- and
Linux-based operating systems. These techniques include harvesting clear text and
hashed account credentials to pivot to adjacent targets. I will practice elevating 
non-administrative users to admin-level privileges on compromised hosts. I’ll also learn
some useful tricks for searching passwords inside hidden files and folders, which are 
notorious for storing sensitive information. Additionally, i will learn several different
methods of obtaining a domain admin account (a superuser on a Windows Active Directory network).
By the time am done, i will understand exactly why we say in this industry that it takes 
only a single compromised host for one to spread through a network like wildfire and 
eventually capture the keys to the kingdom.
  
  
  
 ##      Phase 4: Documentation
  
Without the report, the penetration test means nothing. You broke into the network, 
found a bunch of holes in their security, and elevated your initial access as high 
as it could go.

How does that benefit the target organization? Truth be told, it doesn’t, unless you
can provide detailed documentation illustrating exactly how you were able to do it
and what the organization should do to ensure that you (or someone else) can’t do it
again


