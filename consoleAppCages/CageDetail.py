import os
import datetime
from pickle import TRUE
from Cage import Cage
from Constants import Constants
from sage.all import *
from Formatters import Formatters 

class CageDetail:
    const = Constants()
    formatters = Formatters()
    
    def __init__(self, k, g, isCage):
        self.k = k
        self.g = g
        self.isCage = isCage
    
    # hlavicka programu
    def displayTitleBar(self):
        os.system(self.const.CLEAR)       
        print(self.formatters.getHeader(self.formatters.getTitle(self.k,self.g,self.isCage,self.const.DETAIL)))
        
    # zoznam moznosti v menu
    def getUserChoice(self):
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.CAGE, self.k, self.g, self.const.MENU)) 
        else: 
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.REC, self.k, self.g, self.const.MENU)) 
        return input()
    
    # zobrazi graf klietky
    def showGraphOfCage(self):
        graph = Cage(self.k,self.g)
        cage = graph.getCage()
        choice = ''
        cage.show(figsize=10)
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()      
            choice = self.getUserChoice() 
            self.displayTitleBar()
            print("\t  ")
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))
    
    # zobrazi kontrolnu maticu
    def showParityCheckMatrix(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        H = graph.getParityCheckMatrix(cage)
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(11).format(self.const.PARITYCHECK_MATRIX,H))
            choice = self.getUserChoice()
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
               break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))
    
        # zobrazi incidencnu maticu klietky
    def showIncidenceMatrix(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        L = graph.getIncidenceMatrix(cage)
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(11).format(self.const.INCIDENCE_MATRIX,L))
            choice = self.getUserChoice()
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
               break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))
        
    # zobrazi data o klietke
    def showCageData(self):
        graph = Cage(self.k,self.g)
        choice = ''
        M = graph.calculateMooreBound()
        cage = graph.getCage()
        H = graph.getParityCheckMatrix(cage)
        nHrows = len(H.column(0))
        nHcols = len(H.row(0))
        ver = len(cage.vertices())
        edg = len(cage.edges(labels=False))
        R = graph.getRate(nHrows, nHcols)
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(26).format(self.const.MOORE_BOUND,M,self.const.N_VERTICES,ver,self.const.N_EDGES,edg,self.const.SIZE_L,ver,edg,self.const.SIZE_H,nHrows,nHcols,self.const.RATE,R))
            choice = self.getUserChoice()
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))
    
    # ulozi maticu H
    def saveParityCheckMatrix(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        if not os.path.exists(self.const.PARITY_CHECK_MATRIX_DIRECTORY):
            os.makedirs(self.const.PARITY_CHECK_MATRIX_DIRECTORY)
        startTime = datetime.datetime.now()
        H = graph.getParityCheckMatrix(cage)
        file = open(self.formatters.getFormatter(9).format(self.const.H_DIR_PREFIX,self.k,self.g,self.const.TEXT_FILE), 'w')
        file.write(str(H))
        file.close()
        time = datetime.datetime.now() - startTime
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(24).format(self.const.H_FILE_PREFIX, self.k, self.g,self.const.SUCCESS_CREATE,time.total_seconds()))
            choice = self.getUserChoice()  
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))

        # ulozi maticu L
    def saveIncidenceMatrix(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        if not os.path.exists(self.const.INCIDENCE_MATRIX_DIRECTORY):
            os.makedirs(self.const.INCIDENCE_MATRIX_DIRECTORY)
        startTime = datetime.datetime.now()
        L = graph.getIncidenceMatrix(cage)
        file = open(self.formatters.getFormatter(9).format(self.const.L_DIR_PREFIX,self.k,self.g,self.const.TEXT_FILE), 'w')
        file.write(str(L))
        file.close()
        time = datetime.datetime.now() - startTime
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(24).format(self.const.L_FILE_PREFIX, self.k, self.g,self.const.SUCCESS_CREATE,time.total_seconds()))
            choice = self.getUserChoice()  
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))

    # ulozi grupu automorfizmov klietky alebo rec grafu
    def saveAutomorphismGroup(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        permutations = graph.getPermutationsOfAutomorphisms(cage)
        if not os.path.exists(self.const.AUTOMORPHISM_GROUP_DIRECTORY):
            os.makedirs(self.const.AUTOMORPHISM_GROUP_DIRECTORY)
        startTime = datetime.datetime.now()
        file = open(self.formatters.getFormatter(9).format(
            self.const.AUT_GROUP_CAGE_DIR_PREFIX,self.k,self.g,self.const.TEXT_FILE), 'w')
        file.write("[\n")
        for i in range(len(permutations)):
            file.write("\t" +str(permutations[i]))
            if i < len(permutations) - 1:
                file.write(",")
            file.write("\n")
        file.write("]")
        file.close()
        time = datetime.datetime.now() - startTime
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(24).format(
                self.const.AUT_GROUP_FILE_PREFIX, self.k, self.g,self.const.SUCCESS_CREATE,time.total_seconds()))
            choice = self.getUserChoice()  
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))