# DAY 1

## Introduction

### Web application security
Web application security is a branch of Information Security that arrangements particularly with the security of sites, web applications, and web administrations. At an abnormal state, Web application security draws on the standards of application security, however, applies them particularly to Internet and Web frameworks

## Top 10 vulnerabilities
  - Injection

  - Broken Authentication and Session Management

  - Sensitive Data Exposure
  
  - XML External Entity

  - Broken Access Control

  - Security Misconfiguration

  - Cross-Site Scripting

  - Insecure deserialization

  - Using Components With Known Vulnerabilities

  - Insufficient Logging and Monitoring
    
  - Injection

#### Injection

Injection is a category that includes all kinds of vulnerabilities where an application sends queries to the application which lead to some untrusted access or something else. It is often found in database queries, but other examples are OS commands, XML parsers or when user input is sent as program arguments.

#### Broken Authetiacation and Session Managment

Broken Authentication involves all kinds of flaws that are caused by an error in implementations of authentication and/or session management. This category includes some time-based login errors , or if any user forgets to log out from his account when he was logged in any public places such that his account could be hijacked. And sometime this could be also due to some session

#### Sensitive Data Exposure

This occurs when the application is not given the adequate protection to the sensitive data. The data can be anything from passwords, session tokens, credit card data to private health data and more can be exposed.

#### XML External Entity

XXE allows attackers to abuse external entities when an XML document is parsed. If this happens, the attacker can read local files on the server, force the parser to make network requests within the local network, or use recursive linking to perform a DoS attack.

#### Broken Access Control

Broken Access Control is vulnerability category that covers all access control issues that can make your website vulnerable and can often be found in web applications that have gradually grown in size without any of proper limitation and some access security. The category is the result of merging Insecure Direct Object References and Missing Function level.

#### Security Misconfiguration

Security misconfiguration is a very common vulnerability category that occurs when a component is susceptible to attack due to an insecure configuration. At worst, exploiting a security misconfiguration can lead to a full takeover.

#### Cross-Site Scripting

Cross-site Scripting is a type of attack that can be carried out to compromise users of a website. The exploitation of an XSS flaw enables the attacker to inject client-side scripts into web pages viewed by users. This script many a time found in JavaScript some times also found in other languages too.

#### Insecure Deserialization

Insecure Deserialization allows attackers to transfer a payload using serialized objects. This happens when integrity ch ecks are not in place and deserialized data is not sanitized or validated.

#### Using Components With Know Vulnerability

It is very common for web services to include a component with a known security vulnerability. The component with a known vulnerability could be the operating system itself, or some internal issues with the system or even a library used by one of these plugins, making this a very frequent finding.

#### Insufficient Logging and Monitoring

Insufficient Logging and Monitoring covers the lack of best practices that should be in place to prevent or damage control security breaches. The category includes everything from unlogged events, logs that are not stored properly and warnings where no action is taken within a reasonable time.

Languages involved 



```
Client Side :
    - HTML
    - Javascript
    - CSS
    - Jquery

Server Side languages :
 - PHP
 - JavaScript
 - Ruby
 - Python
 - Java
```

> reference [Bi0s-Wiki](https://wiki.bi0s.in/web/intro/)
