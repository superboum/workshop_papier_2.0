import sys
from capture import Capture

cp = None
try:
    cp = Capture()
    cp.run()
except Exception as e:
    if cp != None: cp.terminate()
    print e
    print "Bye"
    sys.exit()
