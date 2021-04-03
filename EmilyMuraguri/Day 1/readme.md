Active Directory  is a directory service developed by microsoft to manage windows domain Networks.It stores information related objects such as computers and users.Authenticates using kerbros tickets.Non-windows devices can authenticate via LDAP and RADIUS 

**How kerberos Works **


![image](https://user-images.githubusercontent.com/36562081/113490267-a313ed80-94d1-11eb-9281-6f461b7274a6.png)




**Benefits of Active Directory**



single point of access for network resources
Hierarchical organisational structure 

Componets of Active Directory 

![image](https://user-images.githubusercontent.com/36562081/113490281-b9ba4480-94d1-11eb-9ba1-5958c20fe1c5.png)


**Physical components of Active Directory**
1.Domain controller 
Server with the AD DS role installed that has been promoted to domain controller 
-Hosts a copy AD DS directory  store 
-Provide authentication and authorization services 
-Replicates updates to other domain controllers in the domain and forest 
-Allows administrative access to manage user accounts and network resouces 


2.AD DS data store 
Contains the database files and processes that store and manage directory information for users,services and applications 
-Consists ofthe Ntds.dit file 
-Stored by default in the %systemRoot%\NTDS folder on all domain controllers 
-Accessible only through the domain controller processes and protocals 
-Ntds file also consists of the password hashes for all the users 





**Logical Componets of Active Directory **

**AD DS schema **

Defines objects that can be created in the active directory


**Domains**

Used to group and manage objects in organisatons 

![image](https://user-images.githubusercontent.com/36562081/113490288-c6d73380-94d1-11eb-9d95-d3048f03f4b6.png)


**Trees **

A hierachy of domains 
 
 **Forest**
A collection of one or more domain trees 
 
 ![image](https://user-images.githubusercontent.com/36562081/113490304-dce4f400-94d1-11eb-8b56-e57a8675585a.png)

 **Organisational units (OUs)**
Containers that can contain users,groups,computers and other OUs 

 **Trusts **
 
 Provide a mechanism for users to gain access to resources in another domains
 
 **Objects **
 
 ![image](https://user-images.githubusercontent.com/36562081/113490320-e5d5c580-94d1-11eb-865f-3b66643df92f.png)


Source:Microsoft Virtual academy 
