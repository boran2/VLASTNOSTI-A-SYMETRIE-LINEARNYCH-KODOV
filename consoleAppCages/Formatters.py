from pickle import TRUE

from Constants import Constants

class Formatters:
    const = Constants()

     # vrati sformatovanu hlavicku
    def getHeader(self, title):
        countCharsInString = len(str(title))
        border = '*'*countCharsInString
        return self.getFormatter(8).format(border, title, border)

    # vrati sformatovany nazov menu
    def getTitle(self,k,g, isCage, typeMenu):
        spaceInString = len(str(k)) + len(str(g))
        title = self.const.LEFT_BORDER
        if isCage == TRUE:
            title += self.getFormatter(5).format(self.const.CAGE,k,g,typeMenu)
        else:
            title += self.getFormatter(6).format(self.const.REC,k,g,typeMenu)
        if spaceInString == 3:
            title += self.const.RIGHT_BORDER_SMALL
        if spaceInString == 2:
            title += self.const.RIGHT_BORDER_BIG
        return title

    # sformatuje vystup
    def getFormatter(self, formatter):
            switcher = {
                1:"\n\t{}\n",
                2:"\n\t     [{}] {}",
                3:"\n\t     {}\t\n",
                4:"\t\t  [{}] {}",
                5:"{}({},{}) {}",
                6:"{}({},{}) {} ",
                7:"\t\t  [{}] {}{}",
                8: "\t{}\n\t{}\n\t{}",
                9:"{}{}_{}{}",
                10:"\n\t\t{} {} \n",
                11:"\n\t   {} \n\n{}\t",
                12:"{}{}_{}{}{}",
                13:"\n\t     [{}] {} {} {}",
                14:"\n\t     {}\n\n{}\n",
                15:"\n\t\t{} {} x {} \n",
                16:"\t\t[{}] {}     {}",
                17:"{}{} {} {}{}",
                18:"\t\t{}{}     {}\t",
                19: "{}{}. {} {} {}{}",
                20: "\n\t   [{}] {} {}({},{}) {}",
                21:"\n\t     {} {}({},{}): {}\n",
                22: "\n\t     [{}] {} {}({},{}) {} {}",
                23:"\n\t     {} {}({},{}) {} {}\n",
                24:"\n\t\t{}_{}_{}.txt {} {}s\n",
                25:"\n\n\t   {}\n\n{}\n\n\n\t   {}\n\n{}\n\n\n\t   {}\n\n{}\n\n",
                26:"\n\t  {}{} \n\n\t  {}{} \n\n\t  {}{} \n\n\t  {}{} x {} \n\n\t  {}{} x {} \n\n\t  {}{} \n",
                27:"\t\t{}\n ",
                28:"\n\t\t{}_{}_{}{}.txt {}{}s\n",
            }
            return switcher.get(formatter, "\t ")