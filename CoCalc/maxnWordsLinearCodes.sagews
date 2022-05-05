︠6fd6bcbf-dfb8-44ec-95d4-96796a90809esr︠
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
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            m = getMaxNumberOfCodewords(G);
            print(getCageName(sortedfilepaths[i]));
            print("Maximálny počet kódových slov m = {}\n".format(m));
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

# zisti pocet kodovych slov
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡3140863a-de21-49fb-b04e-edb473cdc1dd︡{"stdout":"Cage_3_5:\nMaximálny počet kódových slov m = 64\n\nCage_3_6:\nMaximálny počet kódových slov m = 256\n\nCage_3_7:\nMaximálny počet kódových slov m = 8192\n\nCage_3_8:\nMaximálny počet kódových slov m = 65536\n\nCage_4_5:\nMaximálny počet kódových slov m = 1048576\n\nCage_6_4:\nMaximálny počet kódových slov m = 33554432\n\nCage_3_10:\nMaximálny počet kódových slov m = 68719476736\n\nCage_4_7:"}︡{"stdout":"\nMaximálny počet kódových slov m = 295147905179352825856\n\nCage_3_11:\nMaximálny počet kódových slov m = 144115188075855872\n\nCage_7_5:"}︡{"stdout":"\nMaximálny počet kódových slov m = 85070591730234615865843651857942052864\n\nCage_3_14:"}︡{"stdout":"\nMaximálny počet kódových slov m = 12554203470773361527671578846415332832204710888928069025792\n\nCage_4_9:"}︡{"stdout":"\nMaximálny počet kódových slov m = 3794275180128377091639574036764685364535950857523710002444946112771297432041422848\n\nCage_4_10:"}︡{"stdout":"\nMaximálny počet kódových slov m = 78804012392788958424558080200287227610159478540930893335896586808491443542994421222828532509769831281613255980613632\n\nCage_10_5:"}









