︠3013beab-478c-4b51-a629-012268c8902ds︠
import random
import datetime
import glob
import os


# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data, vygeneruje generujucu maticu, ulozi ju a sleduje cas
def main():
    if not os.path.exists('IncidenceMatrices'):
        os.makedirs('IncidenceMatrices')
    if not os.path.exists('AutomorphismGroups'):
        os.makedirs('AutomorphismGroups')
    filepaths = glob.glob('IncidenceMatrices/*.txt');
    sortedfilepaths = sortIncidenceFilesBySize(filepaths);
    counter = 0;
    for i in range(len(sortedfilepaths) - 1):
        startTime = datetime.datetime.now();
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            L = getIncidenceMatrixFromFile(file);
            file.close();
            permutations = getPermutationsOfAutomorphisms(Graph(L))
            sortedfilepaths[i] = sortedfilepaths[i].replace('IncidenceMatrices','AutomorphismGroups');
            sortedfilepaths[i] = sortedfilepaths[i].replace('L_','AutGroup_');
            file = open(sortedfilepaths[i], 'w');
            file.write("[\n")
            for j in range(len(permutations)):
                file.write("\t" +str(permutations[j]))
                if j < len(permutations) - 1:
                    file.write(",")
                file.write("\n")
            file.write("]")
            file.close()
            time = datetime.datetime.now() - startTime
            counter += 1;
            print("[{}] Súbor {} ból úspešne vytvorený! Doba vytvárania súboru: {}s\n".format(counter,sortedfilepaths[i],time.total_seconds()));
        else:
            print("Súbor {} je prázdny! Nemôžem vytvoriť grupu automorfizmov!\n".format(sortedfilepaths[i]));
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


# nastavi vrcholy od 1 po pocet vrcholov pre danu klietku
def setNonZeroVerticesLabels(cage):
    vertices = []
    for vertex in range(len(cage.vertices(sort=False))):
        vertices.append(vertex + 1)
    cage.relabel(vertices)
    return cage

# vrati zoznam automorfizmov z klietky vo forme permutacii
def getPermutationsOfAutomorphisms(cage):
    cage = setNonZeroVerticesLabels(cage)
    vertices = cage.vertices()
    automorphismGroup = cage.automorphism_group().list()
    permutations = []
    for i in range(len(automorphismGroup)):
        if i > 0:
            automorphism = str(automorphismGroup[i])
            for vertex in vertices:
                if str(vertex) not in automorphism:
                    automorphism += '(' + str(vertex) + ')';
            permutations.append(str(automorphism))
    return permutations
main();
︡57b8fb94-a417-4e3b-804f-0de69ad764f1︡{"stdout":"Súbor IncidenceMatrices/L_Cage_3_18.txt je prázdny! Nemôžem vytvoriť grupu automorfizmov!\n\nSúbor IncidenceMatrices/L_Cage_5_10.txt je prázdny! Nemôžem vytvoriť grupu automorfizmov!\n\n[1] Súbor AutomorphismGroups/AutGroup_Cage_3_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.004989s\n\n[2] Súbor AutomorphismGroups/AutGroup_Cage_3_6.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.008137s\n\n[3] Súbor AutomorphismGroups/AutGroup_Cage_6_4.txt ból úspešne vytvorený! Doba vytvárania súboru: 46.725114s\n"}︡{"stdout":"\n[4] Súbor AutomorphismGroups/AutGroup_Cage_4_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.037924s\n\n[5] Súbor AutomorphismGroups/AutGroup_Cage_3_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.056121s\n\n[6] Súbor AutomorphismGroups/AutGroup_Cage_3_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.117357s\n"}︡{"stdout":"\n[7] Súbor AutomorphismGroups/AutGroup_Cage_3_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.093363s\n\n[8] Súbor AutomorphismGroups/AutGroup_Cage_7_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 36.597888s\n"}︡{"stdout":"\n[9] Súbor AutomorphismGroups/AutGroup_Cage_4_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.034691s\n\n[10] Súbor AutomorphismGroups/AutGroup_Cage_3_11.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.079219s\n"}︡{"stdout":"\n[11] Súbor AutomorphismGroups/AutGroup_Cage_10_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.284034s\n"}︡{"stdout":"\n[12] Súbor AutomorphismGroups/AutGroup_Cage_11_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.23081s\n"}︡{"stdout":"\n[13] Súbor AutomorphismGroups/AutGroup_Cage_4_9.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.359848s\n"}︡{"stdout":"\n[14] Súbor AutomorphismGroups/AutGroup_Cage_3_14.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.617761s\n"}︡{"stdout":"\n[15] Súbor AutomorphismGroups/AutGroup_Cage_12_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.57911s\n"}︡{"stdout":"\n[16] Súbor AutomorphismGroups/AutGroup_Cage_4_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 1.718815s\n"}︡{"stdout":"\n[17] Súbor AutomorphismGroups/AutGroup_Cage_13_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.594178s\n"}︡{"stdout":"\n[18] Súbor AutomorphismGroups/AutGroup_Cage_3_16.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.506682s\n"}︡{"stdout":"\n[19] Súbor AutomorphismGroups/AutGroup_Cage_7_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 3.998507s\n"}︡{"stdout":"\n[20] Súbor AutomorphismGroups/AutGroup_Cage_7_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 58.305439s\n"}︡{"stdout":"\n"}︡{"done":true}









