# Vulnerabilities in Other authentication mechanisms

- In addition to basic login functionality, most websites provide supplementary functionality to allow users to manage their account eg changing and reseting their passwords.
- Websites usually take care to avoid well-known vulnerabilities in their login pages but they can be easily be overlooked.

### Keeping users logged in.
- A common feature is the option to stay logged in even after closing the browser session ie in **Remember me** or **Keep me logged in**.
- This functionality is often implemented by generating a ``remember me`` token which is then stored in a persistent cookie.
- Best practice for this cookie to be impractical to guess as this cookie allows one to bypass the entire login process.
- Some websites generate this cookie based on a predictable concatenation of static values such as usernames and a timestamp, or even passwords as part of the cookie.
- Approach is dangerous if attacker is able to create their own account because they can study their own cookie and potentially deduce how it is generated and can try to brute-force other users' cookies to gain access to their accounts.
- Naively 'encrypting' the cookie using a simple two-way encoding like Base64 offers no protection.
- Using proper encryption with a one-way hash function is not completely bulletproof. 
- If the attacker is able to easily identify the hashing algorithm, and no salt is used, they can potentially brute-force the cookie by simply hashing their wordlists. This method can be used to bypass logging attempt limits if a similar limit isn't applied to cookie guesses.
- It may be possible to obtain a user's actual password in cleartext from a cookie even if it is hashed.

### Resetting user passwords
- Can be done through:
  1. Sending passwords by email
      - Some websites generate a new password and send this to the user via email.
      - Sending persistent password over insecure channels is to be avoided therefore the security relies on either the generated password expiring after a very short period of time, or the user changing their password again immediately otherwise is susceptible to MITM attacks.
        
  2. Resetting password using a URL
      - Resetting passwords by sending a unique URL to users is robust and takes them to a password reset page.
      - Less secure implementations of this method use a URL with an easily guessable parameter to identify which account is being reset. eg:
        ```http://website.com/reset-password?user=victim-user```
      - An attacker could change the `user` parameter to refer to any username they have identified and would then be taken straight to a page where they can potentially set a new password for this user.
      - Better implementation of this process is to generate a hight-entropy, hard-to-guess token and create the reset URL based on that. This URL should provide no hints about which users password is being reset.
        ```http://website.com/reset-password?token=a0ba0d1cb3b63d13822572fcff1a241895d893f659164d4cc550b421ebdd48a8 ```
      - When the user visits this URL, the system should check whether this token exists on the back-ennd and, if so, which user's password it is supposed to reset. The token should expire after a short period of time and be destroyed immediately after the password has been reset.
      - An attacker could visit the reset form from their own account, delete the token and leverage this page to reset an arbitrary user's password.
        
## Password reset poisoning
> Is a technique whereby an attacker manipulates a vulnerable website into generating a password reset link pointing to a domain under their control.
- This can be leveraged to steal the secret tokens required to reset arbitrary users' passwords and, ultimately compromise their accounts.

#### ``How password reset work``
> 1. User enters their username or email and submits a password reset request.
> 2. Website checks that the user exists and generates a temporary, unique, high-entropy token which it associates with the users account on the back-end.
> 3. Website sends an email to the user that contains a link for resetting their password. The user's unique reset token is included as a query parameter in the corresponding URL:
>   ```https://website.com/reset?token=0a1b2c3d4e5f6g7h8i9j```
> 4. When user visits this URL, the website checks whether the provided token is valid and uses it to determine which account is being reset.
> 5. The user is given the option to enter a new password and the token is destroyed.
        
#### ``How to construct a password reset poisoning attack``
- If the URL sent to the user is dynamically generated based on conrollable input such as the **Host header**, it may be possible to construct a password reset poisoning attacks as below:
    1. Attacker obtains the victim's email address or username and submits a password reset request on their behalf. When submitting the form, intercept the resulting HTTP request and modify the Host header so that it points to a domain that they control eg attacker.net
    2. The victim receives a genuine password reset email directly from the website however the domain name in the URL points to the attacker's server:
           ```https://attacker.net/reset?token=0a1b2c3d4e5f6g7h8i9j```
     3. If the victim clicks the link or is fetched in some other way such as by an antivirus scanner, the password reset token will be delivered to the attackers server.
     4. The attacker can now visit the real URL for the vulnerable website and supply the victim's stolen token via the corresponding parameter then be able to reset the user's password to whatever they like and log into their account.
- In a other attacks, the attacker may seek to increase the probability of the victim clicking the link by first warming them up with a fake breach notification,eg:
> Even if you can't control the password reset link, you can sometimes use the Host header to inject HTML into sensitive emails. Email clients typically don't execute JavaScript, but other HTML injection techniques like [dangling markup attacks](https://portswigger.net/web-security/cross-site-scripting/dangling-markup) may still apply.
        
### Changing user passwords
- Password change functionality can be dangerous if it allows an attacker to access it directly without being logged in as the victim user

## Securing authentication mechanisms.
1. Take care with user credentials.
2. Don't count on users for security.
3. Prevent username enumeration.
4. Implement robust brute-force protection.
5. Tripple-check verification logic.
6. Implement proper multi-factor authentication.


--------------------------------------------------------------------------------
# Materials
### Referencing
  - [Other authentication mechanisms](https://portswigger.net/web-security/authentication/other-mechanisms)
  - [Password reset poisoning](https://portswigger.net/web-security/host-header/exploiting/password-reset-poisoning)
    
### Labs
  - [Lab: Brute-forcing a stay-logged-in cookie](https://portswigger.net/web-security/authentication/other-mechanisms/lab-brute-forcing-a-stay-logged-in-cookie)
  - [Lab: Offline password cracking](https://portswigger.net/web-security/authentication/other-mechanisms/lab-offline-password-cracking)
  - [Lab: Password reset broken logic](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-broken-logic)
  - [Lab: Password reset poisoning via middleware](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-poisoning-via-middleware)
  - [Lab: Password brute-force via password change](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-brute-force-via-password-change)
  - [Lab: Basic password reset poisoning](https://portswigger.net/web-security/host-header/exploiting/password-reset-poisoning/lab-host-header-basic-password-reset-poisoning)
  - [Lab: Password reset poisoning via middleware](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-poisoning-via-middleware)
  - [Lab: Password reset poisoning via dangling markup](https://portswigger.net/web-security/host-header/exploiting/password-reset-poisoning/lab-host-header-password-reset-poisoning-via-dangling-markup)

--------------------------------------------------------------------------------
