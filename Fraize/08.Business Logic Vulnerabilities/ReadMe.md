# Business Logic Vulnerabilities - Examples

- Logic flaws can be loosely grouped based on the initial mistakes that introduced the vulnerability in the first place.
- Examples of logic flaws include:
## 1. Excessive trust in client-side controls.
- A fundamentally flawed assumption is that users will only interact with the application via the provided web interface. This can lead to further assumption that client-side validation will prevent users from supplying malicious input.
- An attacker can simply use tools such as `Burp Proxy` to tamper with data after it has been sent by the browser but before it is passed into the server-side logic rendering the client-side controls useless.
- Accepting data at face value without performing proper integrity checks and server-side validation can allow an attacker to perform all kinds of damage with relatively minimal effort.
- What one is able to achieve is dependent on the functionality and what it is doing with the controllable data.
- This kind of flaw can have devastating consequences for both business-related functionality and the security of the website itself.

## 2. Failing to handle unconventional input.
- An aim of the application logic is to restrict user input to values that adhere to the business rules.
- Example: the application may be designed to accept arbitrary values of a certain data type but the logic determines whethher or not this value is acceptable from the perspective of the business.
- Many applications incorporate numeric limits into their logic which may include limits designed to manage inventory, apply budgetary restrictions, trigger phases of the supply chain among many more.
- Developers need to anticipate all possible scenarios and incorporate ways to handle them into the application logic ie tell the application whether it should allow a given input and how it should react based on various conditions.
- If there is no explicit logic for handling a given case, this can lead to unexpected and potentially exploitable behaviour.
- If an application doesn't perform adequate server-side validation and reject an input, an attacker may be able to pass in a negative value and induce unwanted behavior.
- Example:
> Consider a funds transfer between two bank accounts. This functionality will almost certainly check whether the sender has sufficient funds before completing the transfer:
```
$transferAmount = $_POST['amount'];
$currentBalance = $user->getBalance();

if ($transferAmount <= $currentBalance){
    //complete the transfer
}
else{
    //Block the transfer:insufficient funds
}
```
> If the logic doesn't prevent users from supplying a negative value in the `amount` parameter, this could be exploited by an attacker to both bypass the balance check and transfer funds in the "wrong" direction. If the attacker sent -1000USD to the victim's account, this might result in them receiving 1000USD from the victim instead.
> The logic would always evaluate that -1000 is less than the current balance and approve the transfer.
- Simple logic flaws like above are easy to miss during both development and testing especially given that such inputs may be blocked by client-side controls on the web interface.
- When auditing an application, use tools like `Burp Proxy` and `Repeater` to try submitting unconventional values such as values that legitimate users are unlikely to ever enter such as exceptionally high or low numeric inputs. By observing the application's response one should be able to answer:
        1. Are there any limits that are imposed on the data?
        2. What happens when you reach those limits?
        3. Is any transformation or normalization being performed on your input?
- This may expose weak input validation that allows you to manipulate the application in unusual ways.

## 3. Making flawed assumptions about user behavior.
- This is one of the most common root causes of logic vulnerabilities.
- This can lead to a wide range of issues where developers have not considered potentially dangerous scenarios that violate these assumptions.

  a. `Trusted users won't always remain trustworthy.`
    - Applications may appear to be secure because they implement seemingly robust measures to enforce the business rules.
    - Some applications make the mistake of assuming that having passed the strict controls initially, the user and their data can be trusted indefinitely resulting in relatively lax enforcement of the same controls from that point on.
    - If business rules and security measures are not applied consistently throughout the application, this can lead to potentially dangerous loopholes that may be exploited.
        
  b. `Users won't always supply mandatory input`
    - Browsers may prevent ordinary users from submitting a form without a required input but attackers can tamper with parameters in transit.
    - This is a particular issue in cases where multiple functions are implemented within the same server-side script.
    - The presence or absence of a particular parameter may determine which code is executed. Removing parameter values may allow an attacker to access code paths that are supposed to be out of reach.
    - When probing for logic flaws, try removing each parameter in turn and observing what effect this has on the response.
    - Make sure to:
        1. Only remove one parameter at a time to ensure all relevant code paths are reached.
        2. Try deletting the name of the parameter as well as the value.
        3. Follow multi-stage processes through to completion. Sometimes tampering with a parameter in one step will have an effect on another step further along in the workflow.
    - This applies to both `URL` and `POST` parameters and `cookies` too.
        
  c. `Users won't always follow the intended sequence.`
    - Many transactions rely on predefined workflows consisting of a sequence of steps.
    - Attackers won't necessarily adhere to this intended sequence and failing to account for this possibility can lead to dangerous flaws that may be relatively simple to exploit.
    - Example, many websites that implement 2FA require users to log in on one page before entering a verification code on a separate page. Assuming that users will always follow this process through to completion and, as a result, not verifying that they do, may allow attackers to bypass the 2FA step entirely.
    - Making assumptions about the sequence of events can lead to a wide range of issues even within the same workflow or functionality.
    - Using tools like `Burp Proxy` and `Repeater`, once an attacker has seen a request, they can replay it at will and use forced browsing to perform any interactions with the server in any order they want allowing them to complete different actions while the application is in an unexpected state.
    - This kind of testing will often cause exceptions because expected variables have null or uninitialized values.
    - Pay close attention to any error messages or debug information encountered as it can be a valuable source of information disclosure which can help you fine-tune an attack and understand key details about the back-end behaviour.

## 4. Domain-specific flaws.
- The discounting functionality of online shops is an attack surface when hunting for logic flaws and can be a gold mine for an attacker with all kinds of basic logic flaws occurring in the way discounts are applied.
- Pay attention to any situation where prices or other sensitive values are adjusted based on criteria determined by user actions.
- Understand what algorithms the application uses to make these adjustments and at what point these adjustments are made. Often involves manipulating the application so that it is in a state where the applied adjustments don't correspond to the original criteria intended by the developers.
- Read as much documentation as possible and where available, talk to subject-matter experts from the domain to get their insight. May be alot of work but the more obscure the domain is, the more likely other testers will have missed plenty of bugs.

## 5. Providing an encryption oracle.
- Dangerous scenarios can occur when user-controllable input is encrypted and the resulting ciphertext is then made available to the user in some way. This kind of input is known as an `encryption oracle`.
- An attacker can use this input to encrypt arbitrary data using the correct algorithm and assymmetric key.
- An attacker can potentially use the encryption oracle to generate valid, encrypted input and then pass it into other sensitive functions.
- The severity of an encryption oracle depends on what functionality also uses the same algorithm as the oracle.

--------------
# Materials
#### Referencing
* [PortSwigger](https://portswigger.net/web-security/logic-flaws/examples)

#### Labs
* [Excessive trust in client-side controls](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-excessive-trust-in-client-side-controls)
* [2FA broken logic](https://portswigger.net/web-security/authentication/multi-factor/lab-2fa-broken-logic)
* [High-level logic vulnerability](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-high-level)
* [Low-level logic flaw](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-low-level)
* [Inconsistent handling of exceptional input](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-inconsistent-handling-of-exceptional-input)
* [Inconsistent security controls](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-inconsistent-security-controls)
* [Weak isolation on dual-use endpoint](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-weak-isolation-on-dual-use-endpoint)
* [Password reset broken logic](https://portswigger.net/web-security/authentication/other-mechanisms/lab-password-reset-broken-logic)
* [2FA simple bypass](https://portswigger.net/web-security/authentication/multi-factor/lab-2fa-simple-bypass)
* [Insufficient workflow validation](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-insufficient-workflow-validation)
* [Authentication bypass via flawed state machine](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-authentication-bypass-via-flawed-state-machine)
* [Flawed enforcement of business rules](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-flawed-enforcement-of-business-rules)
* [Infinite money logic flaw](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-infinite-money)
* [Authentication bypass via encryption oracle](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-authentication-bypass-via-encryption-oracle)
