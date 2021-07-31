#!/usr/bin/env python3

import os

repo_path = "e:/Home/Nata/DevOps/sysadm-homeworks"
bash_command = ["cd "+repo_path, "git status -s"]
result_os = os.popen(' && '.join(bash_command)).read()

is_change = False
for result in result_os.split('\n'):
    if result.find('M') != -1:
        prepare_result = result.replace(' M ', '')
        print(repo_path + "/" + prepare_result)
