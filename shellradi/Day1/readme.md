### 1. NETWORK PENETRATION TESTING


## Corporate data breaches
    

   There were 943 disclosed breaches in the first half of 2018
   alone, according to Breach Level Index, From a media-coverage perspective,
   most breaches tend to go something like this:
  

   Global Conglomerate XYZ has just disclosed that an unknown number of confidential
   customer records have been stolen by an unknown group of malicious hackers who
   managed to penetrate the company’s restricted network perimeter using an unknown
   vulnerability or attack vector and thus a letter of resigna-
   tion from the CEO as well as several advisory board members.
   The CEO assures us this has nothing to do with the breach;
   they’ve been planning to step down for months now.
   Of course, somebody has to take the official blame, which means the Chief Information
   Security Officer (CISO) who’s given many years to the company doesn’t get to resign;
   instead, they’re fired and publicly stoned to death on social media.


## How hackers break in

  
   The inconvenient truth of the matter is that the proverbial deck happens
   to be stacked disproportionally in favor of cyber-attackers due to
   the number of networked devices that enterprises have connected to their 
   infrastructure at all times.
   This significantly increases a company’s attack surface or
   threat landscape.

   Its not that always that companies are just that bad at doing the right things
   when it comes to information security and protecting our data.


  - The defender role

   If your job to defend an organization from cyber-
   threats. You need to identify every single laptop, desktop, smartphone, 
   physical server,virtual server, router, switch then make sure every application
   running on those devices is properly restricted using strong passwords  
   (preferably with two-factor authentication) and
   hardened to conform to the current standards and best practices for each respective
   device.
   

   Make sure you apply every security patch and hotfix issued
   by the individual software vendors as soon as they become available. Before you can
   do any of that, though, you have to triple-check that the patches don’t break any of
   your business’s day-to-day operations, or people will get mad at you for trying to pro-
   tect the company from hackers.

  - The attacker role


   His/Her job is to break into the company to
   compromise the network in some way and gain unauthorized access to restricted sys-
   tems or information. You need to find only a single system that has slipped through
   the cracks; just one device that missed a patch or contains a default or easily guessable
   password; a single nonstandard deployment that was spun up in a hurry to meet an
   impossible business deadline driven by profit targets, so an insecure configuration set-
   ting (which shipped that way by default from the vendor) was left on. That’s all it takes
   to get in, even if the target did an impeccable job of keeping track of every node on
   the network. New systems are stood up daily by teams who need to get something
   done fast.
   If you’re thinking to yourself that this isn’t fair, or that it’s too hard for defenders and
   too easy for attackers, then you get the point: that’s exactly how it is.  


##  Adversarial attack simulation: Penetration testing


  One of the most effective ways for a company to identify security weaknesses before they
  lead to a breach is to hire a professional adversary or penetration tester to simulate an
  attack on the company’s infrastructure. The adversary should take every available
  action at their disposal to mimic a real attacker, in some cases acting almost entirely in
  secret, undetected by the organization’s IT and internal security departments until it’s
  time to issue their final report. Throughout this writeup, I’ll refer to this type of offensive-
  security exercise simply as a penetration test.
      
  The specific scope and execution of a penetration test can vary quite a bit depend-
  ing on the motivations of the organization purchasing the assessment (the client) as
  well as the capabilities and service offerings of the consulting firm performing the
  test. Engagements can focus on web and mobile applications, network infrastructure,
  wireless implementations, physical offices, and anything else you can think of to
  attack. Emphasis can be placed on stealth while trying to remain undetected or on
  gathering vulnerability information about as many hosts as possible in a short time.
  Attackers can use human hacking (social engineering), custom-exploit code, or even
  dig through the client’s dumpster looking for passwords to gain access. It all depends
  on the internal network penetration test (INPT). This type of engagement simulates the most
  dangerous type of threat actor for any organization: a malicious or otherwise compro-
  mised insider.


 >  Threat actor
 
 
  is a fancy way of saying attacker. It refers to anyone
  attempting to harm an organization’s information technology assets.
  During an INPT, you assume that the attacker was able to successfully gain physical
  entry into a corporate office or perhaps was able to obtain remote access to an
  employee’s workstation through email phishing. It is also possible that the attacker vis-
  ited an office after hours, posing as a custodial worker, or during the day, posing as a
  vendor or flower delivery person. Maybe the attacker is an actual employee and used a
  badge to walk in the front door.
  There are countless ways to gain physical entry to a business, which can be easily
  demonstrated. For many businesses, an attacker simply needs to walk through the main
  entrance and wander around while smiling politely at anyone who passes, appearing to
  have a purpose or talking on a cell phone until they identify an unused area where they
  can plug into a data port. Professional companies offering high-caliber penetration
  testing (pentest) services typically bill anywhere from $150 to $500 per hour. As a result,
  it’s often cheaper for the client purchasing the penetration test to skip this part and
  place the attacker on the internal subnet from the beginning.
  Either way, the attacker has managed to get access to the internal network. Now,
  what can they do? What can they see? A typical engagement assumes that the attacker
  knows nothing about the internal network and has no special access or credentials. All
  they have is access to the network—and coincidentally, that’s usually all they need.


 -  Typical INPT workflow

  A typical INPT consists of four phases executed in order,


   1. Phase 1—Information gathering
      Map out the network.
      Identify possible targets.
      Enumerate weaknesses in the services running on those targets.


   2. Phase 2—Focused penetration
            Compromise vulnerable services (gain unauthorized access to them).
            
   3. Phase 3—Post-exploitation; privilege escalation
                   Identify information on compromised systems that can be used to further
                   access (pivoting).
                   Elevate privileges to the highest level of access on the network, effectively
                   becoming the company’s system administrator.
    4.  phase 4—Documentation
               Gather evidence.
               Create the final deliverable.
 
   Once the testing portion of the engagement has concluded, the penetration tester
   now makes a mental shift from that of an adversary and transitions into a consultant.
   They spend the rest of the engagement creating as detailed a report as possible. That
   report contains the specific explanation of all the ways they were able to breach the
   network and bypass security controls as well as the detailed steps the company can
   take to close these identified gaps and ensure that they can no longer be exploited by
   anyone. In 9 out of 10 cases, this process takes about 40 hours on average, but the
   time required can vary depending on the size of the organization.


