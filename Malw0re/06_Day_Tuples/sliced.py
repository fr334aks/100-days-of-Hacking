tp1 = ('item1', 'item2', 'item3', 'item4', 'item5')

# range of positives
print "this is a range of positives"

all_items = tp1[0:4] # all items
all_items = tp1[0:]  # all items

middle_two_items = tp1[1:3] # does not include item at index 3

print "All items ",str(all_items)
print "Middle items",str(middle_two_items)

# Range of Negative Indexes

print "Range of negative Indexes"
tp2 = ('banana','mango','apple','lemon')
all_items = tp2[-4:]
middle_two_items = tp2[-3:-1] # does not include item at index 3 (-1)

print "All negated tuple",str(all_items)
print "Middle two items,",str(middle_two_items)
