︠36d4d0ee-9963-4f29-9174-0c1e3dfda9d2s︠
import random
import glob
import os
import datetime

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data, vygeneruje generujucu maticu, ulozi ju a sleduje cas
def main():
    if not os.path.exists('ParityCheckMatrices'):
        os.makedirs('ParityCheckMatrices')
    if not os.path.exists('GeneratorMatrices'):
        os.makedirs('GeneratorMatrices')
    filepaths = glob.glob('ParityCheckMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    counter = 0;
    for i in range(len(sortedfilepaths) - 1):
        startTime = datetime.datetime.now();
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            H = getParityCheckMatrixFromFile(file);
            file.close();
            G = getGeneratorMatrix(H);
            sortedfilepaths[i] = sortedfilepaths[i].replace('ParityCheckMatrices','GeneratorMatrices');
            sortedfilepaths[i] = sortedfilepaths[i].replace('H_','G_');
            file = open(sortedfilepaths[i], 'w');
            file.write(str(G));
            time = datetime.datetime.now() - startTime;
            file.close();
            counter += 1;
            print("[{}] Súbor {} ból úspešne vytvorený! Doba vytvárania súboru: {}s\n".format(counter,sortedfilepaths[i],time.total_seconds()));
        else:
            print("Súbor {} je prázdny! Nemôžem vytvoriť generujúcu maticu!\n".format(sortedfilepaths[i]));
            continue;

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;

# prevedie obsah suboru do maticovaej formy
def getParityCheckMatrixFromFile(file):
    H = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(' ');
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        H.append(row);
    return matrix(GF(2),H);

# ziska generujucu maticu z kontrolnej
def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

main()
︡eb999aff-09c7-45cf-8e91-54f420aaf972︡{"stdout":"[1] Súbor GeneratorMatrices/G_Cage_3_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.002485s\n\n[2] Súbor GeneratorMatrices/G_Cage_3_6.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.002319s\n\n[3] Súbor GeneratorMatrices/G_Cage_6_4.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.005297s\n\n[4] Súbor GeneratorMatrices/G_Cage_4_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.004996s\n\n[5] Súbor GeneratorMatrices/G_Cage_3_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.00353s\n\n[6] Súbor GeneratorMatrices/G_Cage_3_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.020506s\n\n[7] Súbor GeneratorMatrices/G_Cage_3_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.036987s\n\n[8] Súbor GeneratorMatrices/G_Cage_7_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.282752s\n"}︡{"stdout":"\n[9] Súbor GeneratorMatrices/G_Cage_4_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.107227s\n"}︡{"stdout":"\n[10] Súbor GeneratorMatrices/G_Cage_3_11.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.112363s\n"}︡{"stdout":"\n[11] Súbor GeneratorMatrices/G_Cage_10_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.09413s\n"}︡{"stdout":"\n[12] Súbor GeneratorMatrices/G_Cage_11_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 6.467657s\n"}︡{"stdout":"\n[13] Súbor GeneratorMatrices/G_Cage_4_9.txt ból úspešne vytvorený! Doba vytvárania súboru: 1.618865s\n"}︡{"stdout":"\n[14] Súbor GeneratorMatrices/G_Cage_3_14.txt ból úspešne vytvorený! Doba vytvárania súboru: 1.48448s\n"}︡{"stdout":"\n[15] Súbor GeneratorMatrices/G_Cage_12_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 14.016637s\n"}︡{"stdout":"\n[16] Súbor GeneratorMatrices/G_Cage_4_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.498219s\n"}︡{"stdout":"\n[17] Súbor GeneratorMatrices/G_Cage_13_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 19.71623s\n"}︡{"stdout":"\n[18] Súbor GeneratorMatrices/G_Cage_3_16.txt ból úspešne vytvorený! Doba vytvárania súboru: 10.076881s\n"}︡{"stdout":"\n[19] Súbor GeneratorMatrices/G_Cage_7_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 38.613822s\n"}︡{"stdout":"\n"}︡{"done":true}









