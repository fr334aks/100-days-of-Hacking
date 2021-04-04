# Recurrent Web Hacking Resources per category

### SERVER SIDE ATTACKS

### SQL injection

- [SQL Injection(redtiger.lab)Part 1](https://link.medium.com/hLNBnJzNX9)

  - [SQL Injection(redtiger.lab)-Part2](https://link.medium.com/tU7YK9JsZ9)

  - [BLIND SQL Injection (redtiger.lab)-Part 3](https://link.medium.com/tEHSs9T909)


- [Portswigger,SQLi](https://portswigger.net/web-security/sql-injection)

- [Rayhan,Automating Blind SQLi over Websockets](https://rayhan0x01.github.io/ctf/2021/04/02/blind-sqli-over-websocket-automation.html)


#### Videos

- [Rana Khalil,SQL Injection.Complete Lab](https://www.youtube.com/watch?v=1nJgupaUPEQ&t=8s)
 
<details>
  <summary>Labs and exercises</summary>
  
#### Labs and exercises 

- [From SQL Injection to Shell](https://pentesterlab.com/exercises/from_sqli_to_shell/course)

- [SQli labs](https://www.vulnspy.com/sqli-labs/)

- [SQL injection UNION attack, determining the number of columns returned by the query](https://portswigger.net/web-security/sql-injection/union-attacks/lab-determine-number-of-columns)

- [SQL injection UNION attack, finding a column containing text](https://portswigger.net/web-security/sql-injection/union-attacks/lab-find-column-containing-text)

- [SQL injection UNION attack, retrieving data from other tables](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-data-from-other-tables)

- [SQL injection UNION attack, retrieving multiple values in a single column](https://portswigger.net/web-security/sql-injection/union-attacks/lab-retrieve-multiple-values-in-single-column)

- [SQL injection attack, querying the database type and version on Oracle](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-oracle)

- [SQL injection attack, querying the database type and version on MySQL and Microsoft](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-querying-database-version-mysql-microsoft)

- [SQL injection attack, listing the database contents on non-Oracle databases](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-non-oracle)

- [SQL injection attack, listing the database contents on Oracle](https://portswigger.net/web-security/sql-injection/examining-the-database/lab-listing-database-contents-oracle)

- [Blind SQL injection with conditional responses](https://portswigger.net/web-security/sql-injection/blind/lab-conditional-responses)

- [Blind SQL injection with conditional errors](https://portswigger.net/web-security/sql-injection/blind/lab-conditional-errors)

- [Blind SQL injection with time delays](https://portswigger.net/web-security/sql-injection/blind/lab-time-delays)

- [Blind SQL injection with time delays and information retrieval](https://portswigger.net/web-security/sql-injection/blind/lab-time-delays-info-retrieval)

- [Blind SQL injection with out-of-band interaction](https://portswigger.net/web-security/sql-injection/blind/lab-out-of-band)

- [Blind SQL injection with out-of-band data exfiltration](https://portswigger.net/web-security/sql-injection/blind/lab-out-of-band-data-exfiltration)

- [SQL injection vulnerability in WHERE clause allowing retrieval of hidden data](https://portswigger.net/web-security/sql-injection/lab-retrieve-hidden-data)

- [SQL injection vulnerability allowing login bypass](https://portswigger.net/web-security/sql-injection/lab-login-bypass)

</details>

### Authentication


- [Broken Authentication](https://d00mfist.gitbooks.io/ctf/content/broken_authentication_or_session_management.html)

- [portswigger authentication](https://portswigger.net/web-security/authentication)


<details>
  <summary>Labs and Exercises</summary>
  
### Labs and Exercises

- [Username enumeration via different responses](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-different-responses)

- [Username enumeration via subtly different responses](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-subtly-different-responses)

- [Username enumeration via response timing](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-response-timing)

- [Broken brute-force protection, IP block](https://portswigger.net/web-security/authentication/password-based/lab-broken-bruteforce-protection-ip-block)

- [Username enumeration via account lock](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-account-lock)

- [Broken brute-force protection, multiple credentials per request](https://portswigger.net/web-security/authentication/password-based/lab-broken-brute-force-protection-multiple-credentials-per-request)

- [2FA simple bypass](https://portswigger.net/web-security/authentication/multi-factor/lab-2fa-simple-bypass)

- [2FA broken logic](https://portswigger.net/web-security/authentication/multi-factor/lab-2fa-broken-logic)

- [2FA bypass using a brute-force attack](https://portswigger.net/web-security/authentication/multi-factor/lab-2fa-bypass-using-a-brute-force-attack)

- [Brute-forcing a stay-logged-in cookie](https://portswigger.net/web-security/authentication/other-mechanisms/lab-brute-forcing-a-stay-logged-in-cookie)

- [Offline password cracking](https://portswigger.net/web-security/authentication/other-mechanisms/lab-offline-password-cracking)

- [Password reset broken logic](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-broken-logic)

- [Password reset poisoning via middleware](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-poisoning-via-middleware)

- [Password brute-force via password change](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-brute-force-via-password-change)

</details>
 
### Directory Traversal

- [Portswigger Directory Traversal](https://portswigger.net/web-security/file-path-traversal)

- [PHP fopen() function to LFI](https://xhzeem.me/posts/PHP-fopen-function-to-local-file-inclusion/read/)


<details>
  <summary>Labs and Exercises</summary>
  
#### Labs and Exercises 

- [File path traversal, simple case](https://portswigger.net/web-security/file-path-traversal/lab-simple)

- [File path traversal, traversal sequences blocked with absolute path bypass](https://portswigger.net/web-security/file-path-traversal/lab-absolute-path-bypass)

- [File path traversal, traversal sequences stripped non-recursively](https://portswigger.net/web-security/file-path-traversal/lab-sequences-stripped-non-recursively)

- [File path traversal, traversal sequences stripped with superfluous URL-decode](https://portswigger.net/web-security/file-path-traversal/lab-superfluous-url-decode)

- [File path traversal, validation of start of path](https://portswigger.net/web-security/file-path-traversal/lab-validate-start-of-path)

- [File path traversal, validation of file extension with null byte bypass](https://portswigger.net/web-security/file-path-traversal/lab-validate-file-extension-null-byte-bypass)

</details>


### Command Injection

-
   
### Business Logic Vulnerabilities
   
-   
   
### Information Disclosure
 
-
 
### Access Control
    

### Server-Side Request Forgery
    
### XXE Injection

- [Owasp,XXE Exploitation](https://owasp.org/www-pdf-archive//XXE_Exploitation.pdf)

- [OwaspOrlando,XXE: The Anatomy of an XML Attack](https://owasp.org/www-pdf-archive//XXE_-_The_Anatomy_of_an_XML_Attack_-_Mike_Felch.pdf)

CLIENT SIDE ATTACKS

    Cross-Site Scripting (xss)
    Cross-Site Request Forgery (CSRF)
    Cross-Origin Resource Sharing (CORS)
    Clickjacking
    DOM-Based vulnerabilities
    Websockets

More Topics

## Insecure Deserialization

- [escalating deserialization attacks python](https://frichetten.com/blog/escalating-deserialization-attacks-python/)
  
  - [Research on deserialization attacks in Python and PHP](https://github.com/Frichetten/deserialization_stuff)
   
   Server-side template injection (SSTI)
    Web cache poisoning
    HTTP Host header aattacks
    HTTP request smuggling
    OAuth authentication

