# CLICKJACKING (UI redressing)
> Is an interface-based attack in which a user is tricked into clicking on actionable content on a hidden website by clicking on some other content in a decoy website.
- example: A web user accesses a decoy website (perhaps this is a link provided by an email) and clicks on a button to win a prize. Unknowingly, they have been deceived by an attacker into pressing an alternative hidden button and this results in the payment of an account on another site leading to a clickjacking attack.
- The technique depends upon the incorporation of an invisible, actionable web page or multiple pages containing a button or hidden links even within an iframe.
- The iframe is overlaid on top of the user's anticipated decoy web page content.
- This attack differs from a CSRF attack in that the user is required to perform an action such as a button click whereas a CSRF attack depends upon forgin an entire request without the user's knowledge or input.
- Clickjacking attacks are not mitigated by the CSRF token as a target session is established with content loaded from an authentic website and with all requests happening on-domain.

## Constructing a basic clickjacking attack
- Clickjacking attacks use CSS to create and manipulate layers. The attacker incorporates the target website as an ifram layer overlaid on the decoy website.
- An example using the style tag is as below:
```
<head>
  <style>
    #target_website {
      position:relative;
      width:128px;
      height:128px;
      opacity:0.00001;
      z-index:2;
      }
    #decoy_website {
      position:absolute;
      width:300px;
      height:400px;
      z-index:1;
      }
  </style>
</head>
...
<body>
  <div id="decoy_website">
  ...decoy web content here...
  </div>
  <iframe id="target_website" src="https://vulnerable-website.com">
  </iframe>
</body>
```
- Target ifram is positioned within the browser so that there is a precise overlap of the target action with the decoy website using appropriate width and height position values.
- Absolute and relative position values are used to ensure that the target website accurately overlaps the decoy regardless of screen size, browser type and platform.
- The opacity value is defined as 0.0 or close to 0.0 so that the iframe content is transparent to the user.
- The attacker selects opacity values so that the desired effect is achieved without triggering protection behaviors.

## Clickjacking with prefilled form input.
- Some websites that require form completion and submission permit prepopulation of form inputs using GET parameters prior to submission while others might require text before form submission.
- As GET values form part of the URL then the target URL can be modified to incorporate values of the attacker's choosing and the transparent "submit" button is overlaid on the decoy site as in the basic clickjacking example.

## Frame busting scripts
- Clickjacking attacks are possible whenever websites can be framed.
- Preventive techniques are based upon restricting the framing capability for websites. A common client-side protection enacted through the web browser is to use frame busting or frame breaking scripts.
- These can be implemented via proprietary browser JavaScript add-ons or extensions such as `NoScript`.
- Scripts are often crafted so that they perform some or all of the following behaviors.
  1. Check and enforce that the current application window is the main or top window.
  2. Make all frames visible.
  3. Prevent clicking on invisible frames.
  4. Intercept and flag potential clickjacking attacks to the user.
- Frame busting techniques are often browser and often browser and platform specific and because of the flextibility of HTML they can usually be circumvented by attacker.
- An effective attacker workaround against frame busters is to use the HTML5 iframe `sandbox` attribute.
- When set with the `allow-forms` or `allow-scripts` values and the `allow-top-navigation` value is omitted then the fram buster script can be neutralized as the ifram cannot check whether or not it is the top window:

## Combining clickjacking with a DOM XSS attack
- Clickjacking has been used to perform behaviors such as boosting *likes* on a facebook page.
- The true potency of clickjacking is revealed when it is used as a carrier  for another attack such as a DOM XSS attack.
- Implementation of this combined attack is relatively straightforward assuming that the attacker has first identified the XSS exploit afterwhich it is then combined with the iframe target URL so that the user click on the button or link and consequently executes the DOM XSS attack

## Multistep clickjacking
- Attacker manipulation of inputs to a target website may necessitate multiple actions.
- An attacker might want want to trick a user into buying something from a retail website so items need to be added to a shopping basket before the order is placed.
- These actions can be implemented by the attacker using multiple divisions or iframes.
- Such attacks require considerable precision and care from the attacker perspective if they are to be effective and stealthy.

## Preventing clickjacking attacks
- Server driven protocols have been devised that constrain browser iframe usage and mitigate clickjacking.
- Clickjacking is a browser-side behavior and its success or otherwise depends on browser functionality and conformity to prevailing web standards and best practice.
- Server-side protection against clickjacking is provided by defining communicating constraints over the use of components such as iframes.
- Implementation of protection depends upon browser compliance and enforcement of these constraints.
- The two mechanisms for server-side clickjacking protection are:
   1. `X-Frame-Options`
   - The header provides the website owner with control over the use of iframes or objects so that inclusion of a web page within a frame can be prohibited with the `deny` directive: 
```
X-Frame-Options: deny
```
  - Alternatively, framing can be restricted to the same origin as the website using the sameorigin directive
```
X-Frame-Options: sameorigin
```
  - or to a named website using the allow-from directive:
```
X-Frame-Options: allow-from https://normal-website.com
```
   2. CSP
   > Content Security Policy (CSP) is a detection and prevention mechanism that provides mitigation against attacks such as XSS and clickjacking.
   - CSP is usually implemented in the web server as a return header of the form:
```
Content-Security-Policy: policy 
```
  - The following CSP whitelists frames to the same domain only:
```
Content-Security-Policy: frame-ancestors 'self';
```
  - Alternatively, framing can be restricted to named sites:
```
Content-Security-Policy: frame-ancestors normal-website.com; 
```
  - To be effective against clickjacking and XSS, CSPs need careful development, implementation and testing and should be used as part of a multi-layer defense strategy. 
--------------------------------------------------------------------------------
# MATERIALS
## Referencing
- [PortSwigger - Clickjacking](https://owasp.org/www-community/attacks/Clickjacking)
- [OWASP](https://portswigger.net/web-security/clickjacking)

## Labs
- [Basic clickjacking with CSRF token protection](https://portswigger.net/web-security/clickjacking/lab-basic-csrf-protected)
- [Clickjacking with form input data prefilled from a URL parameter](https://portswigger.net/web-security/clickjacking/lab-prefilled-form-input)
- [Clickjacking with a frame buster script](https://portswigger.net/web-security/clickjacking/lab-frame-buster-script)
- [Exploiting clickjacking vulnerability to trigger DOM-based XSS](https://portswigger.net/web-security/clickjacking/lab-exploiting-to-trigger-dom-based-xss)
- [Multistep clickjacking](https://portswigger.net/web-security/clickjacking/lab-multistep)
