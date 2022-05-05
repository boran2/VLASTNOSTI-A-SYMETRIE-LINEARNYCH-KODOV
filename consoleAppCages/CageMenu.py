import os
from pickle import TRUE
from CageDetail import CageDetail
from Constants import Constants
from Formatters import Formatters
from LinearCodeMenu import LinearCodeMenu
from AutomorphismMenu import AutomorphismMenu

class CageMenu:
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
        print(self.formatters.getHeader(self.formatters.getTitle(self.k,self.g,self.isCage,self.const.MENU)))
    
        # zoznam moznosti v menu
    def getUserChoice(self):
        print(self.formatters.getFormatter(3).format(self.const.CHOOSE_FROM_OPTIONS))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_1,self.const.SHOW_L))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_2,self.const.SAVE_L))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_3,self.const.SHOW_H))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_4,self.const.SAVE_H))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_5,self.const.SHOW_DATA))
        if self.isCage == TRUE:
            print(self.formatters.getFormatter(4).format(self.const.OPTION_6,self.const.SHOW_AUTGROUP_CAGE))
            print(self.formatters.getFormatter(4).format(self.const.OPTION_7,self.const.SAVE_AUTGROUP_CAGE))
        else:
            print(self.formatters.getFormatter(4).format(self.const.OPTION_6,self.const.SHOW_AUTGROUP_REC))
            print(self.formatters.getFormatter(4).format(self.const.OPTION_7,self.const.SAVE_AUTGROUP_REC))
        print(self.formatters.getFormatter(4).format(self.const.OPTION_8,self.const.SHOW_CODE))
        if self.isShowable == TRUE:
            print(self.formatters.getFormatter(4).format(self.const.OPTION_9,self.const.SHOW_GRAPH))
        print(self.formatters.getFormatter(13).format(self.const.OPTION_X, self.const.BACK_TO, self.const.MAIN, self.const.MENU))  
        return input()

    # vyvolanie akcie na zaklade vyberu moznosti
    def create(self):
        choice = ''
        while choice != self.const.OPTION_X:    
            self.displayTitleBar()      
            choice = self.getUserChoice()
            self.displayTitleBar()
            if choice == self.const.OPTION_1:
                CageDetail(self.k,self.g,self.isCage).showIncidenceMatrix()
            elif choice == self.const.OPTION_2:
                CageDetail(self.k,self.g,self.isCage).saveIncidenceMatrix()
            elif choice == self.const.OPTION_3:
                CageDetail(self.k,self.g,self.isCage).showParityCheckMatrix()
            elif choice == self.const.OPTION_4:
                CageDetail(self.k,self.g,self.isCage).saveParityCheckMatrix()
            elif choice == self.const.OPTION_5:
                CageDetail(self.k,self.g,self.isCage).showCageData()
            elif choice == self.const.OPTION_6:
                AutomorphismMenu(self.k,self.g,self.isShowable,self.isCage).createFromCage()
            elif choice == self.const.OPTION_7:
                CageDetail(self.k,self.g,self.isCage).saveAutomorphismGroup()
            elif choice == self.const.OPTION_8:
                LinearCodeMenu(self.k,self.g,self.isShowable,self.isCage).create()
            elif choice == self.const.OPTION_9 and self.isShowable == TRUE:
                CageDetail(self.k,self.g,self.isCage).showGraphOfCage()
            elif choice == self.const.OPTION_X:
                break
            else:
                print(self.formatters.getFormatter(1).format(self.const.OTHER_OPTION))