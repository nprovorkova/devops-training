#!/usr/bin/env python3

import os
import sys

if len(sys.argv) < 2:
   print("Не передан аргумент с наименованием путем к репозиторию")
else:
   repo_path = sys.argv[1]
   if os.path.isdir(repo_path):
       if os.path.isdir(repo_path + "/.git"):
           bash_command = ["cd "+repo_path, "git status -s"]
           result_os = os.popen(' && '.join(bash_command)).read()

           for result in result_os.split('\n'):
                if result.find('M') != -1:
                    prepare_result = result.replace(' M ', '')
                    print(repo_path + "/" + prepare_result)
       else:
           print("Аргумент не является репозиторием git")
   else:
       print("Аргумент не является директорией")
