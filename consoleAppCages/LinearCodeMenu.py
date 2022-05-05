import os
from pickle import TRUE
from AutomorphismMenu import AutomorphismMenu
from Constants import Constants
from Formatters import Formatters
from LinearCode import LinearCode


class LinearCodeMenu:
    
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
        print(self.formatters.getHeader(self.formatters.getTitle(self.k,self.g,self.isCage,self.const.LINEAR_CODE_MENU)))
        
    # zoznam moznosti v menu
    def getUserChoice(self):
        print(self.formatters.getFormatter(3).format(self.const.CHOOSE_FROM_OPTIONS))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_1,self.const.SHOW_G))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_2,self.const.SAVE_G))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_3,self.const.SHOW_DIM_G))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_4,self.const.SHOW_AUTGROUP_C))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_5,self.const.SAVE_AUTGROUP_C))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_6,self.const.SHOW_N_M))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_7,self.const.SHOW_D))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_8,self.const.SHOW_P))

        print("\t  ")
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.CAGE, self.k, self.g, self.const.MENU))
        else:
            print(self.formatters.getFormatter(20).format(self.const.OPTION_X, self.const.BACK_TO, self.const.REC, self.k, self.g, self.const.MENU)) 
        return input()  

    # vyvolanie akcie na zaklade vyberu moznosti
    def create(self):
        lCodeDetail = LinearCode(self.k,self.g,self.isCage)
        choice = ''
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()      
            choice = self.getUserChoice()
            self.displayTitleBar()
            if choice == self.const.OPTION_1:
                lCodeDetail.showGeneratorMatrix()
            elif choice == self.const.OPTION_2:
                lCodeDetail.saveGeneratorMatrix()
            elif choice == self.const.OPTION_3:
                lCodeDetail.showDimOfGeneratorMatrix()
            elif choice == self.const.OPTION_4:
                AutomorphismMenu(self.k,self.g, self.isShowable, self.isCage).createFromLinearCode()
            elif choice == self.const.OPTION_5:
                AutomorphismMenu(self.k,self.g, self.isShowable, self.isCage).saveAutomorphismGroup()
            elif choice == self.const.OPTION_6:
                lCodeDetail.showCodeLengthAndMaxNCodeWords()
            elif choice == self.const.OPTION_7:
                lCodeDetail.showMinimumDistance()
            elif choice == self.const.OPTION_8:
                lCodeDetail.showPerfectCodeParameter()
            elif choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))