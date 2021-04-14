#!/usr/bin/env/python3

#generating numbers

numbers = [i for i in range(11)]
print (numbers)

# it is possible to do mathematical operations during iteration

square = [i * i for i in range(11)]
print (square)

#it is also possible  to make a list from a tuple.

numbers = [(i, i * i ) for i in range(11)]
print (numbers)


