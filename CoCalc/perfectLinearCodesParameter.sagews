︠613d8bf1-5916-43eb-af61-1da2fc058b87r︠
import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich a zobrazi data
def main():
    if not os.path.exists('GeneratorMatrices'):
        os.makedirs('GeneratorMatrices')
        return
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r')
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            n = G.ncols();
            m = getMaxNumberOfCodewords(G)
            d = C.minimum_distance();
            print(getCageName(sortedfilepaths[i]));
            print("Minimálna Hammingová vzdialenosť v kóde d = {}".format(d));
            print("Maximálny počet kódových slov m = {}".format(m));
            print("Dĺžka lineárneho kódu n = {}".format(n));
            print("Parameter perfektného kódu p(n,m,d) = {}\n".format(perfectCodeParameter(n,m,d)));

        else:
            print("Súbor {} je prázdny! Neviem získať generujúcu maticu!\n".format(sortedfilepaths[i]));
            continue;

# udava vzdialenost nasho kodu od perfektneho v intervale 0 - 1, kedy 1 je perfektny kod 23,2^12,7 7,2^4,3
def perfectCodeParameter(n,M,d):
    if d % 2 == 1:
        t = (d-1)/2;     # t=(d-1)/2 pre neparne
    else:
        t = (d-2)/2;     # parne (d-1)/2 dostavam desatinne cislo, uvazujem len cele, preto d-2
    sum = 0.0;
    for i in range(0,t+1):
        sum = sum + combinationNumber(n,i);
    parameter = (M*sum)/(2^n)
    return parameter;

# vypocet faktorialu
def factorial(n):
    fact = 1;
    for i in range(1,n+1):
        fact = fact * i
    return fact;

# vypocet kombinacneho cisla
def combinationNumber(n,k):
    return factorial(n)/(factorial(k)*factorial(n-k));

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

# zisti pocet kodovych slov
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡78607216-98f3-4fef-b064-4a2c13d2ec99︡{"stdout":"Cage_3_5:"}︡{"stdout":"\nMinimálna Hammingová vzdialenosť v kóde d = 5\nMaximálny počet kódových slov m = 64\nDĺžka lineárneho kódu n = 15\nParameter perfektného kódu p(n,m,d) = 0.236328125000000\n\nCage_3_6:"}︡{"stdout":"\nMinimálna Hammingová vzdialenosť v kóde d = 6\nMaximálny počet kódových slov m = 256\nDĺžka lineárneho kódu n = 21\nParameter perfektného kódu p(n,m,d) = 0.0283203125000000\n\nCage_3_7:"}︡{"stdout":"\nMinimálna Hammingová vzdialenosť v kóde d = 7\nMaximálny počet kódových slov m = 8192\nDĺžka lineárneho kódu n = 36\nParameter perfektného kódu p(n,m,d) = 0.000930666923522949\n\nCage_3_8:"}︡{"stdout":"\nMinimálna Hammingová vzdialenosť v kóde d = 8\nMaximálny počet kódových slov m = 65536\nDĺžka lineárneho kódu n = 45\nParameter perfektného kódu p(n,m,d) = 0.0000283606350421906\n\nCage_4_5:"}︡{"stdout":"\nMinimálna Hammingová vzdialenosť v kóde d = 5\nMaximálny počet kódových slov m = 1048576\nDĺžka lineárneho kódu n = 38\nParameter perfektného kódu p(n,m,d) = 0.00283050537109375\n\nCage_6_4:"}









