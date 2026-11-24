import os
from threading import Thread
    
def c(pth = "programs/"):
    src = os.listdir(pth)
    for name in src:
        inp = os.path.join(pth, name)
        out= os.path.join("images/", name.removesuffix('.asm') + '.hex')
        args = [f"python tools/assemble.py {inp} -o {out}"]
        Thread(target=os.system, args=args).start()

c()
c("tests/")
