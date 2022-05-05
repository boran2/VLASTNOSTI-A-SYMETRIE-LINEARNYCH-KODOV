import os
from pickle import TRUE
from Constants import Constants
from Formatters import Formatters
from LinearCode import LinearCode
from Cage import Cage
from AutomorphismDetail import AutomorphismDetail
import datetime


class AutomorphismMenu:
    
    const = Constants()
    formatters = Formatters()
    def __init__(self, k, g, isShowable, isCage):
        self.k = k
        self.g = g
        self.isShowable = isShowable
        self.isCage = isCage

    # hlavicka programu
    def displayTitleBar(self):
        os.system(self.const.CLEAR)      
        print(self.formatters.getHeader(self.formatters.getTitle(self.k,self.g,self.isCage,self.const.AUTOMORPHISM_GROUP)))
        
    # zoznam moznosti v menu
    def getUserChoiceCage(self):
        graph = Cage(self.k,self.g)
        cage = graph.getCage()
        permutations = graph.getPermutationsOfAutomorphisms(cage)
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(21).format(self.const.N_AUTOMORPHISM_FROM, self.const.CAGE, self.k, self.g, len(permutations) + 1))
        else:
            print(self.formatters.getFormatter(21).format(self.const.N_AUTOMORPHISM_FROM, self.const.REC, self.k, self.g, len(permutations) + 1))
        if len(permutations) > 1:
            print(self.formatters.getFormatter(27).format(self.const.CHOOSE_AUTOMORPHISM))
        for i in range(len(permutations)):
            print(self.formatters.getFormatter(16).format(i+1, self.const.AUTOMORPHISM, permutations[i]))
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.CAGE, self.k, self.g, self.const.MENU))
        else:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.REC, self.k, self.g, self.const.MENU))  
        return input()  

    # vyvolanie akcie na zaklade vyberu moznosti - zobrazenie grupy automorfizmov z grafu
    def createFromCage(self):
        graph = Cage(self.k,self.g)
        choice = ''
        cage = graph.getCage()
        permutations = graph.getPermutationsOfAutomorphisms(cage)
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()  
            choice = self.getUserChoiceCage()
            self.displayTitleBar()

            for i in range(len(permutations)):
                if choice == str(i+1):
                    AutomorphismDetail(self.k, self.g, permutations[i], self.isShowable, str(i+1), self.isCage).showAutomorphism()
  
            if choice == self.const.OPTION_X:
                break

    #    navrat
    def getUserChoiceCode(self):
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(22).format(self.const.OPTION_X, self.const.BACK_TO, self.const.CAGE, self.k, self.g, self.const.LINEAR_CODE, self.const.MENU)) 
        else:
           print(self.formatters.getFormatter(22).format(self.const.OPTION_X, self.const.BACK_TO, self.const.REC, self.k, self.g, self.const.LINEAR_CODE, self.const.MENU)) 
        return input()


    #    zobrazenie grupy automorfizmov z linearneho kodu
    def createFromLinearCode(self):
        linearCode = LinearCode(self.k,self.g,self.isCage)
        choice = ''
        permutations = linearCode.getPermutationsOfAutomorphisms()

        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            if self.isCage == TRUE:
                print(self.formatters.getFormatter(23).format(self.const.N_AUTOMORPHISM_FROM, self.const.CAGE, self.k, self.g, self.const.FROM_CODE, len(permutations) + 1))
            else:
                 print(self.formatters.getFormatter(23).format(self.const.N_AUTOMORPHISM_FROM, self.const.REC, self.k, self.g, self.const.FROM_CODE, len(permutations) + 1))
            for i in range(len(permutations)):
                print(self.formatters.getFormatter(18).format(i+1, self.const.NTH_AUTOMORPHISM, permutations[i]))
            choice = self.getUserChoiceCode()
            self.displayTitleBar()
  
            if choice == self.const.OPTION_X:
                break

    #    ulozenie grupy automorfizmov z linearneho kodu
    def saveAutomorphismGroup(self):
        linearCode = LinearCode(self.k,self.g,self.isCage)
        choice = ''
        permutations = linearCode.getPermutationsOfAutomorphisms()
        if not os.path.exists(self.const.AUTOMORPHISM_GROUP_DIRECTORY):
            os.makedirs(self.const.AUTOMORPHISM_GROUP_DIRECTORY)
        startTime = datetime.datetime.now()
        file = open(self.formatters.getFormatter(12).format(self.const.AUT_GROUP_CAGE_DIR_PREFIX,self.k,self.g,self.const.AUT_GROUP_SUFFIX,self.const.TEXT_FILE),'w')
        file.write("[\n")
        for i in range(len(permutations)):
            file.write("\t{}".format(permutations[i]))
            if i < len(permutations) - 1:
                file.write(",")
            file.write("\n")
        file.write("]")
        file.close()
        time = datetime.datetime.now() - startTime
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()
            print(self.formatters.getFormatter(28).format(self.const.AUT_GROUP_FILE_PREFIX, self.k, self.g, self.const.AUT_GROUP_SUFFIX, self.const.SUCCESS_CREATE, time.total_seconds()))
            choice = self.getUserChoiceCode()  
            self.displayTitleBar()
            if choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))