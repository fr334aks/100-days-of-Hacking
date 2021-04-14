#!/usr/bin/env/python3

def power(x):
	return lambda n : x ** n

cube = power(2)(3)
print (cube)

two_power_of_five = power (2)(5)
print (two_power_of_five)
