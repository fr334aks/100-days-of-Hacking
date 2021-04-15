# XML External Entity(XXE) Injection
> Is a web security vulnerability that allows an attacker to interfere with an application's processing of XML data.
- It often allows an attacker to view files on the application server filesystem, and to interact with any back-end or external systems that the application itself can access.
- An attacker can escalate an XXE attack to compromise the underlying server or other back-end infrastructure, by leveraging the XXE vulnerability to perform SSRF attacks.

## XML entities
- XML stands for **Extensible Markup Language**
> XML is a language designed for storing and transporting data.
- XML uses a tree-like structure of tags and data.
- XML doesn't use predefined tags and so tags can be given names that describe the data.
- xml entities are a way of representing an item of data within an XML document, instead of using the data itself.
- Various entities are built in to the specification of the XML language.
- The entities `&lt;` and `&gt;` represents the characters `<`and `>`.
- These are metacharacters used to denote XML tags and so must generally be represented using their entities when they appear within data.
####  `XML Document Type Definition`
- XML DTD contains declarations that can define the structure of an XML document, the types of data values it can contain, and other items.
- The DTD is declared within the optional `DOCTYPE` element at the start of the XML document.
- The DTD can be fully self-contained within the document itself(internal DTD) or can be loaded from elsewhere(external DTD) or can be hybrid of the two.
#### `XML custom entities`
- XML allows custom entities to be defined within the DTD. eg:
```
<!DOCTYPE foo [ <!ENTITY myentity "my entity value"> ]>
```
- This means that any usage of the entity reference `&myentity;` within the XML document will be replaced with the defined value: `"my entity value"`
#### `XML external entities`
- Are a type of custom entity whose definition is located outside of the DTD where they are declared.
- The declaration of an external entity uses the `SYSTEM` keyword and must specify a URL from which the value of the entity should be loaded. eg:
```
<!DOCTYPE foo [ <!ENTITY ext SYSTEM "http://website.com"> ]>
```
- The URL can use the `file://` protocol and so external entities can be loaded from file. eg
```
<!DOCTYPE foo [ <!ENTITY ext SYSTEM "file:///path/to/file" > ]> 
```
- XML external entities provide the primary means by which XML external entity attacks.

## Arising of XXE vulnerabilities
- XXE vulnerabilities arise because the XML specification contains various potentially dangerous features, and standard parsers support these features even if they are not normally used by the application.
- XML external entities defined values are loaded from outside of the DTD in which they are declared.
- External entities are particularly interesting from a security perspective because they allow an entity to be defined based on the contents of a file path or URL.

## Types of XXE attacks
1. Exploiting XXE to retrieve files
  - An external entity is defined containing the contents of a file, and returned in the application's response. 
2. Exploiting XXE to perform SSRF attacks
  - An external entity is defined based on a URL to a back-end system.
3. Exploiting blind XXE exfiltrate data out-of-band
  - Sensitive data is transmitted from the application server to a system that the attacker controls. 
4. Exploiting blind XXE to retrieve data via error messages
  - The attacker can trigger a parsing error message containing sensitive data. 
  
## Exploiting XXE to retrieve files
- To perform an XXE injection attack that retrieves an arbitrary file from the server's filesystem, you need to modify the submitted XML in two ways:
  1. Introduce(or edit) a `DOCTYPE` element that defines an external entity containing the path to the file.
  2. Edit a data value in the XML that is returned in the application's response, to make use of the defined external entity.
- Eg, suppose a shopping application checks for the stock level of a product by submitting the following XML to the server:
```
<?xml version="1.0" encoding="UTF-8"?>
<stockCheck><productId>381</productId></stockCheck>
```
- The application performs no particular defenses against XXE attacks, so you can exploit the XXE vulnerability to retrieve the `/etc/passwd` file by submitting the following XXE payload:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<stockCheck><productId>&xxe;</productId></stockCheck>
```
- This XXE payload defines an external entity `&xxe;` whose value is the contents of the `/etc/passwd` file and uses the entity within the `productId` value.
- This causes the application's response to include the contents of the file:
```
Invalid product ID: root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
```

## Exploiting XXE to perform SSRF attacks
- Aside from retrieval of sensitive data, the other main impact of XXE attacks is that they can be used to perform server-side request forgery(SSRF).
- This is a potentially serious vulnerability in which the server-side application can be induced to make HTTP requests to any URL that the server can access.
- To exploit an XXE vulnerability to perform an SSRF attack, define an XML entity using the URL that you want to target and use the defined entity within a data value.
- If you can use the defined entity within a data value that is returned in the application's response, then you will be able to view the response from the URL within the application's response, and so gain two-way interaction with the back-end system else you will only be able to perform blind SSRF attacks.

## Blind XXE Vulnerabilities
- The application doesn't return the values of any defined external entities in its responses, and so direct retrieval of server-side files is not possible.
- Blind XXE vulnerabilities can still be detected and exploited but more advanced techniques are required.
- You can use OAST techniques to find vulnerabilities and exploit them to exfiltrate data and sometimes trigger XML parsing errors that lead to disclosure of sensitive data within error messages.

## Finding hidden attack surface for XXE injection
- Attack surface for XXE injection vulnerabilities is obvious because the application's normal HTTP traffic includes requests that contain data in XML format.
- Looking at the right places one can find XXE attack surface in requests that don't contain any XML.
### `XInclude attacks`
- Some applications receive client-submitted data, embed it on the server-side into an XML document, and then parse the document. Eg when client-submitted data is placed into a back-end SOAP request, which is then processed by the backend SOAP service.
- In this situation, you cannot carry out a classic XXE attack, because you don't control the entire XML document and so cannot define or modify a `DOCTYPE` element, however, you might be able to use `XInclude` instead.
- `XInclude` is a part of the XML specification that allows an XML document to be built from subdomains
- Performing an `XInclude` attack, you need to reference the `XInclude` namespace and provide the path to the file that you wish to include, eg:
```
<foo xmlns:xi="http://www.w3.org/2001/XInclude">
<xi:include parse="text" href="file:///etc/passwd"/></foo>
```
### `XXE attacks via file upload`
- Some applications allow users to upload files which are then processed server-side.
- Some common file formats use XML or contain XML subcomponents.
- Eg of XML-based formats are office document formats like `DOCX` and image formats like `SVG`

### `XXE attacks via modified content type`
- POST requests use a default content type that is generated by HTML forms, such as `application/x-www-form-urlencoded`.
- Some websites expect to receive requests in this format but will tolerate other content types including XML.
- Eg if a normal request contains the following:
```
POST /action HTTP/1.0
Content-Type: application/x-www-form-urlencoded
Content-Length: 7

foo=bar
```
Then you might be able to submit the following request with the same result:
```
POST /action HTTP/1.0
Content-Type: text/xml
Content-Length: 52

<?xml version="1.0" encoding="UTF-8"?><foo>bar</foo>
```
If the applicaton tolerates requests containing XML in the message body and parses the body content as XML, then you can reach the hidden XXE attacl surface simply by reformatting requests to use the XML format.

## Finding and Testing XXE vulnerabilities.
- Majority of XXE vulnerabilities can be found quickly and reliably using Burp Suite's web vulnerability scanner.
- Manually testing for XXE vulnerabilities generally involves:
  1. Testing for `file retrieval` by defining an external entity based on a well-known operating system file and using that entity in data that is returned in the application's response.
  2. Testing for `blind XXE vulnerabilities` by defining an external entity based on a URL to a system that you control, and monitoring for interactions with that system. Burp collaborator client is perfect for this purpose.
  3. Testing for vulnerable inclusion of user-supplied non-XML data within a server-side XML document by using an `XInclude attack` to try to retrieve a well-known operating system file.
  
## How to prevent XXE vulnerabilities
- Virtually all XXE vulnerabilities arise because the application's XML parsing library supports potentially dangerous XML features that the application doesn't need or intend to use.
- Easiest and most effective way to prevent XXE attacks is to disable those features.
- This can be done via configuration options or by programmatically overriding default behavior.

--------------------------------------------------------------------------------
## Materials
### Reference
- [PortSwigger](https://portswigger.net/web-security/xxe)

### Labs
- [Exploiting XXE using external entities to retrieve files](https://portswigger.net/web-security/xxe/lab-exploiting-xxe-to-retrieve-files)
- [Exploiting XXE to perform SSRF attacks](https://portswigger.net/web-security/xxe/lab-exploiting-xxe-to-perform-ssrf)
- [Exploiting XInclude to retrieve files](https://portswigger.net/web-security/xxe/lab-xinclude-attack)
- [Exploiting XXE via image file upload](https://portswigger.net/web-security/xxe/lab-xxe-via-file-upload)
