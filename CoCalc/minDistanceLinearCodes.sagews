︠04bc6731-171d-4725-b80c-f5486f62b509s︠
import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich a zobrazi data
def main():
    if not os.path.exists('GeneratorMatrices'):
        os.makedirs('GeneratorMatrices')
        return
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths)
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            d = C.minimum_distance();
            print("G_{}".format(getCageName(sortedfilepaths[i])));
            print("Minimálna vzdialenosť v kóde d = {}\n".format(d));
        else:
            print("Súbor {} je prázdny! Neviem získať generujúcu maticu!\n".format(sortedfilepaths[i]));
            continue;

# prevedie obsah suboru do maticovaej formy
def getMatrixFormG(file):
    H = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(" ");
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        H.append(row);
    return matrix(GF(2),H);

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('GeneratorMatrices/G_','');
    filepath = filepath.replace('cage_','Cage(');
    filepath = filepath.replace('_',',');
    filepath = filepath.replace('.txt','):');
    return filepath;

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡d0e0269f-01fc-4ea8-9b6a-3a4ba07aea59︡{"stdout":"G_Cage,3,5):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 5\n\nG_Cage,3,6):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 6\n\nG_Cage,3,7):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 7\n\nG_Cage,3,8):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 8\n\nG_Cage,4,5):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 5\n\nG_Cage,6,4):"}︡{"stdout":"\nMinimálna vzdialenosť v kóde d = 4\n\n** Gap crashed or quit executing 'P:=AClosestVectorCombinationsMatFFEVecFFECoords(Gmat,K,v,16,1);' **"}︡{"stdout":"\nRestarting Gap and trying again\n"}︡{"stderr":"Error in lines 43-43\n"}︡{"stderr":"Traceback (most recent call last):\n"}︡{"stderr":"  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 524, in _execute_line\n    x = E.expect_list(self._compiled_full_pattern)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/pexpect/spawnbase.py\", line 372, in expect_list\n    return exp.expect_loop(timeout)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/pexpect/expect.py\", line 179, in expect_loop\n    return self.eof(e)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/pexpect/expect.py\", line 122, in eof\n    raise exc\npexpect.exceptions.EOF: End Of File (EOF). Exception style platform.\nGap with PID 718 running /ext/sage/9.5/local/bin/gap -r -L /home/user/.sage/gap/gap-workspace-04a335c0fc785f3e86abe38e881eb27b643083bf -b -p -T -E -m 64m /ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/ext_data/gap/sage.g\ncommand: /ext/sage/9.5/local/bin/gap\nargs: ['/ext/sage/9.5/local/bin/gap', '-r', '-L', '/home/user/.sage/gap/gap-workspace-04a335c0fc785f3e86abe38e881eb27b643083bf', '-b', '-p', '-T', '-E', '-m', '64m', '/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/ext_data/gap/sage.g']\nbuffer (last 100 chars): b''\nbefore (last 100 chars): ''\nafter: <class 'pexpect.exceptions.EOF'>\nmatch: None\nmatch_index: None\nexitstatus: None\nflag_eof: True\npid: 718\nchild_fd: 11\nclosed: False\ntimeout: None\ndelimiter: <class 'pexpect.exceptions.EOF'>\nlogfile: None\nlogfile_read: None\nlogfile_send: None\nmaxread: 4194304\nignorecase: False\nsearchwindowsize: None\ndelaybeforesend: None\ndelayafterclose: 0.1\ndelayafterterminate: 0.1\nsearcher: searcher_re:\n    0: re.compile(b'@p\\\\d+\\\\.')\n    1: re.compile(b'@@')\n    2: re.compile(b'@[A-Z]')\n    3: re.compile(b'@[123456!\"#$%&][^+]*\\\\+')\n    4: re.compile(b'@e')\n    5: re.compile(b'@c')\n    6: re.compile(b'@f')\n    7: re.compile(b'@h')\n    8: re.compile(b'@i')\n    9: re.compile(b'@m')\n    10: re.compile(b'@n')\n    11: re.compile(b'@r')\n    12: re.compile(b'@s\\\\d')\n    13: re.compile(b'@w.*\\\\+')\n    14: re.compile(b'@x')\n    15: re.compile(b'@z')\n\nDuring handling of the above exception, another exception occurred:\n\nTraceback (most recent call last):\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 658, in _eval_line\n    (normal, error) = self._execute_line(line, wait_for_prompt=wait_for_prompt,\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 565, in _execute_line\n    raise RuntimeError(\"Unexpected EOF from %s executing %s\"%(self,line))\nRuntimeError: Unexpected EOF from Gap executing P:=AClosestVectorCombinationsMatFFEVecFFECoords(Gmat,K,v,16,1);\n\nDuring handling of the above exception, another exception occurred:\n\nTraceback (most recent call last):\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 673, in _eval_line\n    raise RuntimeError(\"%s produced error output\\n%s\\n   executing %s\"%(self, error,line))\nRuntimeError: Gap produced error output\nError, Variable: 'Gmat' must have a value\n\n   executing P:=AClosestVectorCombinationsMatFFEVecFFECoords(Gmat,K,v,16,1);\n\nDuring handling of the above exception, another exception occurred:\n\nTraceback (most recent call last):\n  File \"/cocalc/lib/python3.9/site-packages/smc_sagews/sage_server.py\", line 1230, in execute\n    exec(\n  File \"\", line 1, in <module>\n  File \"\", line 13, in main\n  File \"sage/misc/cachefunc.pyx\", line 1948, in sage.misc.cachefunc.CachedMethodCaller.__call__ (build/cythonized/sage/misc/cachefunc.c:10483)\n    w = self._instance_call(*args, **kwds)\n  File \"sage/misc/cachefunc.pyx\", line 1824, in sage.misc.cachefunc.CachedMethodCaller._instance_call (build/cythonized/sage/misc/cachefunc.c:9949)\n    return self.f(self._instance, *args, **kwds)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/coding/linear_code.py\", line 1401, in minimum_distance\n    return self._minimum_weight_codeword(algorithm).hamming_weight()\n"}︡{"stderr":"  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/coding/linear_code.py\", line 1464, in _minimum_weight_codeword\n    gap.eval(\"P:=AClosestVectorCombinationsMatFFEVecFFECoords(Gmat,K,v,{},1)\".format(i))\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 498, in eval\n    result = Expect.eval(self, input_line, **kwds)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/expect.py\", line 1382, in eval\n    return '\\n'.join([self._eval_line(L, allow_use_file=allow_use_file, **kwds)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/expect.py\", line 1382, in <listcomp>\n    return '\\n'.join([self._eval_line(L, allow_use_file=allow_use_file, **kwds)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 703, in _eval_line\n    return self._eval_line(line, allow_use_file=allow_use_file)\n  File \"/ext/sage/9.5/local/var/lib/sage/venv-python3.9.9/lib/python3.9/site-packages/sage/interfaces/gap.py\", line 707, in _eval_line\n    raise RuntimeError(exc)\nRuntimeError: Gap produced error output\nError, Variable: 'Gmat' must have a value\n\n   executing P:=AClosestVectorCombinationsMatFFEVecFFECoords(Gmat,K,v,16,1);\n"}︡{"done":true}︡









