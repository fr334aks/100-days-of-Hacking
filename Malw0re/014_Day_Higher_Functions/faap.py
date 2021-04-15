#!/usr/bin/env/python3

# Function as a return value.

def square(x):
	return x ** 2  # a square function

def cube(x):
	return x ** 3 # a cube function

def absolute(x):
	if x >= 0:
		return x # an absolute value functions.
	else:
		return -(x)


def high_order_function(type):
	if type == 'absolute':
		return square
	elif type == 'cube':
		return cube
	elif type == 'absolute':
		return absolute

result = high_order_function('square')
print (result(3))

result = high_order_function('cube')
print (result(3))

result = high_order_function('absolute')
print (result(-3))

