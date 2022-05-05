︠24d4d9e4-2cb7-4463-a107-8704b599ccd2r︠
import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich a zobrazi data
def main():
    if not os.path.exists('GeneratorMatrices'):
            os.makedirs('GeneratorMatrices')
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            print(getCageName(sortedfilepaths[i]));
            print("Počet automorfizmov AutGroup(C) = {}\n".format(getNumberOfAut(C)));
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
    filepath = filepath.replace('cage_','Cage_');
    filepath = filepath.replace('.txt',':');
    return filepath;

# zisti pocet automorfizmov
def getNumberOfAut(C):
    return C.permutation_automorphism_group().order();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡35622d4b-0e98-4f80-9682-766a74e2ccc2︡{"stdout":"Cage_3_5:\nPočet automorfizmov AutGroup(C) = 120\n"}︡{"stdout":"\nCage_3_6:\nPočet automorfizmov AutGroup(C) = 336\n\nCage_3_7:\nPočet automorfizmov AutGroup(C) = 32\n"}︡{"stdout":"\nCage_3_8:\nPočet automorfizmov AutGroup(C) = 1440\n"}︡{"stdout":"\nCage_4_5:\nPočet automorfizmov AutGroup(C) = 24\n"}︡{"stdout":"\nCage_6_4:\nPočet automorfizmov AutGroup(C) = 1036800\n"}︡{"stdout":"\nCage_6_4:\nPočet automorfizmov AutGroup(C) = 1036800\n"}









