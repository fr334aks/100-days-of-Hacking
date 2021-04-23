# Cross-site Scripting
## DOM-Based XSS
> `Dom-based XSS` vulnerabilities usually arise when JavaScript takes data from an attacker-controllable source, such as the URL and passes it to a sink that supports dynamic code execution such as `eval()` or `innerHTML`.
- This enables attackers to execute malicious JavaScript which typically allows them to hijack other users' accounts.
- Place data into a source so that it is propagated to a sink and cause execution of arbitrary JavaScript in order to deliver a DOM-based XSS attack.
- Most common source for DOM XSS is the URL which it accessed with the `window.location` object.
- An attacker can construct a link to send a victim to a vulnerable page with a payload in the query string and fragment portions of the URL and in certain circumstances such when a targeting a 404 page or a website running PHP, the payload can also be placed in the path.

## How to test for DOM-based cross-site scripting
- To test for DOM-Based XSS manually, use browser developer tools. Work through each available source in turn, and test each one individually.
### `Testing HTML sinks`
- Place a random alphanumeric string into the source (such as `location.search`) then use developer tools to inspect the HTML and find where your string appears.
- Browser's `view source` option won't work for DOM XSS testing because it doesn't take account of changes that have been performed in the HTML by Javascript.
- For each location where your string appears within the DOM, identify the context based on which you need to refine your input to see how it is processed.
- Example, if your string appears within a double-quoted attribute then try to inject double quotes in your string to see if you can break out of the attribute.
- If your data gets URL-encoded before being processed, then an XSS attack is unlikely to work.

### `Testing JavaScript execution sinks.`
- With these sinks, your input doesn't appear necessarily within the DOM, so you can't search for it, instead you'll need to use the JavaScript debugger to determine whether and how your input is sent to a sink.
- For each potential source, such as `location`, you need to first find cases within the page's JavaScript code where the source is being referenced.
- Once you've found where the source is being read, you can use the JavaScript debugger to add a break point and follow how the source's value is used.
- You might find that the source gets assigned to other variables and might need to use the search function again to track these variables and see if they're passed to a sink.
- When you find a sink that's being assigned data that originated from the source, you can use the debugger to inspect the value by hovering over the variable to show its value before it is sent to the sink, then as with HTML sinks, refine your input to see if you can deliver a successful XSS attack.

### `Exploiting DOM XSS with different sources and sinks`
- A website is vulnerable to DOM-based across XSS if there is an executable path via which data can propagate from source to sink.
- In practice, different sources and sinks have differing properties and behavior that can affect exploitability and determine what techniques are necessary.
- The website's scripts might perform validation or other processing of data that must be accomodated when attempting to exploit a vulnerability.
- There are a variety of sinks that are relevant to DOM-based vulnerabilities as below:
  1. The `document.write` sink works with `script` elements, so you can use simple payloads as below:
```
document.write('... <script>alert(document.domain)</script> ...');
```
  - However, in some situations the content that is written to `document.write` includes some surrounding context that you need to take account of in your payload. eg closing some existing elements before using your JS payload.
  2. The `innerHTML` sink doesn't accept `script` elements on any modern browser, nor will `svg onload` events fire meaning you will need to use alternative elements like `img` or `iframe`.
  - Event handlers such as `onload` and `onerror` can be used in conjunction with these elements. Eg:
```
element.innerHTML='... <img src=1 onerror=alert(document.domain)> ...'
```
- If a JS library such as `JQuery` is being used, look out for sinks that can alter DOM elements on the page such as `attr()` function that can change attributes in DOM elements.
- If data is read from a user-controlled source like the URL and then passed to the `attr()` function, then it may be possible to manipulate the value sent to cause XSS.
- Eg some JS that changes an anchor element's `href` attribute using data from the URL:
```
$(function(){
$('#backLink').attr("href",(new URLSearchParams(window.location.search)).get('returnUrl'));
});
```
- You can exploit this by modifying the URL so that the `location.search` source contains a malicious JS URL. After the page's JS applies this malicious URL to the backlink's `href`, clicking on the back link will execute it:
```
?returnUrl=javascript:alert(document.domain)
```
- If a framework like `AngularJS` is used, it may be possible to execute JS without angle brackets or events.
- When a site uses the `ng-app` attribute on an HTML element, it will be processed by AngularJS by executing JS inside double curly braces that can occur directly in HTML or inside attributes.

### `DOM XSS combined with reflected and stored data`
- If a script reads some data from the URL and writes it to a dangerous sink, then the vulnerability is entirely client-side.
- Sources aren't limited to data that is directly exposed by browsers, they can also originate from the website. Eg websites often reflect URL parameters in the HTML response from the server. This can be associated with normal XSS but can also lead to so-called `reflected+DOM` vulnerabilities.
- In such a vulnerability, the server processes data from the request and echoes the data into the response.
- The reflected data might be placed into a JS string literal or data item within the DOM such as a form field.
- A script on the page then processes the reflected data in an unsafe way, ultimately writing it to a dangerous sink.
```
eval('var data = "reflected string"');
```
- Websites may also store data on the server and reflect it elsewhere.
- In a stored+DOM vulnerability, the server receives data from one request, stores it, and then includes the data in a later response.
- A script within the later response contains a sink which then processes the data in an unsafe way.
```
element.innerHTML = comment.author
```

### Sinks that can lead to DOM-XSS vulnerabilities
- The following are some of the main sinks that can lead to DOM-XSS vulnerabilities:
```
document.write()
document.writeln()
document.domain
someDOMElement.innerHTML
someDOMElement.outerHTML
someDOMElement.insertAdjacentHTML
someDOMElement.onevent
```
- The following jQuery functions are sinks that can lead to DOM-XSS vulnerabilities:
```
add()
after()
append()
animate()
insertAfter()
insertBefore()
before()
html()
prepend()
replaceAll()
replaceWith()
wrap()
wrapInner()
wrapAll()
has()
constructor()
init()
index()
jQuery.parseHTML()
$.parseHTML()
```
--------------------------------------------------------------------------------
## What XSS can be used for
- An attacker is able to:
1. Impersonate or masquerade as the victim user.
2. Carry out any action that the user is able to perform.
3. Read any data that the user is able to acceess.
4. Capture the user's login credentials.
5. Perform virtual defacement of the website.
6. Inject trojan functionality into the web site.
--------------------------------------------------------------------------------
## Exploiting XSS vulnerabilities
- Traditional way to prove that you've found an XSS vulnerability is to create a popup using the `alert()` function. It's a simple way to prove that you can execute arbitrary JS on a given domain.
### Exploiting XSS to steal cookies
- Most web apps use cookies for session handling and can be exploited to send the victim's cookies to your own domain then manually inject the cookies into your own browser and impersonate the victim.
- This approach has the following limitations:
  1. The victim might not be logged in.
  2. Many applications hide their cookies from JS using the `HttpOnly` flag.
  3. Sessions might be locked to additional factors like the user's IP address.
  4. The session might time out before you're able to hijack it.
### Exploiting XSS to capture passwords
- Many users have password managers that auto-fill their passwords. An attacker can take advantage of this by creating a password input, reading out the auto-filled password and sending it to your own domain.
- This technique avoids most of the problems associated with stealing cookies and can even gain access to every other account where the victim has reused the same password.
- Disadvantage of this technique is that it only works on users who have a password manager that uses auto-fill.
- If a user doesn't have a password saved you can still obtain their password through `phishing`.
### Exploiting XSS to perform CSRF
- Depending on the site being targeted, you might be able to make a victim send a message, accept a friend request, commit a backdoor to a source code repository or transfer some bitcoin.
- Some websites allow logged-in users to change their email address without re-entering their password. If such an XSS vulnerability is identified then you can trigger changing email address to one you control and even reset password to gain access.
- When CSRF occurs as a standalone vulnerability, it can be `patched` using strategies like anti-CSRF tokens that however do not provide any protection if an XSS vulnerability is also present.
--------------------------------------------------------------------------------
## Content Security Policy(CSP)
> CSP is a browser mechanism that aims to mitigate the impact of XSS and some other vulnerabilities.
- It works by restricting the resources(eg scripts and images) that a page can load and restricting whether a page can be framed by other pages.
- To enable CSP, a response needs to include an HTTP response header called `Content-Security-Policy` with a value containing the policy which consists of one or more directives separated by a semicolon.
### `Mitigating XSS attacks using CSP`
- The following directive will only allow scripts to be loaded from the same origin as the page itself:
```
script-src 'self'
```
- The following directive will only allow scripts to be loaded from a specific domain.
```
script-src https://scripts.website.com
```
- If there is a way for an attacker to control content that is served from the external domain, then they might be able to deliver an attack.
- Eg Content Delivery Networks(CDNs) that don't use per-customer URLs such as `ajax.googleapis.com` should not be trusted because third parties can get content onto their domains.
- CSP also provides two other ways of specifying trusted resources: `nonces` and `hashes`
  1. The CSP directive can specify a `nonce` (a random value) and the same value must be used in the tag that load a script. If the values do not match, then the script will not execute. To be effective as a control, the nonce must be securely generated on each page load and not be guessable by an attacker.
  2. The CSP directive can specify a `hash` of the contents of the trusted script. If the hash of the actual script doesn't match the value specified in the directive, then the script will not execute. If the content of the script ever changes, then you will need to update the hash value that is specified in the directive.
  
- CSP can block resources like `script`, however, many CSPs do allow image requests meaning you can often use `img` elements to make requests to external servers in order to disclose CSRF tokens.
- Some browsers like `Chrome` have built-in dangling markup mitigation that will block requests containing certain characters such as raw, unencoded new lines or angle brackets.
- Some policies are more restrictive and prevent all forms of external requests. To bypass this form of policy, one needs to inject an HTML element that, when clicked, will store and send everything enclosed by the injected element to an external server.

### `Mitigating dangling markup using CSP`
- The following directive will only allow images to be loaded from the same origin as the page itself:
```
img-src 'self'
```
- The following directive will only allow images to be loaded from a specific domain:
```
img-src https://images.website.com
```
- These policies will prevent some dangling markup exploits, because an easy way to capture data with no user interaction is using an `img` tag, however, it will not prevent other exploits, such as those that inject an anchor tag with a dangling `href` attribute.

### `Bypassing CSP with policy injection`
- If the site reflects a parameter that you can control, you can inject a semicolon to add your own CSP directives most likely in a `report-uri` directive.
- This means you will need to overwrite existing directives in order to exploit this vulnerability and bypass this policy.
- Chrome introduced recently the `script-src-elem` directive, which allows you to control `script` elements but not events. This new directive allows you to overwrite existing `script-src` directive

### `Protecting against clickjacking using CSP`
- The following directive will only allow the page to be framed by other pages from the same origin:
```
frame-ancestors 'self'
```
- The following directive will prevent framing altogether:
```
frame-ancestors 'none'
```
- Using CSP to prevent clickjacking is more flexible than using the X-Frame-Options header because you can specify multiple domains and use wildcards such as:
```
frame-ancestors 'self' https://website.com https://*.robust-website.com
```
- CSP also validates each frame in the parent frame hierarchy, whereas `X-Frame-Options` only validates the top-level frame.


--------------------------------------------------------------------------------
## Materials
### Reference
- [XSS](https://portswigger.net/web-security/cross-site-scripting)
- [DOM-based XSS](https://portswigger.net/web-security/cross-site-scripting/dom-based)
- [Exploiting XSS vulnerabilities](https://portswigger.net/web-security/cross-site-scripting/exploiting)

### Labs
- [DOM XSS in document.write sink using source location.search](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-document-write-sink)
- [DOM XSS in document.write sink using source location.search inside a select element](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-document-write-sink-inside-select-element)
- [DOM XSS in innerHTML sink using source location.search](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-innerhtml-sink)
- [DOM XSS in jQuery anchor href attribute sink using location.search source](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-jquery-href-attribute-sink)
- [DOM XSS in AngularJS expression with angle brackets and double quotes HTML-encoded](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-angularjs-expression)
- [Reflected DOM XSS](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-dom-xss-reflected)
- [Stored DOM XSS](https://portswigger.net/web-security/cross-site-scripting/dom-based/lab-dom-xss-stored)
- [Exploiting cross-site scripting to steal cookies](https://portswigger.net/web-security/cross-site-scripting/exploiting/lab-stealing-cookies)
- [Exploiting cross-site scripting to capture passwords](https://portswigger.net/web-security/cross-site-scripting/exploiting/lab-capturing-passwords)
- [Exploiting XSS to perform CSRF](https://portswigger.net/web-security/cross-site-scripting/exploiting/lab-perform-csrf)
- [Reflected XSS protected by CSP, with dangling markup attack](https://portswigger.net/web-security/cross-site-scripting/content-security-policy/lab-csp-with-dangling-markup-attack)
- [Reflected XSS protected by very strict CSP, with dangling markup attack](https://portswigger.net/web-security/cross-site-scripting/content-security-policy/lab-very-strict-csp-with-dangling-markup-attack)
- [Reflected XSS protected by CSP, with CSP bypass](https://portswigger.net/web-security/cross-site-scripting/content-security-policy/lab-csp-bypass)
