# TESTING FOR WEBSOCKETS SECURITY VULNERABILITIES
  > WebSockets are a bi-directional, full duplex communication protocol initiated over HTTP.
- They are initiated over HTTP and provide long-lived connections with asynchronous communication in both directions.
- Virtually, any web security vulnerability that arises with regular HTTP can also arise in relation to WebSockets communications.

## Difference between HTTP and WebSockets
- Most communication between web browsers and websites uses HTTP, whereby the client sends a request and the server returns a response.
- WebSocket connections are initiated over HTTP and are typically long-lived, messages can be sent in either direction at any time and are not transactional in nature. Connection stays open and idle until either the client or the server is ready to send a message.
- WebSockets are particularly useful in situations where low-latency or server initiated messages are required.

## Establishing WebSocket connections
- WebSockets are normally created using client-side JavaScript as below:
```
var ws = new WebSocket(wss://normal-website.com/chat)
```
> The `wss` protocol establishes a WebSocket over an encrypted TLS connection, while the `ws` protocol uses an unencrypted connection.
- To establish the connection, the browser and server perform a WebSocket handshake over HTTP.
- The browser issues a WebSocket handshake request like the following:
```
GET /chat HTTP/1.1
Host: normal-website.com
Sec-WebSocket-Version: 13
Sec-WebSocket-Key: wDq mtseNBJdhkihL6PW7w==
Connection: keep-alive, Upgrade
Cookie: session=KOsEJNuflw4Rd9BDNrVmvwBF9rEijeE2
Upgrade: websocket
```
- If the server accepts the connection, it returns a WebSocket handshake response as below:
```
HTTP/1.1 101 Switching Protocols
Connection: Upgrade
Upgrade: websocket
Sec-WebSocket-Accept: 0FFP+2nmNIf/h+4BP36k9uzrYGk=
```
- At this point, the network connection remains open and can be used to send WebSocket messages in either direction.
`Observations:`
   1. The Connection and Upgrade headers in the request and response indicate that this is a WebSocket handshake. 
   2. The Sec-WebSocket-Version request header specifies the WebSocket protocol version that the client wishes to use. This is typically 13 and is not a vulnerable parameter. 
   3. The Sec-WebSocket-Key request header contains a Base64-encoded random value, which should be randomly generated in each handshake request. This header is not the one which uniquely identifies a user or can be used for authorization purposes. 
   4. The Sec-WebSocket-Accept response header contains a hash of the value submitted in the Sec-WebSocket-Key request header, concatenated with a specific string defined in the protocol specification. This is done to prevent misleading responses resulting from misconfigured servers or caching proxies. 
   5. The wss protocol establishes a WebSocket over an encrypted TLS connection, while the ws protocol uses an unencrypted connection. So if the server is accepting connections from ws protocol it is vulnerable to MITM attacks. 
   6. This protocol doesn’t prescribe any particular way that the servers can authenticate clients during the WebSocket handshake. The WebSocket server can use any client mechanism available to a generic HTTP server, such as cookies, HTTP authentication, or TLS authentication.
- WebSockets don't follow same-origin-policies.

## Manipulating WebSocket traffic
- You can use this using Burp Suite to do the following:
  1. Intercepting and modifying WebSocket messages.
  2. Replaying and generating new WebSocket messages.
  3. Manipulating WebSocket connections

## WebSocket security vulnerabilities.
- Any web security might arise in relation to WebSockets:
  1. User-supplied input transmitted to the server might be processed in unsafe ways, leading to vulnerabilities such as SQLi or XML external entity injection.
  2. Some blind vulnerabilities reached via WebSockets might only be detectable using **OAST techniques**
  3. If attacker-controlled data is transmitted via WebSockets to other application users, then it might lead to XSS or other client-side vulnerabilities.

## Manipulating WebSocket messages to exploit vulnerabilities
- The majority of input-based vulnerabilities affecting WebSockets can be found and exploited by tampering with the contents of WebSocket messages.
- An attacker can perform a proof-of-concept XSS attack by submitting the following WebSocket message:
```
{"message":"<img src=1 onerror='alert(1)'>"}
```
## Manipulating the WebSocket handshake to exploit vulnerabilities
- These vulnerabilites involve design flaws such as:
  1. Misplaced trust in HTTP headers to perform security decisions such as the `X-Forwarded-For` header.
  2. Flaws in session handling mechanisms, since the session context in which WebSocket messages are processed is generally determined by the session context of the handshake message.
  3. Attack surface by custom HTTP headers used by the application.

## Using cross-site WebSockets to exploit vulnerabilities
- Some WebSockets security vulnerabilities arise when an attacker makes a cross-domain WebSocket connection from a website that the attacker controls known as a **cross-site Web Socket hijacking** attack and it involves exploiting a **CSRF** vulnerability on a WebSocket handshake.
- Attack allows an attacker to perform privileged actions on behalf of the victim user or capture sensitive data to which user has access.

## Impact of cross-site WebSocket hijacking
- A successful cross-site WebSocket hijacking attack will often enable an attacker to:
  1. Perform unauthorized actions masquerading as the victim user.
  2. Retrieve sensitive data that the user can access.

## Securing a WebSocket Connection
- To minimize the risk of security vulnerabilities arising with WebSockets, use the following:
  1. Use the `wss://` protocol (WebSockets over TLS).
  2. Hard code the URL of the WebSockets endpoint and certainly don't incorporate user-controllable data into this URL.
  3. Protect the WebSocket handshake message against CSRF, to avoid cross-site WebSockets hijacking vulnerabilities.
  4. Treat data received via the WebSocket as untrusted in both directions. Handle data safely on both the server and client ends, to prevent input-based vulnerabilities such as SQLi and XSS.

--------------------------------------------------------------------------------
# MATERIALS
## Referencing
- [PortSwigger - WebSockets](https://portswigger.net/web-security/websockets)
- [appknox](https://www.appknox.com/blog/everything-you-need-to-know-about-web-socket-pentesting)

## Labs
- [Manipulating WebSocket messages to exploit vulnerabilities](https://portswigger.net/web-security/websockets/lab-manipulating-messages-to-exploit-vulnerabilities)
- [Manipulating the WebSocket handshake to exploit vulnerabilities](https://portswigger.net/web-security/websockets/lab-manipulating-handshake-to-exploit-vulnerabilities)
- [Cross-site WebSocket hijacking](https://portswigger.net/web-security/websockets/cross-site-websocket-hijacking/lab)
