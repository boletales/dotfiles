# -*- coding: utf-8 -*-
import glob, os, os.path, itertools

os.chdir(os.path.dirname(os.path.abspath(__file__))+"/files")
for cd, dirs, files in os.walk("./"):
    for f in itertools.chain(dirs, files):
        print(os.path.abspath(f))
        dest = os.path.expanduser("~")+(cd[1:]+"/"+f).replace("//","/")
        if not os.path.exists(dest):
            os.symlink(os.path.abspath(f), dest)
            print("created: "+dest)
