##Day 9 
##Working with conditionals

->> By default scripts in python are executed from top to bottom. If the 
processing logic require so, the sequencial flow of execution can be 
altered in two ways;
	conditional execution: a block of one or more statements will be 
			       executed if a certain expression is true
	Repetitive execution: a block of one or more statements will be
			      repetitively executed as long as a certain 
			      expressionis true, This section covers if
			     else, elif statements. The comparison and 
			     logical operators.


## If conditions (if.py)
--> We use key if, to check if a condition is true and to execute the block 
code. It has to have indentation after the colon.

	syntax:
	if condition:
		(block of code runs here)

###If Else condition
--> In this section, if the condition is ture the first block will be 
executed, if not the else condition will run

	syntax:
	if condition:
		(code runs here)
	else:
		(code runs here if false)

### If Else Elif condition
--> We use elif condition to make decisions when running code.

#Short Hand condition
--> This are one liner conditions.

##Nested Conditions
->> A nested statements is a statement inside another statement, those 
statements test if true/false conditions and then take appropriate conditions

-->> There are two methods of nesting conditions, one is nesting statements
inside the if condition and the other is nesting the statements inside the
else condition.

#N/B
-->> We can avoid nested conditions by using logical operator and.

## Logic Operators
Logic operators are used on conditional statements.

	logic AND: True if both the operand are true x and y
	logic OR: True if either of the operand is true x or y
	logic NOT: True if operand is false x not y 

