#working with functions 

# this one is like scripts with argv

def print_two(*args):
	arg1, arg2 = args
	print "arg1: %r, args2: %r" % (arg1, arg2)

# that *args is actually pointless, we can just do this

def print_two_again(arg1, arg2):
	print "arg1: %r, arg2: %r" % (arg1, arg2)

# this just takes one arguement
def print_one(arg1):
	print "arg1: %r" % arg1

def print_none():
	print " I got nothing"

print_two("Zed", "Shawn")
print_two_again("Zed", "shawn")
print_one("first!")
print_none()

