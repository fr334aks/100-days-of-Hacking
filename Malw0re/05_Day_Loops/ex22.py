#Working with loop and Lists

##Before using a for-loop you need to store the results of loops 
##somewhere

#A list is a container of things that are organised inorder []

the_count = [1,2,3,4,5]
fruits = ['apples', 'oranges', 'pears', 'apricots']
change = [1, 'pennies', 2, 'dimes', 3, 'quaters']

# this first kind of for-loops goes through a list 

for number in the_count:
	print "This is count %d" % number

# same as above

for fruit in fruits:
	print "A fruit of type: %s" % fruit

# also we can go through mixed lists too
# notice we have to use %r since we don't know what's in it

for i in change:
	print "I got %r" % i

# we can also buiild lists, firs start with an empty one
elements = []

# then use the range function to do 0 to 5 counts.
# the range function returns a sequence of numbers, incrementing with 1 
# and stops before a specific number range ( start stop step)


for i in range(0,6):
	print "Adding %d to the list." %i
	# append is a function that lists understand
	elements.append(i)

# now we can print them out too
for i in elements:
	print "Element was: %d" %i


