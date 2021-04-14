#!/usr/bin/python3 

# Filter only the negative and zero in the list using list comprehension

numbers = [-4, -3, -2, -1, 0, 1, 2, 3, 4]

negative_numbers = [i for i in range(5) if i % 2 == 0 and i < 0]
print (negative_numbers)
