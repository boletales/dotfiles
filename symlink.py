# -*- coding: utf-8 -*-
import glob, os

os.chdir(os.path.dirname(os.path.abspath(__file__))+"/files")
for cd, dirs, files in os.walk("./"):
    for f in files:
        os.symlink(os.path.abspath(f), os.path.expanduser("~")+(cd[1:]+"/"+f).replace("//","/"))