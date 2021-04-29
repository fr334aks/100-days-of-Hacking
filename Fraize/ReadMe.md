# 100DaysOfHacking Web Security
- Below is a list of some of the things that I will be going through(not limited to it) my 100DaysOfHacking and my experience through the journey each day.
- I will be going through Web Security during the period.
- READ : [top 10 web hacking techniques](https://portswigger.net/research/top-10-web-hacking-techniques)

#### SERVER SIDE ATTACKS
* [x] SQL injection
  * [x] Types of SQLi
  * [x] SQLi Examples
  * [x] Examining the database
  * [x] Detecting SQL injection vulnerabilities
  * [x] SQL injection in different parts of the query
  * [x] Preventing SQLi  
* [x] Authentication
  * [x] Authentication Vulnerabilities
  * [x] Vulnerabilities in authentication mechanisms
  * [x] Vulnerabilities in password-based login
    * [x] Brute-force attacks 
  * [x] Vulnerabilities in multi-factor authentication
    * [x] Two-factor authentication tokens
    * [x] Bypassing two-factor authentication
    * [x] Flawed two-factor verification logic
    * [x] Brute-forcing 2FA verification codes
  * [x] Vulnerabilities in other authentication mechanisms.   
    * [x] Resetting Passwords
    * [x] Password reset poisoning
    * [x] Constructing a password reset poisoning attack
    * [x] Securing authentication mechanisms 
* [x] Directory Traversal
* [x] OS Command Injection
* [x] Business Logic Vulnerabilities
  * [x] Examples Of Business Logic Vulnerabilities
* [x] Information Disclosure
  * [x] Information Disclosure
  * [x] Exploiting Information Disclosure Vulnerabilities
* [x] Access Control
  * [x]  Access Control Vulnerabilities
  * [x]  IDOR
  * [x]  Access Control Security Models
* [x] Server-Side Request Forgery
* [x] XXE Injection
  * [x] Blind XXE 

#### Server-Side Labs
* [x] SQL injection 
* [ ] Authentication vulnerabilities
* [ ] Directory Traversal
* [ ] OS Command Injection
* [ ] Business Logic Vulnerabilities
* [ ] Information Disclosure
* [ ] Access Control
* [ ] Server-Side Request Forgery
* [ ] XXE Injection

----------------------------

#### CLIENT SIDE ATTACKS
* [x] Cross-Site Scripting (xss)
  * [x] Reflected XSS
  * [x] Stored XSS
  * [x] DOM-based XSS
  * [x] XSS concepts
* [x] Cross-Site Request Forgery (CSRF)
  * [x] Working of CSRF
  * [x] Constructing a CSRF attack
  * [x] Delivering a CSRF exploit
  * [x] Preventing CSRF attacks
  * [x] Common CSRF attacks
  * [x] Validation of CSRF
  * [x] Referer-based defenses against CSRF
* [ ] Cross-Origin Resource Sharing (CORS)
  * [x] Same-origin policy (SOP)
  * [ ] CORS and the Access-Control-Allow-Origin response header
* [ ] Clickjacking
* [ ] DOM-Based vulnerabilities
  * [ ] Controlling the web-message source
  * [ ] DOM-based open redirection
  * [ ] DOM-based cookie manipulation
  * [ ] DOM-based JavaScript injection
  * [ ] DOM-based document-domain manipulation
  * [ ] DOM-based WebSocket-URL poisoning
  * [ ] DOM-based link manipulation
  * [ ] Web-message manipulation
  * [ ] DOM-based Ajax request-header manipulation
  * [ ] DOM-based local file-path manipulation
  * [ ] DOM-based client-side SQL injection
  * [ ] DOM-based HTML5-storage manipulation
  * [ ] DOM-based client-side XPath injection
  * [ ] DOM-based client-side JSON injection
  * [ ] DOM-data manipulation
  * [ ] DOM-based denial of service
  * [ ] DOM clobbering
* [ ] Websockets
  * [ ] What are WebSockets?
  * [ ] Cross-site WebSocket hijacking

#### Client-Side Labs
* [ ] Cross-Site Scripting (xss)
* [ ] Cross-Site Request Forgery (CSRF)
* [ ] Cross-Origin Resource Sharing (CORS)
* [ ] Clickjacking
* [ ] DOM-Based vulnerabilities
* [ ] Websockets

-----------------------------

#### More Topics
* [ ] Insecure Deserialization
  * [ ] Exploiting insecure deserialization vulnerabilities
* [ ] Server-side template injection (SSTI)
* [ ] Web cache poisoning
* [ ] HTTP Host header aattacks
* [ ] HTTP request smuggling
* [ ] OAuth authentication
