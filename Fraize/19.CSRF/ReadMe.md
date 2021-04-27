# Cross-site Request Forgery (CSRF)

> CSRF is a web-security vulnerability that allows an attacker to induce users to perform actions that they do not intend to perform.
- It allows an attacker to partly circumvent the same origin policy, which is designed to prevent different websites from interfering with each other.
## Impact of a CSRF attack
- The attacker causes the victim user to carry out an action unintentionally.
- Depending on the nature of action, the attacker might be able to gain full control over the user's account.
- If the compromised user has a privileged role within the application, then the attacker might be able to take full control of all the application's data and functionality.

## How does CSRF work?
- The following conditions must be in place:
  1. `A relevant action`
  - There is an action within the application that the attacker has a reason to induce such as privileged action or any action on user-specific data.
  2. `Cookie-based session handling`
  - Performing the action involves issuing one or more HTTP requests and the application relies solely on session cookies to identify the user who has made the requests.
  3. `No unpredictable request parameters.`
  - The requests that perform the action do not contain any parameters whose values the attacker cannot determine or guess. such as when causing a user to change their password, the function is not vulnerable if an attacker needs to know the value of the existing password.
  
- Eg, if an application contains a function that lets the user change the email address on their account. When a user performs this action, they make an HTTP request as below:
```
POST /email/change HTTP/1.1
Host: website.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 30
Cookie: session=yvthwsztyeQkAPzeQ5gHgTvlyxHfsAfE

email= james@user.com
```
- The above meets the condition required for CSRF:
  1. The action of changing the email address on a user's account is of interest to an attacker. The attacker will typically be able to trigger a password reset and take full control of the user's account.
  2. The application uses a session cookie to identify which user issued the request. There are no other tokens or mechanisms in place to track user sessions.
  3. The attacker can easily determine the values of the request parameters that are needed to perform the action.
  
- With above in place an attacker can construct a web page containing the following HTML:
```
<html>
  <body>
    <form action="https://vulnerable-website.com/email/change" method="POST">
    </form>
    <script>
      document.forms[0].submit();
    </script>
  </body>
</html>
```
- If a victim user visits the attacker's web page, the following will happen:
  1. The attacker's page will trigger an HTTP request to the vulnerable website.
  2. If the user is logged in to the vulnerable website, their browser will automatically include their session cookie in the request.
  3. The vulnerable website will process the request in the normal way, treat it as having been made by the victim user and change their emails.
  
## Constructing a CSRF attack
- The easiest way to construct a CSRF exploit is using the **CSRF PoC generator** that is built in to Burp Suites Professional:
  1. Select a request anywhere in Burp suites professional that you want to test or exploit.
  2.  From the right-click context menu, select Engagement tools / Generate CSRF PoC.
  3. Burp Suite will generate some HTML that will trigger the selected request (minus cookies, which will be added automatically by the victim's browser).
  4. You can tweak various options in the CSRF PoC generator to fine-tune aspects of the attack. You might need to do this in some unusual situations to deal with quirky features of requests.
  5. Copy the generated HTML into a web page, view it in a browser that is logged in to the vulnerable web site, and test whether the intended request is issued successfully and the desired action occurs. 
  
## How to deliver a CSRF exploit
- The delivery mechanisms for CSRF attacks are essentially the same as reflected XSS.
- Attacker will place the malicious HTML onto a website that they control and then induce victims to visit that website.
- This might be done by feeding the user a link to a website via an email or social media message. Or if the attack is placed into a popular website such as a **user comment**, they might just wait for users to visit the website.
- Some simple CSRF exploits employ the GET method and can be fully self-contained with a single URL on the vulnerable website. The attacker may not need to employ an external site, and can directly feed victims a malicious URL on the vulnerable domain.
- If the request to change email address can be performed with the GET method, then a self-contained attack would be:
```
<img src="https://vuln-website.com/email/change?email=pwned@evil-user.net">
```

## Preventing CSRF attacks
- The most robust way to defend against CSRF attacks is to include a `CSRF token` within relevant requests. The token should be:
  1. Unpredictable with high entropy, as for session tokens in general.
  2. Tied to the user's session.
  3. Strictly validated in every case before the relevant action is executed.
  
## CSRF Tokens
> A CSRF token is a unique, secret, unpredictable value that is generated by the server-side application and transmitted to the client in a way that it is included in a subsequent HTTP request made by the client.
- When the later request is made, the server-side application validates that the request includes the expected token and rejects the request if the token is missing or invalid.
- CSRF tokens can prevent CSRF attacks by making it impossible for an attacker to construct a fully valid HTTP request suitable for feeding to a victim user.
- An attacker cannot contruct a request with all the parameters that are necessary for the application to honor the request since he/she cannot determine or predict the value of a user's CSRF token.
#### Generating a CSRF token.
- CSRF tokens should contain significant entropy, strongly unpredictable with the same properties as session tokens.
- Use a cryptographic strength pseudo-random number generator(PRNG), seeded with the timestamp when it was created plus a static secret.
- You can generate individual tokens by concatenating its output with some user-specific entropy and take a strong hash of the whole structure which presents an additional barrier to an attacker who attemptes to analyze the tokens based on a sample that are issued on them.
#### Transmitting CSRF tokens
- An effective approach is transmitting the token within a hidden field of an HTML form that is submitted using the POST method.
- The token will then be included as a request parameter when the form is submitted:
```
<input type="hidden" name="csrf-token" value="CIwNZNlR4XbisJF39I8yWnWX9wX4WFoz" />
```
- An additional safety is placing the field containing the CSRF token as early as possible within the HTML document before any non-hidden input fields and before any locations where user-controllable data is embedded within the HTML.
- An alternative approach, of placing the token into the URL query string, is somewhat less safe because the query string:
  1. Is logged in various locations on the client and server side;
  2. Is liable to be transmitted to third parties within the HTTP Referer header;
  3. Can be displayed on-screen within the user's browser.
- Some applications transmit CSRF tokens within custom request header adding more defense, however, the approach limits the application to making CSRF-protected requests using XHR as opposed to HTML forms and might be deemed over-complicated for many situations.
> CSRF tokens shouldn't be transmitted within cookies.
#### Validating CSRF Tokens
- When generated, the CSRF token should be stored server-side within the user's session data.
- When a subsequent request is received that requires validation, the server-side application should verify that the request includes a token which matches the value stored in the user's session.
- Validation must be performed regardless of the HTTP method or content type of the request. If the request doesn't contain any token at all, it should be rejected in the same way as when an invalid token is present.

## Defending against CSRF with SameSite cookies
- The `SameSite` attribute can be used to control whether and how cookies are submitted in cross-site requests.
- An application can prevent the default browser behaviour of automatically adding cookies to requests regardless of where they originate, done by setting the attribute on session cookies.
- The `SameSite` attribute is added to the `Set-Cookie` response header when the server issues a cookie, and the attribute can be given two values **Strict** or **Lax** as below:
```
Set-Cookie: SessionId=sYMnfCUrAlmqVVZn9dqevxyFpKZt30NN; SameSite=Strict;
Set-Cookie: SessionId=sYMnfCUrAlmqVVZn9dqevxyFpKZt30NN; SameSite=Lax;
```
- If set to `Strict`, then the browser will not include the cookie in any requests that originate from another site.
- This is the most defensive option, but can impair the user experience because if a logged-in user follows a third-party link to a site, then they will appear not to be logged in and will need to log in again before interacting with the site.
- If set to `Lax`, then the browser will include the cookie in requests that originate from another site but only if two conditions are met:
  1. The request uses the `GET` method.
  2. The request resulted from a top-level navigation by the user, such as when clicking a link. Other scripts such as those initiated by scripts will not include the cookie.

--------------------------------------------------------------------------------
## Materials
#### Referencing
- [PortSwigger - CSRF](https://portswigger.net/web-security/csrf)
- [XSS vs CSRF](https://portswigger.net/web-security/csrf/xss-vs-csrf)

#### Labs
- [CSRF vulnerability with no defenses](https://portswigger.net/web-security/csrf/lab-no-defenses)
