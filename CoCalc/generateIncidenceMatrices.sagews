︠6d4773e5-ff5b-483f-aca9-5851618c71d1r︠
import random
import datetime
import os

# ***************vstupne data*****************
sageCages = [[3,5], [3,6], [3,7], [3,8], [3,10], [3,11], [4,5], [7,5]];
exoosCages = [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]];
myConstructedCages = [[6,4]];
# ********************************************

# vygeneruje incidencnu maticu, ulozi ju a sleduje cas
def main():
    cages = getSortedCagesByMooreBound();
    counter = 0
    for cage in cages:
        k = cage[0];
        g = cage[1];
        if not os.path.exists('IncidenceMatrices'):
            os.makedirs('IncidenceMatrices');
        startTime = datetime.datetime.now();
        L = getIncidenceMatrixFromCage(k,g);
        file = open("IncidenceMatrices/L_Cage_{}_{}.txt".format(k,g),'w');
        file.write(str(L));
        time = datetime.datetime.now() - startTime;
        file.close();
        counter += 1;
        print("[{}] Súbor IncidenceMatrices/L_Cage_{}_{}.txt ból úspešne vytvorený! Doba trvania: {}s\n".format(counter,k,g,time.total_seconds()));

# zoradi klietky podla Moorovho ohranicenia
def getSortedCagesByMooreBound():
    cages = sageCages + myConstructedCages + exoosCages;
    sortedCages = [];
    for cage in cages:
        k = cage[0];
        g = cage[1];
        cage.append(calculateMooreBound(k,g))
        sortedCages.append(cage);
    sortedCages.sort(key=takeThird);
    for i in range(len(sortedCages)):
        del sortedCages[i][2];
    return sortedCages;

# element podla ktoreho sa sortuje
def takeThird(elem):
    return elem[2]

# sledujeme 3 zoznamy uvazovanych klietok s ktorymi porovnavame parametre, pre kazdy zoznam sa grafy generuju inym sposobom
def getIncidenceMatrixFromCage(k,g):

    cageInput =[];
    cageInput.append(k);
    cageInput.append(g);

    if ((cageInput in sageCages) == false and (cageInput in exoosCages) == false and (cageInput in myConstructedCages) == false):
        print('\n');
        print('Klietka nie je medzi uvazovanymi alebo neexistuje\n');
        return;

    graph = graphs.EmptyGraph();
    if cageInput in sageCages:
        if k == 3:
            if g == 5:
                cage = graphs.PetersenGraph();
            if g == 6:
                cage = graphs.HeawoodGraph();
            if g == 7:
                cage = graphs.McGeeGraph();
            if g == 8:
                cage = graphs.TutteCoxeterGraph();
            if g == 10:
                cage = graphs.Balaban10Cage();
            if g == 11:
                cage = graphs.Balaban11Cage();
        if k == 4 and g == 5:
            cage = graphs.RobertsonGraph();
        if k == 7 and g == 5:
            cage = graphs.HoffmanSingletonGraph();
    elif cageInput in exoosCages:
        cage = generateGraphandCageFromExoosAdjacencylist("ExoosCages/cage_{}_{}.txt".format(k,g));
    elif cageInput in myConstructedCages:
        if k == 6 and g == 4:
            cage = generate_6_4CageGraph();
    if (cageVerification(cage,k,g) == False):
        print("Klietka Cage({},{}) neexistuje\n".format(k,g));
        return;
    return getIncidenceMatrix(setNonZeroVerticesLabels(cage));

# nastavi vrcholy od 1 po pocet vrcholov pre danu klietku
def setNonZeroVerticesLabels(cage):
    vertices = []
    for vertex in range(len(cage.vertices(sort=False))):
        vertices.append(vertex + 1)
    cage.relabel(vertices)
    return cage

# vypocita najmensi mozny pocet vrcholov pre potencionalnu klietku (testovacie data)
def calculateMooreBound(k,g):
    M = 0;
    if g % 2 == 1:
        exp = (g - 3) / 2;
        for i in range(exp + 1):
            M = M + (k * ((k - 1) ^ i));
        M = M + 1;
    else:
        exp = (g - 2)/2;
        for i in range(exp + 1):
            M = M + ((k - 1) ^ i);
        M = 2 * M;
    return M;

# vypocita potencionalny pocet hran na zaklade Moorovho ohranicenia (testovacie data)
def numberOfEdgesByMooreBound(M,k):
    return M * k / 2;

# vygeneruje Cage(6,4), bez vstupnych parametrov ako bipartitny graf - individualny pristup
def generate_6_4CageGraph():
    m = calculateMooreBound(6,4);
    s =[]
    for i in range(m/2):
        s.append(6);
    graph = graphs.DegreeSequenceBipartite(s,s);
    for i in range (m):
        graph.set_vertex(i, str(i))
    graph.name('Cage (6,4)');
    return graph;

# ziska vsetky cykly prechadzajúce vrcholom 0
def getCycles(graph):
    listOfGirths = [];
    listsOfGirthVertices = graph.minimum_cycle_basis(by_weight=False);
    for listOfGirthVertices in listsOfGirthVertices:
        cycleGraph = graph.subgraph(listOfGirthVertices);
        listOfGirths.append(cycleGraph.cycle_basis());
    return listOfGirths;

# vrati  incidencnu maticu klietky ziskanu z grafu nad polom Z2
def getIncidenceMatrix(graph):
    return matrix(GF(2), graph.incidence_matrix())

# odstranenie hodnot zo zoznamu na zaklade hodnoty
def remove_values_from_list(the_list, val):
    return [value for value in the_list if value != val]

# parsovanie Exoo dokumentov so zoznamami susednych vrcholov na generovanie grafu
def generateGraphandCageFromExoosAdjacencylist(filePath):
    file = open(filePath, 'r');
    graph = graphs.EmptyGraph();
    mainVertex = 0;
    for line in file:
        line = line.replace('\n', '');
        adjacencyVerticies = line.split(' ');
        adjacencyVerticies = remove_values_from_list(adjacencyVerticies, '');
        for adjacencyVertex in adjacencyVerticies:
            graph.add_edge(mainVertex, int(adjacencyVertex));
        mainVertex += 1;
    file.close();
    return graph;

# test vysledkov
def cageVerification(cage,k,g):
    M = calculateMooreBound(k,g);
    minPocetHran = numberOfEdgesByMooreBound(M,k);
#     verifikacia poctu vrcholov
    if len(cage.vertices()) < M or len(cage.incidence_matrix().column(0)) < M:
        return False;
#     verifikacia poctu hran
    if len(cage.edges()) < minPocetHran or len(cage.incidence_matrix().row(0)) < minPocetHran:
        return False;
    return True;

main()
︡850b5763-d47c-4358-8910-5a90c438511e︡{"stdout":"[1] Súbor IncidenceMatrices/L_Cage_3_5.txt ból úspešne vytvorený! Doba trvania: 0.290976s\n"}︡{"stdout":"\n[2] Súbor IncidenceMatrices/L_Cage_6_4.txt ból úspešne vytvorený! Doba trvania: 0.192065s\n"}︡{"stdout":"\n[3] Súbor IncidenceMatrices/L_Cage_3_6.txt ból úspešne vytvorený! Doba trvania: 0.005323s\n\n[4] Súbor IncidenceMatrices/L_Cage_4_5.txt ból úspešne vytvorený! Doba trvania: 1.917155s\n"}︡{"stdout":"\n[5] Súbor IncidenceMatrices/L_Cage_3_7.txt ból úspešne vytvorený! Doba trvania: 0.074019s\n\n[6] Súbor IncidenceMatrices/L_Cage_3_8.txt ból úspešne vytvorený! Doba trvania: 0.007299s\n\n[7] Súbor IncidenceMatrices/L_Cage_7_5.txt ból úspešne vytvorený! Doba trvania: 0.197461s\n"}︡{"stdout":"\n[8] Súbor IncidenceMatrices/L_Cage_4_7.txt ból úspešne vytvorený! Doba trvania: 0.114142s\n"}︡{"stdout":"\n[9] Súbor IncidenceMatrices/L_Cage_3_10.txt ból úspešne vytvorený! Doba trvania: 0.181021s\n"}︡{"stdout":"\n[10] Súbor IncidenceMatrices/L_Cage_3_11.txt ból úspešne vytvorený! Doba trvania: 0.709106s\n"}︡{"stdout":"\n[11] Súbor IncidenceMatrices/L_Cage_10_5.txt ból úspešne vytvorený! Doba trvania: 1.408383s\n"}︡{"stdout":"\n[12] Súbor IncidenceMatrices/L_Cage_11_5.txt ból úspešne vytvorený! Doba trvania: 4.792309s\n"}︡{"stdout":"\n[13] Súbor IncidenceMatrices/L_Cage_12_5.txt ból úspešne vytvorený! Doba trvania: 3.01649s\n"}︡{"stdout":"\n[14] Súbor IncidenceMatrices/L_Cage_4_9.txt ból úspešne vytvorený! Doba trvania: 1.21462s\n"}︡{"stdout":"\n[15] Súbor IncidenceMatrices/L_Cage_13_5.txt ból úspešne vytvorený! Doba trvania: 2.982052s\n"}︡{"stdout":"\n[16] Súbor IncidenceMatrices/L_Cage_4_10.txt ból úspešne vytvorený! Doba trvania: 2.69821s\n"}︡{"stdout":"\n[17] Súbor IncidenceMatrices/L_Cage_3_14.txt ból úspešne vytvorený! Doba trvania: 2.003471s\n"}︡{"stdout":"\n[18] Súbor IncidenceMatrices/L_Cage_7_7.txt ból úspešne vytvorený! Doba trvania: 12.797767s\n"}︡{"stdout":"\n[19] Súbor IncidenceMatrices/L_Cage_3_16.txt ból úspešne vytvorený! Doba trvania: 11.500814s\n"}︡{"stdout":"\n[20] Súbor IncidenceMatrices/L_Cage_7_8.txt ból úspešne vytvorený! Doba trvania: 14.190214s\n"}









