︠d55045e9-d9df-4c13-bc9c-53c2dab38e52s︠
import random
import glob
import os

# zoradi textove subory incidencnych matic podla velkosti, nacita ich a zobrazi data
def main():
    filepaths = glob.glob('IncidenceMatrices/*.txt');
    sortedfilepaths = sortIncidenceFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            L = getMatrixFormL(file);
            H = getParityCheckMatrix(L);
            file.close();
            g = Graph(L);
            ver = len(g.vertices());
            edg = len(g.edges(labels=False));
            nHrows = len(H.column(0));
            nHcols = len(H.row(0));
            R = getRate(nHrows,nHcols);
            print(getCageName(sortedfilepaths[i]));
            print("Počet vrcholov ver = {}".format(ver));
            print("Počet hrán edg = {}".format(edg));
            print("Rozmer matice L = {} x {}".format(ver, edg));
            print("Rozmer matice H = {} x {}".format(nHrows,nHcols));
            print("Informačný pomer R = {}".format(R));
            print("Počet automorfizmov AutGroup = {}\n".format(len(g.automorphism_group())));
        else:
            print("Súbor {} je prázdny! Neviem získať incidenčnú maticu L!\n".format(sortedfilepaths[i]));
            continue;

# prevedie obsah suboru do maticovaej formy
def getMatrixFormL(file):
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
    filepath = filepath.replace('IncidenceMatrices/L_','');
    filepath = filepath.replace('cage_','Cage_');
    filepath = filepath.replace('.txt',':');
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

# vrati kontrolnu maticu linearneho kodu ako incidencnu maticu klietky s linearne nezavislymi riadkami matice
def getParityCheckMatrix(L):
    n = len(L.row(0))
    v0 = zero_vector(n)
    Harray = []
    for incidenceRow in L.echelon_form():
        if incidenceRow != v0:
            Harray.append(incidenceRow)
    return matrix(GF(2),Harray)

# zoradi textove subory na zaklade velkosti
def sortIncidenceFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡559291f9-7f01-4275-b04b-78f8e80dcfae︡{"stdout":"Súbor IncidenceMatrices/L_Cage_3_18.txt je prázdny! Neviem získať incidenčnú maticu L!\n\nSúbor IncidenceMatrices/L_Cage_5_10.txt je prázdny! Neviem získať incidenčnú maticu L!\n\nCage_3_5:"}︡{"stdout":"\nPočet vrcholov ver = 10\nPočet hrán edg = 15\nRozmer matice L = 10 x 15\nRozmer matice H = 9 x 15\nInformačný pomer R = 0.4\nPočet automorfizmov AutGroup = 120\n"}︡{"stdout":"\nCage_3_6:\nPočet vrcholov ver = 14\nPočet hrán edg = 21\nRozmer matice L = 14 x 21\nRozmer matice H = 13 x 21\nInformačný pomer R = 0.38095238095238093\nPočet automorfizmov AutGroup = 336\n\nCage_6_4:\nPočet vrcholov ver = 12\nPočet hrán edg = 36\nRozmer matice L = 12 x 36\nRozmer matice H = 11 x 36\nInformačný pomer R = 0.6944444444444444\nPočet automorfizmov AutGroup = 1036800\n\nCage_4_5:\nPočet vrcholov ver = 19\nPočet hrán edg = 38\nRozmer matice L = 19 x 38\nRozmer matice H = 18 x 38\nInformačný pomer R = 0.5263157894736842\nPočet automorfizmov AutGroup = 24\n\nCage_3_7:\nPočet vrcholov ver = 24\nPočet hrán edg = 36\nRozmer matice L = 24 x 36\nRozmer matice H = 23 x 36\nInformačný pomer R = 0.3611111111111111\nPočet automorfizmov AutGroup = 32\n\nCage_3_8:\nPočet vrcholov ver = 30\nPočet hrán edg = 45\nRozmer matice L = 30 x 45\nRozmer matice H = 29 x 45\nInformačný pomer R = 0.35555555555555557\nPočet automorfizmov AutGroup = 1440\n\nCage_3_10:"}︡{"stdout":"\nPočet vrcholov ver = 70\nPočet hrán edg = 105\nRozmer matice L = 70 x 105\nRozmer matice H = 69 x 105\nInformačný pomer R = 0.34285714285714286\nPočet automorfizmov AutGroup = 80\n\nCage_7_5:\nPočet vrcholov ver = 50\nPočet hrán edg = 175\nRozmer matice L = 50 x 175\nRozmer matice H = 49 x 175\nInformačný pomer R = 0.72\nPočet automorfizmov AutGroup = 252000\n\nCage_4_7:"}︡{"stdout":"\nPočet vrcholov ver = 67\nPočet hrán edg = 134\nRozmer matice L = 67 x 134\nRozmer matice H = 66 x 134\nInformačný pomer R = 0.5074626865671642\nPočet automorfizmov AutGroup = 4\n\nCage_3_11:"}︡{"stdout":"\nPočet vrcholov ver = 112\nPočet hrán edg = 168\nRozmer matice L = 112 x 168\nRozmer matice H = 111 x 168\nInformačný pomer R = 0.3392857142857143\nPočet automorfizmov AutGroup = 64\n\nCage_10_5:"}︡{"stdout":"\nPočet vrcholov ver = 124\nPočet hrán edg = 620\nRozmer matice L = 124 x 620\nRozmer matice H = 123 x 620\nInformačný pomer R = 0.8016129032258065\nPočet automorfizmov AutGroup = 1\n\nCage_11_5:"}︡{"stdout":"\nPočet vrcholov ver = 154\nPočet hrán edg = 847\nRozmer matice L = 154 x 847\nRozmer matice H = 153 x 847\nInformačný pomer R = 0.8193624557260921\nPočet automorfizmov AutGroup = 1\n\nCage_4_9:"}︡{"stdout":"\nPočet vrcholov ver = 270\nPočet hrán edg = 540\nRozmer matice L = 270 x 540\nRozmer matice H = 269 x 540\nInformačný pomer R = 0.5018518518518519\nPočet automorfizmov AutGroup = 90\n\nCage_3_14:"}︡{"stdout":"\nPočet vrcholov ver = 384\nPočet hrán edg = 576\nRozmer matice L = 384 x 576\nRozmer matice H = 383 x 576\nInformačný pomer R = 0.3350694444444444\nPočet automorfizmov AutGroup = 96\n\nCage_12_5:"}︡{"stdout":"\nPočet vrcholov ver = 203\nPočet hrán edg = 1218\nRozmer matice L = 203 x 1218\nRozmer matice H = 202 x 1218\nInformačný pomer R = 0.8341543513957307\nPočet automorfizmov AutGroup = 203\n\nCage_4_10:"}︡{"stdout":"\nPočet vrcholov ver = 384\nPočet hrán edg = 768\nRozmer matice L = 384 x 768\nRozmer matice H = 383 x 768\nInformačný pomer R = 0.5013020833333334\nPočet automorfizmov AutGroup = 768\n\nCage_13_5:"}︡{"stdout":"\nPočet vrcholov ver = 230\nPočet hrán edg = 1495\nRozmer matice L = 230 x 1495\nRozmer matice H = 229 x 1495\nInformačný pomer R = 0.8468227424749164\nPočet automorfizmov AutGroup = 1\n\nCage_3_16:"}︡{"stdout":"\nPočet vrcholov ver = 960\nPočet hrán edg = 1440\nRozmer matice L = 960 x 1440\nRozmer matice H = 959 x 1440\nInformačný pomer R = 0.33402777777777776\nPočet automorfizmov AutGroup = 96\n\nCage_7_7:"}︡{"stdout":"\nPočet vrcholov ver = 640\nPočet hrán edg = 2240\nRozmer matice L = 640 x 2240\nRozmer matice H = 639 x 2240\nInformačný pomer R = 0.7147321428571428\nPočet automorfizmov AutGroup = 320\n"}︡{"stdout":"\nCage_7_8:"}︡{"stdout":"\nPočet vrcholov ver = 672\nPočet hrán edg = 2352\nRozmer matice L = 672 x 2352\nRozmer matice H = 671 x 2352\nInformačný pomer R = 0.7147108843537415\nPočet automorfizmov AutGroup = 14112\n\n"}︡{"done":true}︡









