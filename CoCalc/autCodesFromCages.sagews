︠b9df63d2-9784-478f-8097-44f1a4e822e2r︠
import random

def main():
# ***************vstupne data*****************
    k = 3;
    g = 5;
# ********************************************
    print("\nCage("+str(k)+","+str(g)+")\n");
    cageConstruction(k,g);

    print('\nOverenie výpočtom: ');
    testingcontrollDataForPotentionalCage(k,g);


# sledujeme 3 zoznamy uvazovanych klietok s ktorymi porovnavame parametre, pre kazdy zoznam sa grafy generuju inym sposobom
def cageConstruction(k,g):
    sageCages = [[3,5], [3,6], [3,7], [3,8], [3,10], [3,11], [4,5], [7,5]];
    exoosCages = [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]];
    myConstructedCages = [[6,4]];

    cageInput =[];
    cageInput.append(k);
    cageInput.append(g);

    if ((cageInput not in sageCages) and (cageInput not in exoosCages) and (cageInput not in myConstructedCages)):
        print("\nKlietka nie je medzi uvažovanými alebo neexistuje\n");
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
        print("Klietka neexistuje\n");
        return;
    cage = setNonZeroVerticesLabels(cage)
    getAndshowCageInformations(cage,g);

# nastavi vrcholy od 1 po pocet vrcholov pre danu klietku
def setNonZeroVerticesLabels(cage):
    vertices = []
    for vertex in range(len(cage.vertices(sort=False))):
        vertices.append(vertex + 1)
    cage.relabel(vertices)
    return cage

# vrati zoznam automorfizmov z klietky vo forme permutacii
def getPermutationsOfAutomorphisms(cage):
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

# vypocita potencionalnu minimalnu velkost kodu na zaklade Moorovho ohranicenia (testovacie data)
def codeSizeByMooreBound(M,k):
    row = M;
    column = numberOfEdgesByMooreBound(M,k);
    size = str(row) + " x " + str(column);
    return size;

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
    graph.name("Cage (6,4)");
    return graph;

# vrati  incidencnu maticu klietky ziskanu z grafu nad polom Z2
def getIncidenceMatrix(graph):
    return matrix(GF(2), graph.incidence_matrix())


# vrati kontrolnu maticu linearneho kodu ako incidencnu maticu klietky s linearne nezavislymi riadkami matice
def getParityCheckMatrix(graph):
    L = getIncidenceMatrix(graph)
    n = len(L.row(0))
    v0 = zero_vector(n)
    Harray = []
    for incidenceRow in L.echelon_form():
        if incidenceRow != v0:
            Harray.append(incidenceRow)
    return matrix(GF(2),Harray)

# vrati generujucu maticu linearneho kodu
def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

# realne data na zaklade vypooctov z klietky
def getAndshowCageInformations(graph,g):
    graph.show(figsize=10);
    autGroup = len(graph.automorphism_group())
    permutations = getPermutationsOfAutomorphisms(graph)
    print('************************************************************************************************************************************************************************\n');
    print("Grupa automorfizmov AutGroup(Cage) = {}\n\n".format(autGroup));
    Gchecker = [];
    for i in range(len(permutations)):
        p = Permutation(permutations[i]);
        graph.relabel(p);
        Lnew = getIncidenceMatrix(graph);
        Hnew = getParityCheckMatrix(graph);
        Gnew = getGeneratorMatrix(Hnew)
        if Gnew not in Gchecker:
            Gchecker.append(Gnew);
        print("[{}] Automorfizmus {}\n ".format(i+1,permutations[i]));
        graph.show(figsize=10);
        print("Incidenčná matica L:  \n{}\n".format(Lnew));
        print("Kontrolná matica H:  \n{}\n".format(Hnew));
        print("Generujúca matica lineárneho kódu G: \n{}\n".format(Gnew));
    if len(Gchecker) == 1:
        print('Všetky generujúce matice sú identické \n');
    else:
        print(Gchecker);
        print('\n');
    print('************************************************************************************************************************************************************************\n');

# odstranenie hodnot zo zoznamu na zaklade hodnoty
def remove_values_from_list(the_list, val):
    return [value for value in the_list if value != val]

# parsovanie Exoo dokumentov so zoznamami susednych vrcholov na generovanie grafu
def generateGraphandCageFromExoosAdjacencylist(filePath):
    file = open(filePath, "r");
    graph = graphs.EmptyGraph();
    mainVertex = 0;
    for line in file:
        line = line.replace('\n', '');
        adjacencyVerticies = line.split(" ");
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
︡55f734d0-fd89-47f5-b929-f5d35f8955d8︡{"stdout":"\nCage(3,5)\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_m_9mouxt.svg","show":true,"text":null,"uuid":"3857ec84-34a1-4c6f-812b-d70c57d07870"},"once":false}︡{"stdout":"************************************************************************************************************************************************************************\n"}︡{"stdout":"\nGrupa automorfizmov AutGroup(Cage) = 120\n\n\n[1] Automorfizmus (1,6,9,4,3,2)(5,8,7)(10)\n "}︡{"stdout":"\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_0sqjqtll.svg","show":true,"text":null,"uuid":"12123a1c-3009-4ba0-9c55-d956dfda195a"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[2] Automorfizmus (1,5,4,3,2)(6,10,9,8,7)\n \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_sm90jp2u.svg","show":true,"text":null,"uuid":"5aa796b5-76dd-4fe0-b8c9-413fc5556638"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[3] Automorfizmus (1,9,3)(2,6,4)(5,7,8)(10)\n \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_q2g6voiu.svg","show":true,"text":null,"uuid":"246bcd56-64a0-47b1-a8a0-35e5ef0908f3"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[4] Automorfizmus (1,2)(3,6,7,5)(4,8,9,10)\n \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_1jxs24mp.svg","show":true,"text":null,"uuid":"f1be958d-547c-4dfe-9b92-877e3aedcfb6"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[5] Automorfizmus (1,8,5,3)(2,6,10,4)(7,9)\n \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_280s8fpz.svg","show":true,"text":null,"uuid":"5a0ddaf6-7213-4204-ab1b-ec2b842f6a51"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[6] Automorfizmus (1,10,9,3)(2,5,7,4)(6,8)\n \n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1643/tmp_znv4jvfh.svg","show":true,"text":null,"uuid":"7361ea30-aebd-4048-8350-91040bdfbf56"},"once":false}︡{"stdout":"Incidenčná matica L:  \n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n"}︡{"stdout":"\nKontrolná matica H:  \n[1 0 0 0 0 0 0 1 0 0 1 1 0 1 1]\n[0 1 0 0 0 0 0 1 0 0 0 0 0 1 1]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 1 0 0 0 1 0 0 1 1 1 0 1]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 1 0 1 0 0 0 1 1 0 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n\n[7] Automorfizmus (1,4,6,3)(2,5,9,8)(7,10)\n \n"}









