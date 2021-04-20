import requests
from bs4 import BeautifulSoup as bs
from urllib.parse import urljoin
from pprint import pprint

# Initialize an HTTP session and set the browser
s = requests.Session()
s.headers["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36"

def get_all_forms(url):
    # Given a url it'll return all forms from the html content
    soup = bs(s.get(url).content, "html.parser")
    return soup.find_all("form")

def get_form_details(form):
    # extracts all possible useful info about an HTML FORM
    details = {}
    # get form action from target url
    try:
        action = form.attrs.get("action").lower()
    except:
        action = None
    # get the form method POST, GET etc
    method = forms.attrs.get("method","get").lower()
    # get all input details
    inputs = []
    for input_tag in form.find_all("input"):
        input_type = input_tag.attrs.get("type","text")
        input_name = input_tag.attrs.get("name")
        input_value = input_tag.attrs.get("value", "")
        inputs.append({"type": input_type, "name": input_name, "value":input_value})
    details["action"] = action
    details["method"] = method
    details["inputs"] = inputs
    return details

def is_vulnerable(response):
    errors = {
        #MySQL
        "you have an error in your sql syntax;",
        "warning: mysql",
        #SQL Server
        "unclosed quotation mark after the character string",
        # Oracle
        "quoted string not properly terminated",
    }
    # if one of the errors are found, return True
    for error in errors: 
        if error in response.content.decode().lower():
            return True
    return False

def scan_sql_injection(url):
    # test on url
    for c in "\"'":
        new_url = f"{url}{c}"
        print("[!] Trying", new_url)
        # make an HTTP request
        res = s.get(new_url)
        if is_vulnerable(res):
            print("[+] SQL Injection vulnerability detected, link:", new_url)
            return
    # test on HTML forms
    forms = get_all_forms(url)
    print(f"[+] Detected {len(forms)} forms on {url}.")
    for form in forms:
        form_details = get_form_details(form)
        for c in "\"'":
            data = {}
            for input_tag in form_details["inputs"]:
                if input_tag["type"] == "hidden" or input_tag["value"]:
                    try:
                        data[input_tag["name"]] = input_tag["value"] + c
                    except:
                        pass
                elif input_tag["type"] != "submit":
                    data[input_tag["name"]] = f"test{c}"
            # join the url with the action(form request url)
            url = urljoin(url, form_details["action"])
            if form_details["method"] == "post":
                res = s.post(url, data=data)
            elif form_details["method"] == "get":
                res = s.get(url, params=data)
            # test if page is vulnerable
            if is_vulnerable(res):
                print("[+] SQL Injection vulnerability detected, link:", url)
                print("[+] Form:")
                pprint(form_details)
                break

if __name__ == "__main__":
    url = "http://ec2-35-158-236-11.eu-central-1.compute.amazonaws.com/easy-access/"
    scan_sql_injection(url)