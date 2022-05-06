# Diplomová práca
téma: VLASTNOSTI A SYMETRIE LINEÁRNYCH KÓDOV DEFINOVANÝCH INCIDENČNÝMI MATICAMI REGULÁRNYCH GRAFOV S MALÝM OBVODOM

## Popis projektu
Lineárne kódy sú podpriestory konečnorozmerných vektrorových priestorov nad konečnými poľami. Majú preto bohaté grupy automorfizmov, ktoré zároveň obsahujú množstvo informácií o uvažovanom kóde. Určenie úplnej grupy automorfizmov kódu je výpočtovo náročná úloha. Namiesto určenia grupy automorfizmov pre daný kód sa preto uvažuje obrátená úloha zostrojenia kódu s predpísanou grupou automorfizmov. Cieľom práce je preskúmať oba smery tejto interakcie.

Jedným zo spôsobov ako je možné vygenerovať binárny lineárny LDPC kód je pomocou klietky (pravidelný k-regulárny graf s obvodom g) alebo rekordného grafu. Z klietok je možné zistiť incidenčnú maticu ako aj grupy automorfizmov. Z incidenčnej matice generujeme kontrolné matice lineárneho kódu, pomocou ktorých vieme získať lineárne kódy, grupu automorfizmov lineárnych kódov ako aj generujúce matice lineárnych kódov. Z grafov aj lineárnych kódov vieme zistiť množstvo informácií, na základe ktorých ich vieme vyhodnotit. Na riešenie problematiky navrhujeme 2 softvérové riešenia, ktoré sa líšia z hľadiska časovej náročnosti, počtu dosiahnutých vysledkov, z hľadiska jednoduchšieho prístupu pre používateľa ako aj vo vlastnosti získať jeden typ výsledku pre všetky grafy naraz. Prvé riešenie je implementované v online aplikácii CoCalc vo forme SageMath skriptov.
Druhé riešenie je implementované ako konzolová aplikácia v programovacom jazyku Python, kde je knižnica SageMath naimportovaná.

## Používateľská príručka pre spustenie softvérových diel projektu
Ako prvý krok je nutné stiahnutie obsahu tohto repozitára do svojho zariadenia pomocou príkazu:
```
  git clone https://github.com/boran2/VLASTNOSTI-A-SYMETRIE-LINEARNYCH-KODOV.git
```


### Používateľská príručka pre spustenie 1. riešenia v online aplikácií CoCalc
1. Registrácia na webovom prehliadači v online aplikácii CoCalc https://cocalc.com/, kde si
používateľ založí prázdny projekt. 

2. Vloženie celého obsahu priečinka CoCalc do prázdneho projektu v online aplikácii CoCalc https://cocalc.com/ . V projekte sa vložením vytvorí
rovnaká štruktúra priečinka CoCalc ako v tomto repozitári.

3. Spustenie 1. riešenia prostredníctvom online editora, v ktorom sa skript otvára dvojitým kliknutím. 

4. Po otvorení a spustení jedného zo skriptov používateľ sleduje výpisy a výstupné textové súbory v priečinkoch IncidenceMatrices, GeneratorMatrices, ParityCheckMatrices, AutomorphismGroups, ktoré sú uložené v priečinku consoleAppCages, poprípade modifikuje vstupné parametre k a g. Je nutné najskôr otvoriť 5 generovacích skriptov v nasledujúcom poradí:
generateIncidenceMatrices.sagews, generateParityCheckMatrices.sagews, generateGeneratorMatrices.sagews, generateAutCodesFromCages.sagews a generateAutGroupLCode.sagews! Zabezpečia sa tým vstupné údaje pre zvyšné skripty.


### Používateľská príručka pre spustenie 2. riešenia v konzolovej aplikácií
1. Na stránke https://www.sagemath.org/, v časti Download je potrebné zvoliť na základe zariadenia buď macOS binaries, Linux/macOS binaries alebo Windows binaries a následne verziu inštalačného súboru, ktorý po stiahnutí a spustení nainštaluje SageMath konzolu do zariadenia používateľa. My sme využili inštalačný súbor SageMath-9.3-Installer-v0.6.3.exe pre operačný systém Windows. 

2. Otvorenie nainštalovanej SageMath konzoly. 

3. Presutie sa v konzole do priečinka consoleAppCages pomocou príkazov "cd" do priečinka consoleAppCages:
```
  cd <folderName>
```
    ....
```
  cd consoleAppCages
```


4. Spustenie 2. riešenia načítaním hlavnej triedy v SageMath console:
``` 
  load(’Run.py’)
```


5. Používateľ sa naviguje podľa voľby možností v konzolovej aplikacii a takisto sleduje okrem výpisov aj výstupné textové súbory v priečinkoch IncidenceMatrices, GeneratorMatrices, ParityCheckMatrices a AutomorphismGroups, ktoré sú uložené v priečinku consoleAppCages

## PDF- verzia
Získavanie výsledkov, generovanie a ukladanie dát, výpočtvá náročnosť sú detailne popísané v dokumente Diplomova_Praca.pdf.

##  linky na publikácie:
https://www.combinatorics.org/ojs/index.php/eljc/article/view/DS16
https://digital.library.adelaide.edu.au/dspace/bitstream/2440/45525/8/02whole.pdf
https://doc.sagemath.org/html/en/reference/graphs/sage/graphs/generic_graph.html
http://assets.cambridge.org/97805217/82807/sample/9780521782807ws.pdf
https://eprint.iacr.org/2012/409.pdf
http://dspace.hebron.edu/jspui/bitstream/123456789/788/1/On%20the%20automorphism%20groups%20of%20some%20linear%20codes.pdf
https://doc.sagemath.org/pdf/en/reference/coding/coding.pdf
https://books.google.sk/books?hl=sk&lr=&id=UTxjBX9lKoMC&oi=fnd&pg=PP13&dq=a+first+course+in+coding+theory+hill&ots=5FjjAq0uTG&sig=j5rDG7eAUBlrzGbZ38VT34DSoH0&redir_esc=y#v=onepage&q=a%20first%20course%20in%20coding%20theory%20hill&f=false
https://publications.waset.org/12279/low-complexity-high-performance-ldpc-codes-based-on-defected-fullerene-graphs
https://www.win.tue.nl/~aeb/codes/binary-1.html
http://cs.indstate.edu/ge/CAGES/index.html
http://opac.crzp.sk/?fn=detailBiblioForm&sid=65CF89236B0A7E124DD17CE040F7&seo=CRZP-detail-kniha

##  link na prácu v LATEX:
overleaf: https://www.overleaf.com/read/fdkwtgxntwjs

##  pôvodný repozitár v GitHub:
link na repozitár, v ktorom ból projekt pôvodne vyvýjaný: https://github.com/boran2/Diplomova-praca


