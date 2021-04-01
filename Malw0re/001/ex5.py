#More Variables and printing

my_name = "Malwore"
my_age = 40 #not a lie
my_height = 74 #inches
my_weight = 180 #lbs
my_eyes = "brown"
my_hair = "black"

# Working with format strings

print "Let's talk about %s." %my_name # modulus is a reference of named variable
print "He's %d inches tall." %my_height
print "He's %d pounds heavy." %my_weight
print "Actually that's not too heavy"
print "He's got %s eyes and %s hair" %(my_eyes, my_hair)
# the modulus is helpful in referencing variables

# this line is tricky, try to get it exactly right
print "If I add %d, %d and %d i get %d" %(my_age, my_height, my_weight, 
my_age+ my_height + my_weight)
