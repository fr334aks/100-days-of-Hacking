#!/usr/bin/python3

#Named a function.

def add_two_numbers(a, b):
	return a+b

print (2,3)

#Changing the above function to lambda function

add_two_nums = lambda a,b: a+b
print (add_two_nums(2,3))

#Self invoking lambda function.

print ((lambda a,b: a + b)(2,3))

square = lambda x : x ** 2
print (square(3))

cube = lambda x : x ** 3
print (cube(9))

# Multiple variables.

multiple_variable = lambda a, b, c: a **2-3 * b + 4 + c
print (multiple_variable(5, 5, 3)) 
