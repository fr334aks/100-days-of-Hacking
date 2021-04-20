# Information Disclosure Vulnerabilities

### What is information disclosure?
> Also known as `information leakage`, is when a website unintentionally reveals sensitive information to its users.
- Depending on the context, websites may leak all kinds of information to a potential attacker, including:
    1. Data about other users, such as usernames or financial information.
    2. Sensitive commercial or business data.
    3. Technical details about the website and its infrastructure.
- Some of the information will be of limited use, it can potentially be a starting point for exposing an additional attack surface which may contain other interesting vulnerabilities.
- Knowledge able to be gathered could even provide the missing piece of the puzzle when trying construct complex, high-severity attacks.
- An attacker needs to elicit the information disclosure by interacting  with the website in unexpected or malicious ways. They will then study the website's responses to try and identify interesting behaviour.

### Examples of information disclosure.
1. Revealing the names of hidden directories, their structure, and their contents via `robots.txt` file or directory listing.
2. Providing access to source code files via temporary backups.
3. Explicitly mentioning database table or column names in error messages.
4. Unnecessarily exposing highly sensitive information, such as credit card details.
5. Hard-coding API keys, IP addresses, database credentials and so on in the source code.
6. Hinting at the existence or absence of resources, usernames and so on via subtle differences in application behavior.

### Arising of Information Disclosure Vulnerabilities.
1. `Failure to remove internal content from public content.`
    - Eg developer comments in markup are sometimes visible to users in the production environment.
2. `Insecure configuration of the website and related technologies.`
    - Eg failing to disable debugging and diagnostic features can sometimes provide attackers with useful tools to help them obtain sensitive information.
    - Default configurations can also leave websites vulnerable by displaying verbose error messages.
3. `Flawed design and behavior of the application.`
    - Eg if a website returns distinct responses when different error states occur, this can also allow attackers to enumerate sensitive data such as valid user credentials.
    
### Impact of information disclosure vulnerabilities.
- Information disclosure vulnerabilities can have both a direct and indirect impact depending on the purpose of the website therefore what information an attacker is able to obtain.
- In some cases, an act of disclosing sensitive information alone can have a high impact on the affected parties.
- Leaking technical information such as the directory structure or which third-party frameworks are being used, may have little to no direct impact however, in the wrong hands this could be the key information required to construct any number of other exploits.
- Severity depends on what the attacker is able to do with this information.

### How to assess the severity of information disclosure vulnerabilities.
- Although the ultimate impact can potentially be very severe, it is only in specific circumstances that information disclosure is a high-severity issue on its own.
- During testing, the disclosure of technical information in particular is often only of interest if you are able to demonstrate how an attacker could do something harmful with it.
> The knowledge that a website is using a particular framework version is of limited use if that version is fully patched. However, this information becomes significant when the website is using an old version that contains a known vulnerability. Performing a devastating attack could be as simple as applying a publicly documented exploit.
- It is likely that minor technical details can be discovered in numerous way on many websites tested. Therefore, main focus should be on the impact and exploitability of the leaked information, not just the presence of information disclosure as a a standalone issue.
- The obvious excpetion to this is when the leaked information is so sensitive that it warrants attention in its own right.

### Types of Information Disclosure Issues.
1. `Banner Grabbing/Active Reconnaissance`
> Is a type of attack during which the attackers send requests to the system they are attempting to attack in order to gather more information about it.
- If the system is not well configured, it may leak information about itself such as the server version, PHP/ASP.NET version, OpenSSH version etc.
- Banner grabbing doesn't involve the leakage of critical pieces of information but rather information that may aid the attacker through the exploitation phase of the attack.
2. `Source Code Disclosure`
> Source code disclosure issues occur when the code of the backend environment of a web application is exposed to the public.
- It enables attackers to understand how the application behaves by simply reading the code and checking for logical flaws, or hardcoded username/password pairs, or API secret keys.
- The severity depends on how much of the code is exposed, and how critical the leaked lines of code are for the security of the web application.
- Source code disclosure turns a black box testing process into more of a white box testing process into more of a white box testing approach since attackers get access to the code.
- Can occur in numerous ways, such as:
    1. Unprotected public code repositories.
        - Some source code repositories only allow users to see their content based on an authentication process. Such repositories are sometimes ill configured, leaving their content accessible to anyone that for example has a particular email address, failing to restrict access to certain accounts that should have such levels of access.
    2. Incorrect MIME types.
        - Web browsers know how to parse the information they receive from the `Content-Type` HTTP header, which is sent by the web server in the HTTP response.
        - If the web server is misconfigured, and for example it sends the header `Content-Type: text/plain` instead of `Content-Type:text/html` when serving a HTML page, the code will be rendered as plain text in the browser, allowing the attacker to see the source code of the page.
3. `Inappropriate Handling of Sensitive Data.`
- A common mistake is hardcoding important information such as username/password pairs, internal IP addresses in scripts and comments in code and web pages.
- The disclosure of such information may cause ravaging outcomes for the web application; all the attacker has to do is to look for such information in the source of those web pages.
4. `File Name & File Path Disclosure`
- In some circumstances web applications can disclose file names or file paths hence revealing information about the structure of the underlying system.
- This can handle due to incorrect handling of user input, exceptions at the backend or inappropriate configuration of the web server.
- Such information can be found or identified in the responses of the web applications, error pages, debugging information among many others.
5. `Directory Listing`
- This functionality is provided by default on web servers.
- When there is no default web page to show the web server shows the user a list of files and directories present on the website.
- If the default filename on an Apache web server is `index.php` and you have not uploaded a file called index.php in the root directory of your website, the server will show a directory listing of the root directory instead of parsing the php file.

### Preventing information disclosure vulnerabilities.
- Preventing information disclosure completely is tricky due to the huge variety of ways in which it can occur.
- There are some general best practices that you can follow to minimize the risk of these kinds of vulnerability creeping into your own website.
1. Make sure that everyone involved in producing the website is fully aware of what information is considered sensitive. Sometimes seemingly harmless information can be much more useful to an attacker than people realize.
2. Audit any code for potential information disclosure as part of your QA or build processes. It should be relatively easy to automate some of the associated tasks, such as stripping developer comments.
3. Use generic error messages as much as possible. Don't provide attackers with clues about application behavior unnecessarily.
4. Double-check that any debugging or diagnostic features are disabled in the production environment.
5. Make sure you fully understand the configuration settings and security implications of any third-party technology that you implement. Take time to investigate and disable any features and settings that you don't actually need.
6. Make sure that your web server doesn't send out response headers or background information that reveal technical details about the backend technology type, version or setup.
7. Make sure that all the services running on the server’s open ports do not reveal information about their builds and versions.
8. Always make sure that proper access controls and authorizations are in place in order to disallow access for attackers on all web servers, services and web applications.
9. Make sure that all exceptions are well handled when the web application fails and no technical information is reported in the errors.
10. Do not hard code credentials, API keys, IP addresses, or any other sensitive information in the code, including first names and last names, not even in the form of comments.
11. Configure the correct MIME types on your web server for all the different files being used in your web applications.
12. Sensitive data, files and any other item of information that do not need to be on the web servers should never be uploaded on the web server.
13. Always check whether each of the requests to create/edit/view/delete resources has proper access controls, preventing privilege escalation issues and making sure that all the confidential information remains confidential.
14. Make sure that your web application processes user input correctly, and that a generic response is always returned for all the resources that don’t exist/are disallowed in order to confuse attackers.
15. Enough validations should be employed by the backend code in order to catch all the exceptions and prevent the leakage of valuable information.
16. Configure the web server to suppress any exceptions that may arise and return a generic error page.
17. Configure the web server to disallow directory listing and make sure that the web application always shows a default web page.

--------------------------------------------------------------------------------
## Materials
### `Referencing`
- [PortSwigger](https://portswigger.net/web-security/information-disclosure)
- [Netsparker blog](https://www.netsparker.com/blog/web-security/information-disclosure-issues-attacks/)
