### **Network Penetration Testing**

_materials_

> 
The Art of Network Penetration Testing: How to take over any company in the world
by @RoyceDavis (Author)
### 1 Network penetration testing 

- [ ] Corporate data breaches
- [ ] How hackers break in

-  _The defender role_ 
-  _The attacker role_

- [ ] Adversarial attack simulation: Penetration testing
- [ ] When a penetration test is least effective
- [ ] Executing a network penetration test
- [ ] Building your own virtual pentest platform

### 2 Discovering network hosts

**- Phase 1:**

Information gathering
```
Discover
weaknesses
```

- [ ] Understanding your engagement scope
- [ ] Internet Control Message Protocol
- [ ] Discovering hosts with Nmap
- [ ] Additional host-discovery methods

### 3 Discovering network services



- [ ] Network services from an attacker’s perspective
- [ ] Port scanning with Nmap
- [ ] Parsing XML output with Ruby

### 4 Discovering network vulnerabilities


- [ ] Understanding vulnerability discovery
- [ ] Discovering patching vulnerabilities
- [ ] Discovering authentication vulnerabilities
- [ ] Discovering configuration vulnerabilities

**- Phase 2:**

Focused penetration`


```
Access
vulnerable
hosts
```

### 5 Attacking vulnerable web services

- [ ] Understanding phase 2: Focused penetration
- [ ] Gaining an initial foothold
- [ ] Compromising a vulnerable Tomcat server
- [ ] Interactive vs. non-interactive shells
- [ ] Upgrading to an interactive shell
- [ ] Compromising a vulnerable Jenkins server

### 6 Attacking vulnerable database services

- [ ] Compromising Microsoft SQL Server
- [ ] Stealing Windows account password hashes
- [ ] Extracting password hashes with creddump

### 7 Attacking unpatched services

- [ ] Understanding software exploits
- [ ] Understanding the typical exploit life cycle
- [ ] Compromising MS17-010 with Metasploit
- [ ] The Meterpreter shell payload
- [ ] Cautions about the public exploit database



**- Phase 3:**


Post exploitation and Privilege escalation
```

Take over
entire network
```
### 8 Windows post-exploitation

- [ ] Fundamental post-exploitation objectives
- [ ] Maintaining reliable re-entry with Meterpreter
- [ ] Harvesting credentials with Mimikatz
- [ ] Harvesting domain cached credentials
- [ ] Harvesting credentials from the filesystem
- [ ] Moving laterally with Pass-the-Hash


### 9 Linux or UNIX post-exploitation

- [ ] Maintaining reliable re-entry with cron jobs
- [ ] Harvesting credentials
- [ ] Escalating privileges with SUID binaries
- [ ] Passing around SSH keys


### 10 Controlling the entire network

- [ ] Identifying domain admin user accounts
- [ ] Obtaining domain admin privileges
- [ ] ntds.dit and the keys to the kingdom



**- Phase 4:**

Documentation

`provide recommendations`

### 11 post-engagement cleanup

- [ ] Killing active shell connections
- [ ] Deactivating local user accounts
- [ ] Removing leftover files from the filesystem
- [ ] Reversing configuration changes
- [ ] Closing backdoors

### 12 Writing a solid pentest deliverable

- [ ] Eight components of a solid pentest deliverable
- [ ] Executive summary
- [ ] Engagement methodology
- [ ] Attack narrative
- [ ] Technical observations
- [ ] Appendices
- [ ] Appendices
