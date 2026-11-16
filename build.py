import os
from threading import Thread
pth = "programs/"
src = os.listdir("programs")
for name in src:
    inp = os.path.join(pth, name)
    out= os.path.join("images/", name.removesuffix('.asm') + '.hex')
    args = [f"python tools/assemble.py {inp} -o {out}"]
    Thread(target=os.system, args=args).start()
