# Cross-Origin Resource Sharing (CORS)
> Is a browser mechanism that enables controlled access to resources located outside of a given domain.
- It extends and adds flexibility to the `same-origin policy(SOP)`, however it also provides potential for cross-domain based attacks if a websites CORS policy is poorly configured and implemented.

## Same-Origin Policy.(SOP)
> Is a restrictive COR specification that limits the ability for a website to interact with resources of the source domain.
- It allows a domain to issue requests to other domains not to access the responses.
- SOP is a web browser security mechanism that aims to prevent websites from attacking each other.
- It restricts scripts on one origin from accessing data from another origin.
- An origin consists of a URI scheme, domain and port number, as below:
```
http://normalwebsite.com/example/example.html
```
- This uses the scheme `http`, tho domain `normalwebsite.com` and the port number `80`.
- The following table shows how the same-origin policy will be applied if content at the above URL tries to access other origins:

| URL Accessed                            | Access Permitted?                   |
| :---                                    |                               ---:  |
| http://normalwebsite.com/example/       | Yes: same scheme, domain, and port  |
| http://normalwebsite.com/example2/      | Yes: same scheme, domain, and port  | 
| https://normalwebsite.com/example/      | No: different scheme and port       |
| http://en.normalwebsite.com/example/    | No: different domain                |
| http://www.normalwebsite.com/example/   | No: different domain                |
| http://normalwebsite.com:8080/example/  | No: different port                  |

- When a browser sends an HTTP request from one origin to another, any cookies, including authentication session cookies, relevant to the other domain are also part of the request. 
- This means that the response will be generated within the user's session and include any relevant data that is specific to the user.
- Without the same-origin policy, if you visited a malicious website, it would be able to read your emails from GMail, private messages from Facebook etc,

## Implementation of Same-origin policy
- SOP generally controls the access that JavaScript code has to content that is loaded cross-domain.
- Cross-origin loading of page resources is generally permitted.
- Various exceptions to the same-origin policy:
   1. Some objects are writable but not readable cross-domain such as the `location` object or the `location.href` property from iframes or new window.
   2. Some objects are readable but not writable cross-domain, such as the `length` property of the `window` object and the `closed` property.
   3. The `replace` function can be call cross-domain on the`location` object.
   4. You can call certain functions cross-domain. For example, you can call the functions `close`, `blur` and `focus` on a new window. The `postMessage` function can also be called on iframes and new windows in order to send messages from one domain to another. 
