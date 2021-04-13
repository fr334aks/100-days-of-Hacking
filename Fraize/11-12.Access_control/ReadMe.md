# ACCESS CONTROL - Access control vulnerabilities and privilege escalation

> Access control or authorization is the application of constraints on who or what can perform attempted actions or access resources that they have requested.
- Access control is dependent on authentication and session management: 
    1. `Authentication` identifies the user and confirms that they are who they say they are.
    2. `Session management` identifies which subsequent HTTP requests are being made by that same user.
    3. `Access control` determines whether the user is allowed to carry out the action that they are attempting to perform.
- Broken access controls are commonly encountered and often critical security vulnerability.
- Design and management of access controls is a complex and dynamic problems that applies business, organizational and legal constraints to a technical implementation.
- Access control design decisions have to be made by humans not technology and the potential for errors is high.
- Access controls can be divided into the following categories:
    1. Vertical access controls.
    2. Horizantal access controls.
    3. Context-dependent access controls.

### 1. Vertical access controls.
- Are mechanisms that restrict access to sensitive functionality that is not available to other types of users.
- Different types of users have access to different application functions.
- Can be more fine-grained implementations of security models designed to enforce business policies such as separation of duties and least privilege.

### 2. Horizontal access controls.
- Are mechanisms that restrict access to resources to the users who are specifically allowed to access those resources.
- Different users have access to a subset of resourves of the same type.
- For example, a banking application will allow a user to view transactions and make payments from their own accounts, but not the accounts of any other user. 

### 3. Context-dependent access controls.
- Restrict access to functionality and resources based upon the state of the application of the user's interaction with it.
- It prevents a user performing actions in the wrong order.
- For example, a retail website might prevent users from modifying the contents of their shopping cart after they have made payment. 

## Examples of broken access controls.
- Broken access control vulnerabilities exist when a user can in fact access some resources or perform some action that they are not supposed to be able to access.
### 1. `Vertical privilege escalation`
- If a user can gain access to functionality that they are not permitted to access then this is vertical privilege escalation.
### 2. `Unprotected functionality`
- At its most basic, vertical privilege escalation arises where an application does not enforce any protection over sensitive functionality.
- Eg administrative functions might be linked from an administrator's welcome page but not from a user's welcome page. However, a user might simply be able to access the administrative functions by browsing directly to the relevant admin URL.
- A website might host sensitive functionality at the following URL:
```
https://website.com/admin
```
- This might be accessible by any user, not only administrative users who have a link to the functionality in their user interface. In some cases the admin URL might be disclosed in other locations such as the `robots.txt` file:
```
https://website.com/robots.txt
```
- Even if the URL isn't disclosed anywhere, an attacker may be able to use a wordlist to brute-force the location of the sensitive functionality.
- Sensitive functionality is not robustly protected but is concealed by giving it a less predictable URL so called security by obscurity.
- Merely hiding sensitive functionality doesn't provide effective access control since users might still discover the obfuscated URL in various ways.
- Eg consider an application that hosts administrative functions at the following URL:
```
https://website.com/administrator-panel-yb556
```
- The application might still leak the URL to users. Eg the URL might be disclosed in JavaScript that constructs the user interface based on the user's role:
```
<script>
var isAdmin = false;
if (isAdmin){
    ...
    var adminPanelTag = document.createElement('a');
    adminPanelTag.setAttribute('http://website.com/administrator-panel-yb556');
    adminPanelTag.innerText = 'Admin panel';
    ...
}
</script>
```
- This script adds a link to the user's UI if they are an admin user. However the script containing the URL is visible to all users regardless of their role.

### 3. `Parameter-based access control methods`
- Some applications determine the user's access rights or role at login, and then store this informationin a user-controllable location such as a hiddent field, cookie, or preset query string parameter.
- The application makes subsequent access control decisions based on the submitted value. Eg:
```
https://website.com/login/home.jsp?admin=true
https://website.com/login/home.jsp?role=1
```
- This approach is fundamentally insecure because a user can simply modify the value and gain access to functionality to which they are not authorized, such as administrative functions.

### 4. `Broken access control resulting from platform misconfiguration`
- Some applications enforce access controls at the platform layer by restricting access to specific URLs and HTTP methods based on the user's role.
- Eg an application might configure rules like:
```
DENY: POST, /admin/deleteUser, managers
```
- This rule denies access to the `POST` method on the URL `/admin/deleteUser`, for users in the managers group therefore leading to access control bypass.
- Some application frameworks support various non-standard HTTP headers that can be used to override the URL in the original request such as `x-Original-URL` and `X-Rewrite-URL`.
- If a website uses rigorous front-end controls to restrict access based on the URL but the application allows the URL to be overridden via a request header, then it might be possible to bypass the access controls using a request like:
```
POST / HTTP/1.1
X-Original-URL: /admin/deleteUser
```
- The front-end controls above restrict access based on the URL and HTTP method. 
- Some web sites are tolerant of alternate HTTP request methods when performing an action.
- If an attacker can use the `GET` (or another) method to perform actions on a restricted URL, then they can circumvent the access control that is implemented at the platform layer. 

### 5. `Horizontal privilege escalation`
- Arises when a user is able to gain access to resources belonging to another user, instead of their own resources of that type.
- Horizontal privilege escalation attacks may use similar types of exploit methods to vertical privilege escalation.
- Eg a user might ordinarily access their own accountt page using a URL as below:
```
https://website.com/myaccount?id=123
```
- If an attacker modifies the `id` parameter value to that of another user, then the attacker might gain access to another user's account page with associated data and functions.
- In some applications, the exploitable parameter doesn't have a predictable value. Instead of an incrementing number, an application might use `globally unique identifiers(GUIDs)` to identify users.
- GUIDs belonging to other users might be disclosed elsewhere in the application where users are referenced such as user messages or reviews.
- In some cases, an application doesn't detect when the user is not permitted to access the resource, and returns a redirect to the login page. However, the response containing the redirect might still include some sensitive data belonging to the targeted user, so the attack is still successful.

### 6. `Horizontal to vertical privilege escalation`
- A horizontal privilege escalation attack can be turned into a vertical privilege escalation by compromising a more privileged user.
- It may allow an attacker to reset or capture the password belonging to another user.
- If the attacker targets and administrative user and compromises their account, then they can gain administrative access and so perform vertical privilege escalation.
- An attacker might be able to gain access to another user's account page using the parameter tampering technique already described for horizontal privilege escalation:
```
https://website.com/myaccount?id=457298
```
- If the target user is an application administrator, then the attacker will gain access to an administrative account page.

### 7. `Insecure direct object references(IDOR)`
- Arises when an application uses user-supplied input to access objects directly and an attacker can modify the input to obtain unauthorized access.
- IDOR vulnerabilities are most commonly associated with horizontal privilege escalation, but they can also arise in relation to vertical privilege escalation.
###### `IDOR Vulnerability with direct reference to database objects.`
  - Consider the website that uses the following URL to access the customer account page by retrieving information from the backend database:
```
https://website.com/customer_account?customer_number=13294385
```
  - The customer number is used directly as a record index in queries that are performed on the back-end of the database.
  - If no other controls are in place, an attacker can simply modify  the `customer_number` value, bypassing access controls to view the records of other customers.
  - An attacker might be able to perform horizontal and vertical privilege escalation by altering the user to one with additional privileges while bypassing access controls.
  - Other possibilities include exploiting password leakage or modifying parameters once the attack has landed in the user's accounts page;
###### `IDOR vulnerability with direct reference to static files`
  - IDOR vulnerabilities often arise when sensitive resources are located in static files on the server-side filesystem.
  - A website might save chat message transcripts to disk using an incrementing filename and allow users to retrieve these by visiting a URL like the following:
```
https://website.com/static/123242.txt
```
  - An attacker can simply modify the filename to retrieve a transcript created by another user and potentially obtain user credentials and other sensitive data.

### 8. `Access control vulnerabilities in multi-step processes`
- Many websites implement important functions over a series of steps often done when a variety of inputs or options need to be captured, or when the user needs to review and confirm details before the action is performed.
- Eg, admin function to update user details might involve the following steps:
    1. Load form containing details for a specific user.
    2. Submit changes.
    3. Revied the changes and confirm.
- Sometimes, a website will implement rigorous access controls over some of these steps but ignore others.

### 9. `Referer-based access control`
- Some websites base access controls on the `Referer` header submitted in the HTTP request.
- The `Referer` header is generally added to requests by browsers to indicate the page from which a request was initiated.
- Eg an application robustly enforces access control over the main administrative page at `/admin` but for subpages such as `/admin/deleteUser` only inspects the `Referer` header. If the Referer header contains the main `/admin` URL then the request is allowed.
- Since the `Referer` header can be fully controlled by an attacker, they can forge direct requests to sensitive sub-pages, supplying the required `Referer` header, and so gain unauthorized access.

### 10.`Location-based access control`
- Some websites enforce access controls over resources based on the user's geographical location.
- This can apply to banking applications or media services where state legislation or business restrictions apply.
- These access controls can often be circumvented by the user of web proxies, VPNs or manipulation of client-side geolocation mechanisms.

--------------------------------------------------------------------------------

## How to prevent access control vulnerabilities.
- Access control vulnerabilities can generally be prevented by taking a defense-in-depth approach and applying the following principles:
    1. Never rely on obfuscation alone for access control.
    2. Unless a resource is intended to be publicly accessible, deny access by default.
    3. Wherever possible, use a single application-wide mechanism for enforcing access controls.
    4. At the code level, make it mandatory for developers to declare the access that is allowed for each resource, and deny access by default.
    5. Thoroughly audit and test access controls to ensure they are working as designed.

--------------------------------------------------------------------------------

## Access control security models
> An access control security model is a formally defined definition of a set of access control rultes that is independent of technology or implementation platform.
- Are implemented within operating systems, networks, database management systems and back office, application and web server software.

### `Programmatic access control(PAC)`
- With PAC, a control matrix of user privileges is stored in a database or similar and access controls are applied programmatically with reference to this matrix.
- This approach to access control can include roles or groups or individual users, collections or workflows of processes and can be highly granular.

### `Discretionary access control(DAC)`
- With DAC, access to resources or functions is constrained based upon users or named groups of users.
- Owners of resources or functions have the ability to assign or delegate access permissions to users.
- This model is highly granular with access rights defined to an individual resource or function and user.

### `Mandatory access control(MAC)`
- MAC is a centrally controlled system of access conrol in which access to some object(a file or other resource) by a subject is constrained.
- Unlike DAC the users and owners of resources have no capability to delegate or modify access rights for their resources.
- This model is often associated with military clearance-based systems.

### `Role-based access control(RBAC)`
- With RBAC, named roles are defined to which access privileges are assigned.
- RBAC provides enhanced management over other access control models and if properly designed sufficient granularity to provide manageable access control in complex applications.
- RBAC is most effective when there are sufficient roles to properly invoke access controls but not so many as to make the model excessively complex and unwieldy to manage.

--------------------------------------------------------------------------------
# MATERIALS
### Referencing
* [PortSwigger - Access Controls](https://portswigger.net/web-security/access-control)
* [PortSwigger - IDOR](https://portswigger.net/web-security/access-control/idor)
* [PortSwigger - Access control security models](https://portswigger.net/web-security/access-control/security-models)

### Labs
* [Unprotected admin functionality](https://portswigger.net/web-security/access-control/lab-unprotected-admin-functionality)
* [Unprotected admin functionality with unpredictable URL](https://portswigger.net/web-security/access-control/lab-unprotected-admin-functionality-with-unpredictable-url)
* [User role controlled by request parameter](https://portswigger.net/web-security/access-control/lab-user-role-controlled-by-request-parameter)
* [User role can be modified in user profile](https://portswigger.net/web-security/access-control/lab-user-role-can-be-modified-in-user-profile)
* [URL-based access control can be circumvented](https://portswigger.net/web-security/access-control/lab-url-based-access-control-can-be-circumvented)
* [Method-based access control can be circumvented](https://portswigger.net/web-security/access-control/lab-method-based-access-control-can-be-circumvented)
* [User ID controlled by request parameter ](https://portswigger.net/web-security/access-control/lab-user-id-controlled-by-request-parameter)
* [User ID controlled by request parameter, with unpredictable user IDs ](https://portswigger.net/web-security/access-control/lab-user-id-controlled-by-request-parameter-with-unpredictable-user-ids)
* [User ID controlled by request parameter with data leakage in redirect ](https://portswigger.net/web-security/access-control/lab-user-id-controlled-by-request-parameter-with-data-leakage-in-redirect)
* [Multi-step process with no access control on one step ](https://portswigger.net/web-security/access-control/lab-multi-step-process-with-no-access-control-on-one-step)
* [Referer-based access control](https://portswigger.net/web-security/access-control/lab-referer-based-access-control)
* [Insecure direct object references](https://portswigger.net/web-security/access-control/lab-insecure-direct-object-references)
