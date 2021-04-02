# Authentication Vulnerabilities



- Among the most critical due to the relationship between authentication and security.
- Also allows attackers direct access to sensitive data and functionality, expose additional attack surface for further exploits.
- > Authentication is the process of verifying the identity of a given user or client.
- There are three authentication factors into which different types of authentication can be categorized:
    1. Something you **know** eg password or answer to security question. Also referred to as ```knowledge factors```.
    2. Something you **have** eg a physical object like a mobile phone or a security token. Also referred to as ```possession factors```.
    3. Something you **are** or do eg biometrics or patterns of behaviour. Also referred to as ```inherence factors```.
    
 ### Difference between authentication and authorization.
 - ```Authentication``` is the process of verifying that a user really is **who they claim to be** whereas ```Authorization``` involves verifying whether a user is **allowed to do something**
 
### Arising of authentication vulnerabilities.
- They arise in one of two ways:
    1. The authentication mechanisms are weak because they fail to protect against brute-force attacks.
    2. Logic flaws or poor coding in the implementation allow the authentication mechanisms to be bypassed entirely by an attacker, also referred to as **broken authentication**.
- In many areas of web development, logic flaws will cause the website to behave unexpectedly, which may or may not be a security issue however, the likelihood that flawed authentication logic exposes the website to security issues is elevated.

#### 1.Vulnerabilities in password-based login
- Websites that adopt a password-based login process, users either register for an account themselves or they are assigned an account by an administrator, of which the accounts are associated with a unique ```username``` and ```password``` which the users use to authenticate themselves.
- Can be compromised through:
   1. ```Brute-force attacks```
      - > A brute-force attack is when an attacker uses a system of trial and error to attempt to guess valid user credentials.
      - Attacks are automated using wordlists of usernames and passwords.
      - Websites that rely on password-based login as their sole method of authenticating users can be highly vulnerable if they do not implement sufficient brute-force protection.
        
   2.  ```Brute-forcing usernames```
        - Usernames are easy to guess if they conform to a recognizable pattern, such as email address.
        - Eg it is common to see business logins in the format ```firstname.lastname@company.com```. Even though there is no obvious pattern, sometimes even high-privileged accounts are created using predictable usernames such as ```admin``` or ```administrator```.
        - During auditing, check whether the website discloses potential usernames publicly.
        - Check HTTP responses to see if any email addresses are disclosed.
        - Responses may contain email addresses of high-priviledged users like administrators and IT support.
    
   3. ``` Brute-forcing passwords```
        - Passwords can be brute-forced with the difficulty varying based on the strength of the password.
        - Enforcing password involves using a:
          1. minimum number of characters.
          2. mixture of lower and uppercase letters.
          3. Atleast one special character.
        - While high entropy password are difficult for computers alone to crack, one can use a basic knowledge of human behavior to exploit the vulnerabilities that users unwittingly introduce to the system.
        - Where the policy requires users to change their passwords on a regular basis, it is common for users to to just make minor, predictable changes to their preferred passwords. Eg ```Mypassword!``` becomes ```MyPassword1?``` or ```mypAssword2.!```
        
    4. ```Username enumeration```
        - > Username enumeration is when an attacker is able to observe changes in the website's behaviour in order to identify whether a given username is valid.
        - Occurs either on the login page or on registration forms when you enter a username that is already taken and greatly reduces the time and effort required to brute-force a login because the attacker is able to quickly generate a shortlist of valid usernames.
        - During attempts to brute-force a login page, pay attention to:
          1. Status codes.
          2. Error messages.
          3. Response times.
            
    5. ```Flawed brute-force protection```
        - The most common ways of preventing brute-force attacks:
          1. Locking the account that the remote user is trying to access if they make too many failed login attempts.
          2. Blocking the remote user's IP address if they make too many login attempts in a quick succession.
        - Ip may be blocked if one logs in too many times. In some implementations, the counter for number of failed attempts resets if the IP owner logs in successfully.
        
        a. ``` Account Locking ```
          - Websites try to prevent brute-forcing is to lock the account if certain suspicious criteria are met, set at a number of failed logins.
          - Responses from the server indicating that an account is locked can also help an attacker to enumerate usernames.
          - Locking an account fails to adequately prevent brute-force attacks in which the attacker is just trying to gain access to any random account they can.
          - ```Methods to work around this protection```
              1. Establish a list of candidate usernames likely to be valid through username enumeration or list of common names.
              2. Decide on a very small shortlist of passwords atleast a user is likely to have and must not exceed number of login attempts allowed.
              3. Using tools such as [Burp](https://portswigger.net/burp) intruder, try each of the selected passwords with each of the candidate usernames.
          - Account locking also fails to protect against credential stuffing attacks which involves using a massive dictionary of ```username:password``` pairs composed of genuine login credentials stolen in data breaches.
        
        b. ``` User rate limiting ```
          - Here, making too many login requests within a short period of time causes your IP add to be blocked.
          - Ip can be unblocked through:
            1. Automatically after a certain period of time has elapsed.
            2. Manually by an administrator.
            3. Manually by the user after successfully completing a CAPTCHA.
         - Is preferred to account locking due to being less prone to username enumeration and denial of service attacks.
         - As the limit is based on the rate of HTTP requests sent from the user's IP add, it is sometimes also possible to bypass this defense by working out how to guess multiple passwords with a single requests.
    
    6. ```HTTP basic authentication```
        - The client receives an authentication token from the server which is constructed by concatenating the username and password, and encoding it in Base64.
        - The token is stored and managed by the browser, which automatically adds it to the ```Authorization``` header of every subsequent request as follows:
        > ```Authorization: Basic base64(username:password)```
        - Is not considered a secure authentication method because:
            - It involves repeatedly  sending the user's login credentials with every request unless the website also implements HSTS, user credentials are open to being captured in a MITM attack.
            - Implementations of HTTP basic authentication often don't support brute-force protection as the token consists exclusively of static values leaving it vulnerable to being brute-forced.

----------------------------------------------------------------
# Materials
- ``Referencing:``
  - [Authentication](https://portswigger.net/web-security/authentication)
  - [Password-based authentication](https://portswigger.net/web-security/authentication/password-based)
  - [multi-factor authentication](https://portswigger.net/web-security/authentication/multi-factor)
  - [Other authentication mechanisms](https://portswigger.net/web-security/authentication/other-mechanisms)
    
- ``Labs:``
  - [Lab 1](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-different-responses)
  - [Lab 2](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-subtly-different-responses)
  - [Lab 3](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-response-timing)
  - [Lab 4](https://portswigger.net/web-security/authentication/password-based/lab-broken-bruteforce-protection-ip-block)
  - [Lab 5](https://portswigger.net/web-security/authentication/password-based/lab-username-enumeration-via-account-lock)
  - [Lab 6](https://portswigger.net/web-security/authentication/password-based/lab-broken-brute-force-protection-multiple-credentials-per-request)

---------------------------------------------------------------
