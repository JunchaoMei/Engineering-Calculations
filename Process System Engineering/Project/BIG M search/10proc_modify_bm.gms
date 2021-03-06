$title LogMIP User's Manual Example 3 - Synthesis of 10 Processe (LOGMIP3,SEQ=336)
$ontext
This model selects optimal processes from within a given superstructure.

References:

MARCO DURAN , PH.D. THESIS , 1984. CARNEGIE-MELLON UNIVERSITY,
   PITTSBURGH , PA.

Turkay & Grossmann, LOGIC-BASED MINLP ALGORITHMS FOR THE OPTIMAL
   SYNTHESIS OF PROCESS NETWORKS, Computers and Chemical Engineering 20,
   8, p. 959-978, 1996

Aldo Vecchietti, LogMIP User's Manual, http://www.logmip.ceride.gov.ar/
$offtext


 SETS   J      PROCESS STREAMS                 / 1*29 /
        I      PROCESS UNITS                   / 1*10 /



 PARAMETERS   P(J)     VARIABLE COST COEFF FOR PROCESS UNITS - STREAMS/
                             3 = -10  ,  5 = -15  ,  9 = -40
                            19 =  25  , 21 =  35  , 25 = -35
                            17 =  80  , 14 =  15  , 10 =  15
                             2 =  1   ,  4 =  1   , 18 = -65
                            20 = -60  , 22 = -80  , 27 = -70
                            29 = -65  /;

 VARIABLES  TOTAL_COST;
scalar scalarq,mtry;

 BINARY VARIABLES    Y(I);
 POSITIVE VARIABLES  X(J) , C(I) ;
 EQUATIONS

* EQUATIONS COMMON TO NLP SUBPROBLEMS AND MASTER PROBLEMS:
* --------------------------------------------------------
AL1
AL2
AL3
AL4
AL5
AL6
AL7
AL8

AS1
AS2
AS3
AS4


* EQUATIONS FOR THE NLP SUBPROBLEMS ONLY:
* ---------------------------------------
            T11      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 1
            T12
            T13
            T14
            T15
            T21      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 2
            T22
            T23
            T24
            T25
            T31      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 3
            T32
            T33
            T34
            T35
            T36
            T41      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 4
            T42
            T43
            T44
            T45
            T46
            T51      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 5
            T52
            T53
            T54
            T55
            T61      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 6
            T62
            T63
            T64
            T65
            T71      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 7
            T72
            T73
            T74
            T75
            T81      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 8
            T82
            T83
            T84
            T85
            T86
            T91      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 9
            T92
            T93
            T94
            T95
            T101     INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 10
            T102
            T103
            T104
            T105
            OBJETIVO          OBJECTIVE FUNCTION DEFINITION   ;


* BOUNDS SECTION:
* ---------------
 X.UP('3')  =  2.0 ;
 X.UP('5')  =  2.0 ;
 X.UP('9')  =  2.0 ;
 X.UP('10') =  1.0 ;
 X.UP('14') =  1.0 ;
 X.UP('17') =  2.0 ;
 X.UP('19') =  2.0 ;
 X.UP('21') =  2.0 ;
 X.UP('25') =  3.0 ;
 X.UP('26') =  1.0 ;
 X.UP('27') =  3.0 ;
 X.UP('28') =  1.0 ;
 X.UP('29') =  1.0 ;

* EQUATIONS COMMON TO NLP SUBPROBLEMS AND MASTER PROBLEMS:
* --------------------------------------------------------
 AL1    ..   X('13')         =E=  X('19') + X('21')  + X('26') ;
 AL2    ..   X('17')         =E=  X('9') + X('16') + X('25') ;
 AL3    ..   X('11')         =E=  X('12') + X('15') + X('28') ;
 AL4    ..   X('3') + X('5') =E=  X('6') + X('11')           ;
 AL5    ..   X('6')          =E=  X('7') + X('8')            ;
 AL6    ..   X('23')         =E=  X('20') + X('22') + X('27') + X('29') ;
 AL7    ..   X('23')         =E=  X('14') + X('24')          ;
 AL8    ..   X('1')          =E=  X('2') + X('4')            ;

 AS1    ..   X('10')  =L=  0.8 * X('17')                     ;
 AS2    ..   X('10')  =G=  0.4 * X('17')                     ;
 AS3    ..   X('12')  =L=  5.0 * X('14')                     ;
 AS4    ..   X('12')  =G=  2.0 * X('14')                     ;



T11..   EXP(X('3')) -1. =L= X('2')            ;
T14..   C('1') =G= 5                         ;
T15..   C('1') =L= 5                         ;
T12..   X('2') =L= 0                          ;
T13..   X('3') =L= 0                          ;

T21..   EXP(X('5')/1.2) -1. =L= X('4')        ;
T24..   C('2') =G= 8                         ;
T25..   C('2') =L= 8                         ;
T22..   X('4') =L= 0                          ;
T23..   X('5') =L= 0                          ;

T31..   1.5 * X('9') + X('10') =L= X('8')     ;
T35..   C('3') =G= 6                         ;
T36..   C('3') =L= 6                         ;
T32..   X('8') =L= 0                          ;
T33..   X('9') =L= 0                          ;
T34..   X('10') =L= 0                         ;

T41..   X('13')/1.5 =L= X('12')+X('14')     ;
T45..   C('4') =G= 10                        ;
T46..   C('4') =L= 10                        ;
T42..   X('12') =L= 0                         ;
T43..   X('13') =L= 0                         ;
T44..   X('14') =L= 0                         ;

T51..   2. * X('16') =L= X('15')              ;
T54..   C('5') =G= 6                         ;
T55..   C('5') =L= 6                         ;
T52..   X('15') =L= 0                         ;
T53..   X('16') =L= 0                         ;

T61..   EXP(X('20')/1.5) -1. =L= X('19')      ;
T64..   C('6') =G= 7                         ;
T65..   C('6') =L= 7                         ;
T62..   X('19') =L= 0                         ;
T63..   X('20') =L= 0                         ;

T71..   EXP(X('22')) -1. =L= X('21')          ;
T74..   C('7') =G= 4                         ;
T75..   C('7') =L= 4                         ;
T72..   X('21') =L= 0                         ;
T73..   X('22') =L= 0                         ;

T81..   EXP(X('18')) -1. =L= X('10') + X('17');
T85..   C('8') =G= 5                         ;
T86..   C('8') =L= 5                         ;
T82..   X('10') =L= 0                         ;
T83..   X('17') =L= 0                         ;
T84..   X('18') =L= 0                         ;

T91..   EXP(X('27')/1.2) -1. =L= X('26')     ;
T94..   C('9') =G= 6                         ;
T95..   C('9') =L= 6                         ;
T92..   X('26') =L= 0                         ;
T93..   X('27') =L= 0                         ;

T101..  EXP(X('29')/1.9) -1. =L= X('28')     ;
T104..  C('10') =G= 1                        ;
T105..  C('10') =L= 1                        ;
T102..  X('28') =L= 0                        ;
T103..  X('29') =L= 0                        ;

 OBJETIVO  .. TOTAL_COST  =E= SUM(I,C(I)) + SUM(J,P(J)*X(J)) + 122 ;


* EQUATIONS DEFINING THE PROPOSITIONAL LOGIC:
* --------------------------------------------------------

equations c1, c2, c3, c4, c5, c6, c7, c8,
          c9, c10, c11, c12, c13, c14, c15;

 C1.. Y('1') + Y('2') =l=1;
 C2.. Y('4') + Y('5') + Y('10') =l=1;
 C3.. Y('6') + Y('7') + Y('9') =l=1;
 C4.. (1-Y('1')) + Y('3') + Y('4') + Y('5') + Y('10') =g=1;
 C5.. (1-Y('2')) + Y('3') + Y('4') + Y('5') + Y('10') =g=1;
 C6.. (1-Y('3')) + Y('8') =g=1;
 C7.. (1-Y('3')) + Y('1') + Y('2') =g=1;
 C8.. (1-Y('4')) + Y('1') + Y('2') =g=1;
 C9.. (1-Y('4')) + Y('6') + Y('7') + Y('9') =g=1;
 C10.. (1-Y('5')) + Y('1') + Y('2') =g=1;
 C11.. (1-Y('5')) + Y('8') =g=1;
 C12.. (1-Y('6')) + Y('4') =g=1;
 C13.. (1-Y('7')) + Y('4') =g=1;
 C14.. (1-Y('10')) + Y('1') + Y('2') =g=1;
 C15.. (1-Y('9')) + Y('4') =g=1;


MODEL PROC10 / ALL / ;
file output /"gamsoutput.txt"/;
file emp / "%emp.info%" /;
output.ap=1;

for(scalarq= 100 downto 1 by 1,

Mtry=scalarq;
put emp '*--- start EMP  %gams.i%'; emp.silent=0;

put / "disjunction   bigM" Mtry "Y('1')" T11.tn " "T14.tn " "T15.tn
    / "     else     " T12.tn " "T13.tn ;

put / "disjunction   bigM" Mtry "Y('2') " T21.tn " "T24.tn " "T25.tn
    / "     else      " T22.tn " "T23.tn ;

put / "disjunction   bigM" Mtry "Y('3') " T31.tn " "T35.tn " "T36.tn
    / "     else      " T32.tn " "T33.tn " "T34.tn ;

put / "disjunction   bigM" Mtry "Y('4') " T41.tn " "T45.tn " "T46.tn
    / "     else      " T42.tn " "T43.tn " "T44.tn ;

put / "disjunction   bigM" Mtry "Y('5') " T51.tn " "T54.tn " "T55.tn
    / "     else      " T52.tn " "T53.tn ;

put / "disjunction   bigM" Mtry "Y('6') " T61.tn " "T64.tn " "T65.tn
    / "     else      " T62.tn " "T63.tn ;

put / "disjunction   bigM" Mtry "Y('7') " T71.tn " "T74.tn " "T75.tn
    / "     else      " T72.tn " "T73.tn ;

put / "disjunction   bigM" Mtry "Y('8') " T81.tn " "T85.tn " "T86.tn
    / "     else      " T82.tn " "T83.tn " "T84.tn ;

put / "disjunction   bigM" Mtry "Y('9') " T91.tn " "T94.tn " "T95.tn
    / "     else      " T92.tn " "T93.tn ;

put / "disjunction   bigM" Mtry "Y('10') " T101.tn " "T104.tn " "T105.tn
    / "     else      " T102.tn " "T103.tn ;

putclose emp / '*--- end EMP';




option optcr = 0.00001;

SOLVE PROC10 USING emp MINIMIZING TOTAL_COST;
put output  Mtry:10:0, TOTAL_COST.l:10:0 ;

)
putclose output;
