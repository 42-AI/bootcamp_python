import os
import setuptools
import subprocess

subprocess.call("pip install -r resources/requirements.txt", shell=True)
execfile('resources/version.py')
