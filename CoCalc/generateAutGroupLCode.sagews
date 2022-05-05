︠b6315108-b9cb-4d86-bebe-8632e6c453ccr︠
import random
import glob
import os
import datetime

# zoradi textove subory incidenčných matic podla velkosti, nacita ich a zobrazi data
def main():
    filepaths = glob.glob('IncidenceMatrices/*.txt');
    sortedfilepaths = sortIncidenceFilesBySize(filepaths);
    counter = 0;
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            L = matrix(GF(2), getMatrixFormL(file));
            file.close();
            permutations = getPermutationsOfAutomorphisms(L);
            H = getParityCheckMatrix(L);
            C = codes.from_parity_check_matrix(H);
            Gr = C.permutation_automorphism_group(algorithm = "partition");
            autGroupC = Gr.order();
            if not os.path.exists('AutomorphismGroups'):
                os.makedirs('AutomorphismGroups');
            startTime = datetime.datetime.now();
            file = open("AutomorphismGroups/AutGroup_Cage_{}_LINEARCODE.txt".format(getCageName(sortedfilepaths[i])), 'w');
            file.write("[\n");
            for j in range(len(permutations)):
                file.write("\t" + str(permutations[j]));
                if j < len(permutations) - 1:
                    file.write(",");
                file.write("\n");
            file.write("]");
            file.close();
            time = datetime.datetime.now() - startTime;
            counter += 1;
            print("[{}] Súbor AutomorphismGroups/AutGroup_{}_LINEARCODE.txt ból úspešne vytvorený! Doba trvania: {}s\n".format(counter,getCageName(sortedfilepaths[i]),time.total_seconds()))
        else:
            print("Súbor {} je prázdny! Neviem získať incidenčnu maticu L!\n".format(sortedfilepaths[i]));
            continue;

# ziska grupu automorfizmov lin kodu
def getPermutationsOfAutomorphisms(L):
    H = getParityCheckMatrix(L)
    C = codes.from_parity_check_matrix(H)
    automorphismGroup = C.permutation_automorphism_group().list()
    permutations = []

    graph = Graph(L)
    graph = setDefaultVertices(graph)
    graph = setDefaultEdges(graph)

    edges=graph.edges()
    automorphism = ""
    for i in range(len(automorphismGroup)):
        if i > 0:
            for group in automorphismGroup[i]:
                automorphism += "("
                for edgesInGroup in group:
                    for edgeInGroup in parseEdges(edgesInGroup):
                        for edge in edges:
                            if str(edge[2]) == str(edgeInGroup):
                                automorphism +=  str(edge)
                                continue
                automorphism += ")"
            for edge in edges:
                if str(edge) not in automorphism:
                    automorphism += '(' + str(edge) + ')'
            permutations.append(str(automorphism))
            automorphism = ""
    return permutations

# nastavi hrany
def parseEdges(group):
    return str(group).replace('(', '').replace(')', '').split(",")

# nastavi vrcholy od 1 po pocet vrcholov pre dany graf
def setDefaultVertices(graph):
    vertices = []
    for vertex in range(len(graph.vertices(sort=False))):
        vertices.append(vertex + 1)
    graph.relabel(vertices)
    return graph

# nastavi lable pre hrany od 1 po pocet hran pre dany graf
def setDefaultEdges(graph):
    edgeId = 0
    for u,v in graph.edge_iterator(labels=None):
        edgeId += 1
        graph.set_edge_label(u, v, str(edgeId))
    return graph

# prevedie obsah suboru do maticovaej formy
def getMatrixFormL(file):
    L = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(" ");
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        L.append(row);
    return matrix(L);

# vrati kontrolnu maticu linearneho kodu ako incidencnu maticu klietky s linearne nezavislymi riadkami matice
def getParityCheckMatrix(L):
    n = len(L.row(0))
    v0 = zero_vector(n)
    Harray = []
    for incidenceRow in L.echelon_form():
        if incidenceRow != v0:
            Harray.append(incidenceRow)
    return matrix(GF(2),Harray)

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('IncidenceMatrices/L_','');
    filepath = filepath.replace('.txt','');
    return filepath;

# zisti informacny pomer
def getRate(nRows, nCols):
    return (nCols - nRows) / nCols;

# zisti pocet vrcholov
def getNumberOfVertices(L):
    return len(L.column(0));

# zisti pocet hran
def getNumberOfEdges(L):
    return len(L.row(0));

# zoradi textove subory na zaklade velkosti
def sortIncidenceFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡34309b67-d5c1-462c-b845-b7607df1143e︡{"stdout":"Súbor IncidenceMatrices/L_Cage_3_18.txt je prázdny! Neviem získať incidenčnu maticu L!\n\nSúbor IncidenceMatrices/L_Cage_5_10.txt je prázdny! Neviem získať incidenčnu maticu L!\n\n[1] Súbor AutomorphismGroups/AutGroup_Cage_3_5_LINEARCODE.txt ból úspešne vytvorený! Doba trvania: 0.000729s\n"}︡{"stdout":"\n[2] Súbor AutomorphismGroups/AutGroup_Cage_3_6_LINEARCODE.txt ból úspešne vytvorený! Doba trvania: 0.001508s\n"}









