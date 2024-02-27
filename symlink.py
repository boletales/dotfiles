# -*- coding: utf-8 -*-
import glob, os, os.path, itertools

os.chdir(os.path.dirname(os.path.abspath(__file__))+"/files")
with os.scandir("./") as entries:
    for entry in entries:
        print(os.path.abspath(entry.name))
        dest = os.path.expanduser("~")+(cd[1:]+"/"+entry.name).replace("//","/")
        if not os.path.exists(dest):
            os.symlink(os.path.abspath(entry.name), dest)
            print("created: "+dest)
