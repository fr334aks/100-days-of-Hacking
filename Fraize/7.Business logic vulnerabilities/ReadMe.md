# Business Logic Vulnerabilities

> `Business logic vulnerabilities` are flaws in the design and implementation of an application that allow an attacker to elicit unintended behaviour.
- Business logic vulnerabilities are ways of using the legitimate processing flow of an application in a way that results in a negative consequence to the organization.
- `Business logic` refers to the set of rules that define how the application operates.
- Logic flaws are often invisible to people who aren't explicitly looking for them as they typically won't be exposed by normal use of the application, however one may be able to exploit behavioural quirks by interacting with the appliaction in ways that developers never intended.
- Main  purpose of business logic is to enforce the rules and constraints that were defined when designing the application or functionality.
- BUsiness rules dictate how the application should react when a given scenario occurs such as preventing users from doing things that will have a negative impact on the business of that simply don't make sense.
- Logic-based vulnerabilities can be extremely diverse and are often unique to the application and its specific functionality.
- Identifying them often requires a certain amount of human knowledge such as an understanding of the business domain or what goals an attacker might have in a given context making them difficult to detect using automated vulnerable scanners.
> Logic flaws are a great target for bug bounty hunters and manual testers in general.

### Arising of business logic vulnerabilities.
- Often arise because the design and development teams make flawed assumptions about how users will interact with application.
- These bad assumptions can lead to inadequate validation of user input.
- When an attacker deviates from the expected user behavior, the application fails to take appropriate steps to prevent this and subsequently  fails to handle the situation safely.
- Logic flaws are common in overly complicated systems that even the development team themselves don't fully understand.
- To avoid logic flaws the devs need to understand the application as a whole.
- If the developers don't explicitly document any assumptions that are being made, it is easy for these kind of vulnerabilities to creep into an application.

### Impact of business logic vulnerabilities.
- Any unintended behaviour can potentially lead to high-severity attacks if an attacker is able to manipulate the application in the right way.
- The impact of any logic flaw dependds on what functionality it is related to.
- If the flaw, for example, is in the authentication mechanism, this could have serious impact on overall security and attackers could potentially exploit this for privilege escalation  or to bypass authentication entirely, gaining access to sensitive data and functionality.
- Flawed logic in financial transactions can obviously lead to massive losses for the business through stolen funds, fraud etc.
- Logic flaws may not allow an attacker to benefit directly, they could still allow malicious party to damage the business in some way.

### How to prevent business logic vulnerabilities.
- Main keys to preventing business logic vulnerabilities are to:
    1. Make sure developers and testers understand the domain that the application serves.
    2. Avoid making implicit assumptions about user behavior or the behaviour of other parts of the application.
    
- Identify what assumptions you have made about the server-side state and impliment the necessary logic to verify that these assumptions are met.
- Make sure that both the developers and testers are able to fully understand these assumptions and how the application is supposed to react in different scenarios as it can help the team to spot logic flaws as early as possible.
- The development team should adhere to the following best practices wherever possible:
    1. Maintain clear design documents and data flows for all transactions and workflows, noting any assumptions that are made at each stage.
    2. Write code as clearly as possible. Producing clear documentation is crucial to ensure that other developers and testers know what assumptions are being made and exactly what the expected behavior is.
    3. Note ant references to other code that uses each component. Think about any side-effects of these dependencies if a malicious party were to manipulate them in an unusual way.
    
- Analyzing how a logic flaw existed in the first place and how it was missed by the team can help you to spot weaknesses in your processes.
- By making minor adjustments, you can increase the likelihood that similar flaws will be cut off at the source or caught earlier in the development process.


----------------
# Materials
### Referencing
1. [PortSwigger](https://portswigger.net/web-security/logic-flaws)
2. [OWASP](https://owasp.org/www-community/vulnerabilities/Business_logic_vulnerability)
