##  When a penetration test is least effective

  Does every organization truly need a penetration test?
  The answer is that it depends on the level of maturity within a company’s informa
  tion security program.
  
  It has a lot more to do with an exceedingly common scenario: an immature organi-
  zation that isn’t even doing the basics is sold an advanced-level penetration test when
  it should be starting with a simple vulnerability assessment or a high-level threat
  model and analysis gig. There is no point in conducting a thorough penetration test
  of all your defense capabilities if there are gaping holes in your infrastructure security
  that even a novice can spot.
  
  -  Low-hanging fruit
  
  Attackers often seek out the path of least resistance and try to find easy ways into an
  environment before breaking out the big guns and reverse-engineering proprietary
  software or developing custom zero-day exploit code. Truth be told, your average pen-
  etration tester doesn’t know how to do something that complex, because it’s never
  been a skill they’ve needed to learn. No need to go that route when easy ways in are
  widespread throughout most corporations. We call these easy ways in low-hanging fruit
 (LHF). Some examples include the following:
 
     1. Default passwords/configurations
     2. Shared credentials across multiple systems
     3. All users having local administrator rights
     4. Missing patches with publicly available exploits
     
  There are many more, but these four are extremely common and extremely danger-
  ous. On a positive note, though, most LHF attack vectors are the easiest to remediate.
  Make sure you’re doing a good job with basic security concepts before hiring a profes-
  sional hacker to attack your network infrastructure.
  Organizations with significant numbers of LHF systems on their network shouldn’t
  bother paying for a “go-all-out” penetration test. It would be a better use of their time
  and money to focus on basic security concepts like strong credentials everywhere, reg-
  ular software patching, system hardening and deployment, and asset cataloging.
  
   - When does a company really need a penetration test?
   
   Start with simple yes/no answers. Then, for every yes
   answer, the company should see if it can back up that answer with, “Yes, because of
   internal process/procedure/application XYZ, which is maintained by employee
    ABC”:


       1.  Is there an up-to-date record of every IP address and DNS name on the network?
       2.  Is there a routine patching program for all operating systems and third-party
           applications running on the network?
       3.  Do we use a commercial vulnerability scan engine/vendor to perform routine
           scans of the network?
       4.  Have we removed local administrator privileges on employee laptops?
       5.  Do we require and enforce strong passwords on all accounts on all systems?  
       6. Are we utilizing multi-factor authentication everywhere?
  
  If your company can’t answer a solid yes to all of these questions, then a decent pene-
  tration tester would probably have little to no trouble breaking in and finding your
  organization’s crown jewels. I’m not saying you absolutely shouldn’t buy a penetration
  test, just that you should expect painful results.
  It may be fun for the penetration tester; they may even brag to their friends or col-
  leagues about how easily they penetrated your network. But I am of the opinion that
  this provides very little value to your organization.
  
  ### Executing a network penetration test
  
  Red team—A specialized subset of an organization’s internal secu-
  rity department, focused entirely on offensive security and adversarial attack-
  simulation exercises. Additionally, the term red team is often used to describe a
  specific type of engagement that is considered as realistic as possible, simulat-
  ing advanced attackers and using a goal-oriented, opportunistic approach
  rather than a scope-driven methodology.
  
  I will work through the four phases of my INPT(Internal Network Penetration Tesing) methodology 
  using the virtual ''Capsulecorp Pentest network that I have set up. 
  Each of the four phases is broken into several chapters
  demonstrating different tools, techniques, and attack vectors that penetration testers
  use frequently during real engagements.
  
  
  
  
