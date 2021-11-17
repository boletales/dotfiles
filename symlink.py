# -*- coding: utf-8 -*-
import glob, os, os.path

os.chdir(os.path.dirname(os.path.abspath(__file__))+"/files")
for cd, dirs, files in os.walk("./"):
    for f in files:
        dest = os.path.expanduser("~")+(cd[1:]+"/"+f).replace("//","/")
        if not os.path.exists(dest):
            os.symlink(os.path.abspath(f), dest)
            print("created: "+dest)
