#!/usr/bin/python3

#One way

language = 'Python'
lst = list(language) #changing to string
print (type(lst))
print (lst)

#Second way list comprehension

lst = [ i for i in language]
print (type(lst))
print (lst)


