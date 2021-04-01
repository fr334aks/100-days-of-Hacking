# SQL Injection

------------------------------------------------------------------------
- SQL injection is a web security vulnerability that allows an attacker to interfere with the queries that an application makes to its database
- An attacker can modify or delete this data, causing persistent changes to the application's content or behavior.
- An attacker can escalate an SQL injection attack to compromise the underlying server or other back-end infrastructure, or perform a denial-of-service attack.

## Types of SQL injection
1. `In-band SQLi(Classic SQLi)`
- Occurs when an attacker is able to use the same communication channel to both launch the attack and gather results.
- Types are:
  1. ``` Error-based SQLi```
      - Relies on error messages thrown by the database server to obtain information about the structure database.
      - Should be disabled on a live site, or logged to a file with restricted access instead.
   2. ```Union-based SQLi```
      - Leverages the **UNION** SQL operator to combine the results of two or more **SELECT** statements into a single result which is then returned as part of the HTTP response.
    
2. `Inferential SQLi (Blind SQLi)`
- May take longer for an attacker to exploit but dangerous form.
- No data is transfered via the web app and the attacker would not be able to see the result of an attack in-band.
- An attacker is able to reconstruct the database structure by sending payloads, observing the web apps response and the resulting behaviour of the server.
- Types are : 
   1. ```Boolean-based(content-based) Blind SQLi```
        - Relies on sending an SQL query to the database which forces the app to return a different result depending on whether the query returns a TRUE or FALSE result.
        - Depending on the result, the content within the HTTP response will change or remain the same allowing an attacker to infer if the payload used returned TRUE or FALSE even though no data from the database is returned
   2. ```Time-base Blind SQLi```
        - Relies on sending an SQL query to the database which forces the database to wait for a specified amount of time before responding. Response time will indicate to the attacker whether the result of the query is TRUE or FALSE.

3. `Out-of band SQLi`
- Depends on features being enabled on the database server being used by the web app.
- Occurs when an attacker is unable to use the same channel to launch the attack and gather results.
- Offers an alternative to inferential time-based techniques if the server responses are not very stable.
- Would rely on the database servers' ability to make DNS or HTTP requests to deliver data to an attacker.
- ```Example```  
    - Oracle Database's UTL_HTTP package which can be used to send HTTP requests from SQL and PL/SQL to a server an attacker controls.


### SQL injection examples
A. ``` Retrieving hidden data ```
* One can modify an sql query to return additional results
#### Lab 
``` 
https://portswigger.net/web-security/sql-injection/lab-retrieve-hidden-data
```
#### Solution :
- When a gift category is selected in the page, eg tech gifts, link would be:
``` https://ac371f081e4fc1da80be130e00960029.web-security-academy.net/filter?category=Tech+gifts ```
- The SQL query to retrieve the info would be:
 ``` SELECT * FROM products WHERE category = 'Tech gifts' AND released = 1 ```
- Adding a single quote at the end of the query string would result to the following:
``` ?category=Tech+gifts' ```
- In the SQL query:
``` SELECT * FROM products WHERE category = 'Tech gifts'' AND released = 1 ```
- This will cause an error as there is one single quote that is not closed
- Adding double dash after the quote "--":
``` ?category=Tech+gifts'-- ```
- In the query string:
``` SELECT * FROM products WHERE category = 'Tech gifts'--' AND released = 1 ```
- This would result in showing in all products of category, Tech gifts both released and unreleased would be shown.
- To fully show everything in the database:
 ```
 ?category=Tech+gifts' or 1=1-- 
 SELECT * FROM products WHERE category = 'Tech gifts' or 1=1--' AND released = 1 
 ```

B. ```Subverting application logic```
- One can modify login informations in applications that a user has to log in with a username and password.
- If a username is *trojan* and password is *12345* , the application checks te credentials by performing 
``` SELECT * FROM users WHERE username="trojan" AND password = "12345" ```
- If the query returns details of a user then login is successful, otherwise the login is rejected.
- An attacker can login as any user without a password by using the comment sequence to remove the password check ie submitting the username "administrator'--" and a blank password result.
``` SELECT * FROM users WHERE username = 'administrator'--' AND password ='' ```

#### Lab
```
https://portswigger.net/web-security/sql-injection/lab-login-bypass
```

C. ```UNION attacks```
- Where the results of an SQL query are returned within the application's response, an attacker can leverage an SQL injection vulnerability to retrieve data from other tables within the database done using the UNION keyword that lets one execute an additional SELECT and append the results to the original query.
- Eg:
``` SELECT name, description FROM products WHERE category = 'Tech gifts' ```
- An attacker can submit the input:
``` UNION SELECT username, password FROM users-- ```
- This will cause the application to return all usernames and passwords along with the names and description of products.
``` SELECT name, description FROM products WHERE category = 'Tech gifts' UNION SELECT username, password FROM users-- ```
 
### Examining the database
- It is useful to obtain some information about the database itself after identifying an SQLi vulnerability. The information can pave way for further exploitation.
- You can check version of database type. eg in Oracle:
  ``` SELECT * FROM v$version ```
- On most databases execute the following query to list the tables:
  ``` SELECT * FROM information_schema.tables ```

### Detecting SQL injection vulnerabilities
- Can be found quickly and reliably using Burp suites <a href="https://portswigger.net/burp/vulnerability-scanner">web vulnerability scanner</a>.
- SQL injection can be detected manually by using a systematic set of tests against every entry point and involves:
    1. Submitting the single quote character ' and looking for errors or other anomalies.
    2. Submitting some SQL-specific syntax that evaluates to the base value of the entry point and to a different value.
    3. Submitting Boolean conditions such as  "OR 1=1" and "OR 1=2" and looking for differences in the application's responses.
    4. Submitting payloads designed to trigger time delays when executed wuthin an SQL query, and looking for differences in the time taken to respond.
    5. Submitting OAST payloads designed to trigger an out-of-band network interaction when executed within an SQL query, and monitoring for any resulting interactions.
    
### SQL injection in different parts of the query
- Most SQLi vulnerabilities arise  within the **WHERE** of a **SELECT** query but they can occur at any location  within the query and within different query types with the most common being:
    1. In *UPDATE* statements within the updated vales or the WHERE clause.
    2. In *INSERT* statements within the inserted values.
    3. In *SELECT* statements within the table or column name.
    4. In *SELECT* statements within the ORDER BY clause.
    
### Second-order SQL injection
- First-order SQLi arises where the application takes user input from an HTTP request and, while processing the request, incorporates the input into an SQL in an unsafe way.
- Second-order SQLi(stored SQLi) arises when the application takes user input from an HTTP request and stores it for future done by placing the input into a database.

### Database-specific factors
- Some techniques  for detecting and exploiting SQLi work differently on different platforms ie:
    1. syntax for string concatenation.
    2. Comments.
    3. Batched queries
    4. Platform-specific APIs.
    5. Error messages.

### Preventing SQLi
- Prevented by using parameterized queries(prepared statements) instead of string concatenation within the query.
- Eg, the following code is vulnerable to SQLi:
```
 String query = "SELECT * FROM products WHERE category = '"+ input + "'";
Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery(query); 
```
- The code can be rewritten in a way that prevents the user input from interfering with the query structure:
```
 PreparedStatement statement = connection.prepareStatement("SELECT * FROM products WHERE category = ?");
statement.setString(1, input);
ResultSet resultSet = statement.executeQuery(); 
```
-----------------------------------------

Sources:

1. https://portswigger.net/web-security/sql-injection
2. https://www.acunetix.com/websitesecurity/sql-injection2/
