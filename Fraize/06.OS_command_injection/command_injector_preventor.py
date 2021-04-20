#preventing os injection using shlex
import subprocess
import shlex

domain_name = domain("Enter the domain name: ")
safe_domain_name =  shlex.quote(domain_name)
command = "nslookup {}".format(safe_domain_name)
response = subprocess.check_output(command, shell=True,encoding='UTF-8')
print(response)
