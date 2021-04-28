# CSRF
## Common CSRF Vulnerabilities.
- Most CSRF vulnerabilities arise due to mistakes made in the validation of CSRF tokens.
- Supposing the application includes a CSRF token within the request to change the user's password:
```
POST /email/change HTTP/1.1
Host: vulnerableWebsite.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 68
Cookie: session=2yQIDcpia41WrATfjPqvm9tOkDvkMvLm

csrf=WfF1szMUHhiokx9AHFply5L2xAOfjRkE&email=wiener@normal-user.com 
```
- This ought to prevent CSRF attacks because it violates the necessary conditions for a CSRF vulnerability: the application no longer relies solely on cookies for session handling and the request contains a parameter whose value an attacker cannot determine.

#### Validation of CSRF token depending on request method
- Some applications correctly validate the token when the request uses the `POST` method but skip the validation when the `GET` method is used.
- The attacker can switch to the GET method to bypass the validation and deliver a CSRF attack:
```
GET /email/change?email=pwned@evilUser.net HTTP/1.1
Host: vulnerableWebsite.com
Cookie: session=2yQIDcpia41WrATfjPqvm9tOkDvkMvLm
```
#### Validation of CSRF token depending on token being present.
- Some applications correctly validate the token when it is present but skip the validation if the token is omitted.
- The attacker can remove the entire parameter containing the token(not just in view) to bypass the validation and deliver a CSRF attak:
```
POST /email/change HTTP/1.1
Host: vulnerable-website.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 25
Cookie: session=2yQIDcpia41WrATfjPqvm9tOkDvkMvLm

email=pwned@evil-user.net
```
#### CSRF is not ties to the user session
- Some applications do not validate that the token belongs to the same session as the user who is making the request and instead, the application maintains a global pool of tokens that it has issued and accepts any token that appears in this pool.
- In such a situation, the attacker can log into the application using their own account, obtain a valid token and then feed that token to the victim user in their CSRF attack.

#### CSRF token is tied to a non-session cookie
- Some applications do tie the CSRF token to a cookie but not to the same cookie that is used to track sessions.
- This can easily occur when an application employs two different frameworks, one for session handling and one for CSRF protection, which are not integrated together:
```
POST /email/change HTTP/1.1
Host: vulnerableWebsite.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 68
Cookie: session=pSJYSScWKpmC60LpFOAHKixuFuM4uXWF; csrfkey=rZHCnSzEp8dbI6atzagGoSYyqJqTz5dv

csrf=RhV7yQDO0xcq9gLEah2WVbmuFqyOq7tY&email=wiener@normal-user.com 
```
- If the website contains any behaviour that allows an attacker to set a cookie in a victim's browser, then an attack is possible and the attacker can log in to the application using their own account, obtain a valid token and associated cookie, leverage the cookie-setting behavior to place their cookie into the victim's browser, and feed their token to the victim in their CSRF attack.

#### CSRF Token is simply duplicated in a cookie
- Some applications do not maintain any server-side record of tokens that have been issued but instead duplicate each token within a cookie and a request parameter.
- When the request is validated, the application simply verifies that the token is submitted in the request parameter matches the value submitted in the cookie, called the **double submit** against CSRF, and is advocated because it is simple to implement and avoids the need for any server-side state:
```
POST /email/change HTTP/1.1
Host: vulnerable-website.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 68
Cookie: session=1DQGdzYbOJQzLP7460tfyiv3do7MjyPw; csrf=R8ov2YBfTYmzFyjit8o2hKBuoIjXXVpa

csrf=R8ov2YBfTYmzFyjit8o2hKBuoIjXXVpa&email=wiener@normal-user.com 
```
- The attacker here doesn't need to obtain a valid token of their own, they can invent a token, leverage the cookie-setting behavior to place their cookie into the victim's browser, and feed their token to the victim in their CSRF attack.

#### Referer-based defenses against CSRF
- Aside from defenses that employ CSRF tokens, some applications make use of the HTTP `Referer` header to defend against CSRF attacks, normally by verifying that the request originated from the application's own domain.
- Approach is less effective and is often subject to bypasses.

#### Validation of Referer depending on header being present.
- Some applications validate the `Referer` header when it is present in requests but skip the validation if the header is omitted.
- An attacker can therefore craft their CSRF exploit in a way that causes the victim user's browser to drop the `Referer` header in the resulting request.
- Easiest way is using a `Meta` tag within the HTML page that hosts the CSRF attack:
```
<meta name="referer" content="never">
```

#### Validation of referer can be circumvented
- Some applications validate the `Referer` header in a naive way that can be bypassed.
- If the application simply validates that the `Referer` contains its own domain name, then the attacker can place the required value elsewhere in the URL:
```
http://attackerWebsite.com/csrf-attack?vulnerable-website.com
```

--------------------------------------------------------------------------------
# MATERIALS
## Referencing
- [PortSwigger](https://portswigger.net/web-security/csrf)


## Labs
- [CSRF where token validation depends on request method](https://portswigger.net/web-security/csrf/lab-token-validation-depends-on-request-method)
- [CSRF where token validation depends on token being present](https://portswigger.net/web-security/csrf/lab-token-validation-depends-on-token-being-present)
- [CSRF where token is not tied to user session](https://portswigger.net/web-security/csrf/lab-token-not-tied-to-user-session)
- [CSRF where token is tied to non-session cookie](https://portswigger.net/web-security/csrf/lab-token-tied-to-non-session-cookie)
- [CSRF where token is duplicated in cookie](https://portswigger.net/web-security/csrf/lab-token-duplicated-in-cookie)
- [CSRF where Referer validation depends on header being present](https://portswigger.net/web-security/csrf/lab-referer-validation-depends-on-header-being-present)
- [CSRF with broken Referer validation](https://portswigger.net/web-security/csrf/lab-referer-validation-broken)
