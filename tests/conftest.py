import os
import sys

root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
src = root_dir + "/src"

sys.path.insert(0, src)
