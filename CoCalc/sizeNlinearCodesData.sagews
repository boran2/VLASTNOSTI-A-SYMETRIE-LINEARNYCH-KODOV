︠a3135739-d4ba-4c6b-b621-5a93e74a472ew︠
import random
import glob
import os


def main():
    if not os.path.exists('GeneratorMatrices'):
            os.makedirs('GeneratorMatrices')
            return
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            n = G.ncols();
            print(getCageName(sortedfilepaths[i]));
            print("Dĺžka lineárneho kódu n = {}".format(n));
            print("Rozmer matice G = {} x {}\n".format(G.nrows(),n));
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
            row.append(int(numberCharacter));
        H.append(row);
    return matrix(GF(2),H);

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('GeneratorMatrices/G_','');
    filepath = filepath.replace('cage_','Cage_');
    filepath = filepath.replace('.txt',':');
    return filepath;

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡79679934-3deb-468a-8c80-361e0c69a569︡{"stdout":"Cage_3_5:\nDĺžka lineárneho kódu n = 15\nRozmer matice G = 6 x 15\n\nCage_3_6:\nDĺžka lineárneho kódu n = 21\nRozmer matice G = 8 x 21\n\nCage_3_7:\nDĺžka lineárneho kódu n = 36\nRozmer matice G = 13 x 36\n\nCage_3_8:\nDĺžka lineárneho kódu n = 45\nRozmer matice G = 16 x 45\n\nCage_4_5:\nDĺžka lineárneho kódu n = 38\nRozmer matice G = 20 x 38\n\nCage_6_4:\nDĺžka lineárneho kódu n = 36\nRozmer matice G = 25 x 36\n\nCage_3_10:\nDĺžka lineárneho kódu n = 105\nRozmer matice G = 36 x 105\n\nCage_4_7:"}︡{"stdout":"\nDĺžka lineárneho kódu n = 134\nRozmer matice G = 68 x 134\n\nCage_3_11:\nDĺžka lineárneho kódu n = 168\nRozmer matice G = 57 x 168\n\nCage_7_5:"}︡{"stdout":"\nDĺžka lineárneho kódu n = 175\nRozmer matice G = 126 x 175\n\nCage_3_14:"}︡{"stdout":"\nDĺžka lineárneho kódu n = 576\nRozmer matice G = 193 x 576\n\nCage_4_9:"}︡{"stdout":"\nDĺžka lineárneho kódu n = 540\nRozmer matice G = 271 x 540\n\nCage_4_10:"}︡{"stdout":"\nDĺžka lineárneho kódu n = 768\nRozmer matice G = 385 x 768\n\n"}︡{"stderr":"Error in lines 43-43\n"}︡{"stderr":"Traceback (most recent call last):\n  File \"/cocalc/lib/python3.9/site-packages/smc_sagews/sage_server.py\", line 1230, in execute\n    exec(\n  File \"\", line 1, in <module>\n  File \"\", line 10, in main\n  File \"\", line 10, in getMatrixFormG\n  File \"src/cysignals/signals.pyx\", line 310, in cysignals.signals.python_check_interrupt\nKeyboardInterrupt\n"}︡{"done":true}









