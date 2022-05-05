import os
from pickle import TRUE
from Cage import Cage
from Constants import Constants
from Formatters import Formatters
from sage.all import *

class AutomorphismDetail:
    const = Constants()
    formatters = Formatters()
    
    def __init__(self, k, g, permutation, isShowable, id, isCage):
        self.permutation = permutation
        self.k = k
        self.g = g
        self.isShowable = isShowable
        self.id = id
        self.isCage = isCage
    
    # hlavicka programu
    def displayTitleBar(self):
        os.system(self.const.CLEAR)
        title = self.formatters.getFormatter(19).format(self.const.LEFT_BORDER,self.id,self.const.AUTOMORPHISM,self.permutation,self.const.DETAIL,self.const.RIGHT_BORDER_BIG)      
        print(self.formatters.getHeader(title))
        
    # zoznam moznosti v menu
    def getUserChoice(self):
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.CAGE, self.k, self.g, self.const.AUTOMORPHISM_GROUP))
        else:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.REC, self.k, self.g, self.const.AUTOMORPHISM_GROUP)) 
        return input()
    
    # zobrazi graf obrazu kliekty pokial je to mozne 
    # a vygeneruje jeho kontrolnu a gener maticu  
    def showAutomorphism(self):
        graph = Cage(self.k,self.g)
        cage = graph.getCage()
        p = Permutation(self.permutation)
        cage.relabel(p)

        # podmienka prehladneho zobrazenia
        if (self.isShowable):
            cage.show(figsize=10)

        L = graph.getIncidenceMatrix(cage)
        H = graph.getParityCheckMatrix(cage)
        C = codes.from_parity_check_matrix(H)
        G = C.systematic_generator_matrix()
        choice = ''

        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(25).format(self.const.INCIDENCE_MATRIX, L, self.const.PARITYCHECK_MATRIX, H, self.const.GENERATOR_MATRIX, G))
            choice = self.getUserChoice() 
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))