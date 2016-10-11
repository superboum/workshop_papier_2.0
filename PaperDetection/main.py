import sys
from capture import Capture

try:
    cp = Capture()
    cp.run()
except:
    cp.terminate()
    print "Bye"
    sys.exit()
