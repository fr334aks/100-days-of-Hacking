# Tuples

->A tuple is a collection of different data types which is ordered and 
unchangable(immutable).Tuples sare written with rond brackets, ().
->Once a tuples is createsm we cannot change its values. We cannot use add,
insert, remove methods in a tuple because its not modifiable (mutable). Unlike
list, tuple has few methods.

##Methods related to tuples.
	tuple(): to create an empty tuple
	count(): to count the number of a specified item in a tuple.
	index(): to find the index of a specified item in atuple
	operator:to join two or more tuples and to create a new tuple.

##Slicing tuples ('sliced.py')

We can slice out a subtuple by specifying a range of indexes where to start
and where to end in the tuple, the return value willbe a new tuple with the 
specified items.
 
##Changing tuples to lists

We can change tuples to list and lists to tuples. Tuples is immutable if we 
want to modify a tuple we should change it to a list.

##Checking an item in a lists
We can check if an item exists or not in a list using 'in', it returns a 
boolean

##joining Tuples
We can join two or more tuples using + operator

#syntax
tp1=('item1', 'item2')
tp2=('item3','item4')

tp3 = tp1 + tp2

#Deleting tuples
It is not possible to remove a single item in a tuple but its possible to 
delete the tuple itself using del.


