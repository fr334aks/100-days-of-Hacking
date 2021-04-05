#working with functions and files

from sys import argv

script, input_file = argv

def print_all(f): 
# file F is responsible for maintaining current position in the file to return what it found so far
	print f.read()
# this function prints the content of the file


def rewind(f):
	f.seek(0)

def print_a_line(line_count, f):
	print line_count, f.readline()
#the f.readline reads a complete line on the file

current_file = open(input_file)

print "First let's print the whole file :\n"

print_all(current_file)

print "Now let's rewind, kind of like a tape."

rewind(current_file)

print "Let's print three lines"

current_line = 1
print_a_line(current_line, current_file)

current_line = current_line + 1
print_a_line(current_line, current_file)

current_line = current_line + 1
print_a_line(current_line, current_file)


