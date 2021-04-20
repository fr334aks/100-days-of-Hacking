import subprocess
import shlex

domain name = input("Enter the domain name: ")

raw_command = "nslookup {}".format(domain_name)
safe_command = shlex.split(raw_command)

response = subprocess.check_output(safe_command, encoding='UTF-8')
print(response)
