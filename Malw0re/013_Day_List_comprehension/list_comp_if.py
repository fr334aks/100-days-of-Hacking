#!/usr/bin/python3

#Generating even numbers.

even_numbers = [ i for i in range(21) if i % 2 == 0]
print (even_numbers)

#Generating odd numbers.
odd_numbers = [ i for i in range(21) if i % 3 == 0]
print (odd_numbers)

#Filter numbers: Fitlering out positive numbers.

numbers = [-8, -7, -3, 1, 0, 1, 3, 5, 7, 8, 9, 10]
positive_even_numbers = [ i for i in range(21) if i % 2 == 0  and i > 0 ]

#Flattening a three dimensional array.

three_dimen_list = [[1,2,3], [4,5,6], [7,8,9]]
flattened_list = [ number for row in three_dimen_list for number in row ]

print ('Three dimensional array',flattened_list)

