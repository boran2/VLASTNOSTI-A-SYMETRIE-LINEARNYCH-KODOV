︠09fbd0bd-3b52-4f3d-8832-205e5a042649s︠
import random
import glob
import os
import datetime

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data, vygeneruje generujucu maticu, ulozi ju a sleduje cas
def main():
    if not os.path.exists('IncidenceMatrices'):
        os.makedirs('IncidenceMatrices')
    if not os.path.exists('ParityCheckMatrices'):
        os.makedirs('ParityCheckMatrices')
    filepaths = glob.glob('IncidenceMatrices/*.txt');
    sortedfilepaths = sortIncidenceFilesBySize(filepaths);
    counter = 0;
    for i in range(len(sortedfilepaths) - 1):
        startTime = datetime.datetime.now();
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            L = getIncidenceMatrixFromFile(file);
            file.close();
            H = getParityCheckMatrix(L);
            sortedfilepaths[i] = sortedfilepaths[i].replace('IncidenceMatrices','ParityCheckMatrices');
            sortedfilepaths[i] = sortedfilepaths[i].replace('L_','H_');
            file = open(sortedfilepaths[i], 'w');
            file.write(str(H));
            sortedfilepaths[i] = sortedfilepaths[i].replace('ParityCheckMatrices/','');
            time = datetime.datetime.now() - startTime;
            file.close();
            counter += 1;
            print("[{}] Súbor ParityCheckMatrices/{} ból úspešne vytvorený! Doba vytvárania súboru: {}s\n".format(counter,sortedfilepaths[i],time.total_seconds()));
        else:
            print("Súbor {} je prázdny! Nemôžem vytvoriť kontrolnú maticu!\n".format(sortedfilepaths[i]));
            continue;

# zoradi textove subory na zaklade velkosti
def sortIncidenceFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;

# prevedie obsah suboru do maticovaej formy
def getIncidenceMatrixFromFile(file):
    L = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(' ');
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        L.append(row);
    return matrix(GF(2),L);

# ziska kontrolnu maticu z incidencnej
def getParityCheckMatrix(L):
    n = len(L.row(0))
    v0 = zero_vector(n)
    Harray = []
    for incidenceRow in L.echelon_form():
        if incidenceRow != v0:
            Harray.append(incidenceRow)
    return matrix(GF(2),Harray)

main()
︡a765f399-b9d7-46de-9c4d-8f990025228f︡{"stdout":"Súbor IncidenceMatrices/L_Cage_3_18.txt je prázdny! Nemôžem vytvoriť kontrolnú maticu!\n\nSúbor IncidenceMatrices/L_Cage_5_10.txt je prázdny! Nemôžem vytvoriť kontrolnú maticu!\n\n[1] Súbor ParityCheckMatrices/H_Cage_3_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.090065s\n\n[2] Súbor ParityCheckMatrices/H_Cage_3_6.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.002028s\n\n[3] Súbor ParityCheckMatrices/H_Cage_6_4.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.002238s\n\n[4] Súbor ParityCheckMatrices/H_Cage_4_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.003617s\n\n[5] Súbor ParityCheckMatrices/H_Cage_3_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.002546s\n"}︡{"stdout":"\n[6] Súbor ParityCheckMatrices/H_Cage_3_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.004543s\n\n[7] Súbor ParityCheckMatrices/H_Cage_3_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.011009s\n\n[8] Súbor ParityCheckMatrices/H_Cage_7_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.077853s\n\n[9] Súbor ParityCheckMatrices/H_Cage_4_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.013373s\n"}︡{"stdout":"\n[10] Súbor ParityCheckMatrices/H_Cage_3_11.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.100333s\n"}︡{"stdout":"\n[11] Súbor ParityCheckMatrices/H_Cage_10_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.576702s\n"}︡{"stdout":"\n[12] Súbor ParityCheckMatrices/H_Cage_11_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 1.223451s\n"}︡{"stdout":"\n[13] Súbor ParityCheckMatrices/H_Cage_4_9.txt ból úspešne vytvorený! Doba vytvárania súboru: 1.090954s\n"}︡{"stdout":"\n[14] Súbor ParityCheckMatrices/H_Cage_3_14.txt ból úspešne vytvorený! Doba vytvárania súboru: 2.106187s\n"}︡{"stdout":"\n[15] Súbor ParityCheckMatrices/H_Cage_12_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 4.197093s\n"}︡{"stdout":"\n[16] Súbor ParityCheckMatrices/H_Cage_4_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.094261s\n"}︡{"stdout":"\n[17] Súbor ParityCheckMatrices/H_Cage_13_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.289684s\n"}︡{"stdout":"\n[18] Súbor ParityCheckMatrices/H_Cage_3_16.txt ból úspešne vytvorený! Doba vytvárania súboru: 13.508431s\n"}︡{"stdout":"\n[19] Súbor ParityCheckMatrices/H_Cage_7_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 11.597185s\n"}︡{"stdout":"\n[20] Súbor ParityCheckMatrices/H_Cage_7_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 16.691651s\n"}︡{"stdout":"\n"}︡{"done":true}︡









