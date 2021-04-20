# CROSS-SITE SCRIPTING (XSS)

> Is a web security vulnerability that allows an attacker to compromise the interactions that users have with a vulnerable application.
- It allows an attacker to circumvent the same origin policy, which is designed to segregate different websites from each other.
- XSS vulnerabilities normally allow an attacker to masquerade as a victim user, to carry out any actions that the user is able to perform, and to access any of the user's data.
- If the victim user has privileged access within the application, then the attacker might be able to gain full control over all the application's functionality and data.
- XSS works by manipulating a vulnerable website so that it returns malicious JavaScript to users. When the malicious code executes inside a victim's browser, the attacker can fully compromise their interaction with the application.

## Types of XSS attacks
- There are 3 main types, ie:
1. Reflected XSS - Where the malicious script comes from the current HTTP request.
2. Stored XSS - Where the malicious script comes from the website's database.
3. DOM-based XSS - Where the vulnerability exists in client-side code rather that server-side code.

------------------------------------------------------------------------------------------
### 1.`Reflected XSS`
- Arises when an application receives data in an HTTP request and includes that data within the immediate response in an unsafe way.
- An example of reflected XSS vulnerability:
```
https://website.com/status?message=All+is+well
<p>Status: All is well.</p>
```
- The application doesn't perform any other processing of the data, so an attacker can easily construct an attack like this:
```
https://website.com/status?message=<script>/*+Bad+stuff+here...+*/</script>
<p>Status: <script>/* Bad stuff here... */</script></p>
```
- If the user visits the URL constructed by the attacker, then the attacker's script executes in the user's browser, in the context of that user's session with the application. At that point, the script can carry out any action, and retrieve any data to which the user has access

### Impact of Reflected XSS attacks
- If an attacker can control a script that is executed in the victim's browser, then they can typically compromise that user. An attacker can also:
  1. Perform any action within the application that the user can perform
  2. View any information that the user is able to view.
  3. Modify any information that the user is able to modify.
  4. Initiate interactions with other application users, including malicious attacks, that will appear to originate from the initial victim user.
- The need for an external delivery mechanism for the attack means that the impact of reflected XSS is generally less severe than `stored XXS`, where a self contained attack can be delivered within the vulnerable application itself.
- There are various means an attacker may induce a victim user to make a request that they control to deliver a reflected XSS attack. These include:
  1. Placing links on a website controlled by the attacker.
  2. Placing links on another website that allows content to be generated.
  3. Sending a link in an email, tweet or message.
  
### Reflected XSS in different contexts.
- The location of the reflected data within the application's response determines what type of payload is required to exploit it and might also affect the impact of the vulnerability.
- If the application performs any validation or other processing on the submitted data before it is reflected, this will generally affect what kind of XSS payload is needed.

### How to find and test for reflected XSS Vulnerabilities
- Testing for reflected XSS vulnerabilities manually involves the following steps:
  1. Test every point.
  2. Submit random alphanumeric values.
  3. Determine the reflection context.
  4. Test a candidate payload.
  5. Test alternative payloads.
  6. Test the attack in a browser.
--------------------------------------------------------------------------------
### 2. `Stored XSS`
- Also known as `second-order` or `persistent XSS`.
- Arises when an application receives data from an untrusted source and includes that data within its later HTTP responses in an unsafe way.
- Suppose a website allows users to submit comments on blog posts, which are displayed to other users.
- Users submit comments using an HTTP request like the following:
```
POST /post/comment HTTP/1.1
Host: vulnerable-website.com
Content-Length:100

postId=3&comment=This+post+was+extremely+helpful.&name=Carlos+Montoya&email=carlos%40normal-user.net
```
After this comment has been submitted, any user who visits the blog post will receive the following within the application's response:
```
<p>This post was extremely helpful.</p>
```
Assuming the application doesn't perform any other processing of the data, an attacker can submit a malicious comment like this:
```
<script>/*Bad content...*/</script>
```
Within the attacker's request, this comment would be URL-encoded as:
```
comment=%3Cscript%3E%2F*%2BBad%2Bcontent...%2B*%2F%3C%2Fscript%3E
```
Any user who visits the blog will now receive the following within the application's response:
```
<p><script>/* Bad content... */</script></p> 
```
The script supplied by the attacker will then execute in the victim user's browser, in the context of their session with the application.

### Impact of stored XSS
- If an attacker can control a script that is executed in the victim's browser, then they can typically fully compromise that user.
- The attacker can carry out any of the actions that are applicable to the impact of reflected XSS vulnerabilities.
- Stored XSS vulnerability enables attacks that are self-contained within the application.
- The attacker places their exploit into the application itself and simply waits for users to encounter it.
- The self-contained nature of stored cross-site scripting exploits is particularly relevant in situations where an XSS vulnerability only affects users who are currently logged in to the application.
- If the XSS is reflected, then the attack must be timed, a user who is induced to make the attacker's request at a time when they are not logged in will not be compromised whereas if the XSS is stored, then the user is guaranteed to be logged in at the time they encounter the exploit.

### Stored XSS in different contexts
- The location of the stored data within the application's response determines what type of payload is required to exploit it and might also affect the impact of the vulnerability.
- If the application performs any validation or other processing on the data before it is stored or at the point when the stored data is incorporated into responses, this will affect what kind of XSS payload is needed.

### How to find and test for stored XSS vulnerabilities
- Testing for stored XSS vulnerabilities manually can be challenging since one needs to test all relevant `entry points` via which attacker-controllable data can enter the application's processing and all `exit points` at which that data might appear in the application's responses.
- `Entry points` into the application's processing include:
  1. Parameters or other data within the URL query string and message body.
  2. The URL file path.
  3. HTTP request headers that might not be exploitable in relation to reflected XSS.
  4. Any out-of-band routes via which an attacker can deliver data into the application.
    The routes that exist depend entirely on the functionality implemented by the application; a webmail application will process data received in emails; an application displaying a twitter feed might process data contained in third-party tweets; and a news aggregator will include data originating on other websites.
- Entry points for stored XSS attacks are all possible HTTP responses that are returned to any kind of application user in any situation.
- First step in testing for stored XSS vulnerabilities is to locate the links between entry and exit points, whereby data submitted to an entry point is emitted from an exit point. The reasons why this can be challenging are that: 
  1. Data submitted to any entry point could in principle be emitted form any exit point.
  2. Data that is currently stored by the application is often vulnerable to being overwritten due to other actions performed within the application.
- When you have identified links between entry and exit points in the application's processing, each link needs to be specifically tested to detect if a stored XSS vulnerability is present. 
- It involves determining the context within the repsonse where the stored data appears and testing suitable candidate XSS payloads that are applicable to that context.


--------------------------------------------------------------------------------

## MATERIALS
### REFERENCE
* [PortSwigger - Cross-Site Scripting](https://portswigger.net/web-security/cross-site-scripting)
* [PortSwigger - Reflected XSS](https://portswigger.net/web-security/cross-site-scripting/reflected)
* [XSS Cheat sheet](https://portswigger.net/web-security/cross-site-scripting/cheat-sheet)


### LABS
* [Reflected XSS into HTML context with nothing encoded](https://portswigger.net/web-security/cross-site-scripting/reflected/lab-html-context-nothing-encoded)
* [Stored XSS into HTML context with nothing encoded](https://portswigger.net/web-security/cross-site-scripting/stored/lab-html-context-nothing-encoded)
