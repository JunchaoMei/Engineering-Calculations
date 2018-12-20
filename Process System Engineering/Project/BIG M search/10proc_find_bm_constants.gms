$title LogMIP User's Manual Example 3 - Synthesis of 8 Processe (LOGMIP3,SEQ=336)
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


 SETS   J      PROCESS STREAMS                 / 1*30 /
        I      PROCESS UNITS                   / 1*10 /



 free VARIABLE  Z;
 POSITIVE VARIABLES  X(J) , C(I) ;
 Positive variable M(I);
 EQUATIONS


* EQUATIONS FOR THE NLP SUBPROBLEMS ONLY:
* ---------------------------------------
            T11      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 1
            T21
            T31      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 3
            T41      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 4
            T51      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 5
            T61      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 6
            T71      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 7
            T81      INPUT-OUTPUT RELATIONS FOR PROCESS UNIT 8
            T91
            T101
            OBJETIVO          OBJECTIVE FUNCTION DEFINITION   ;


*Added bounds
*--------------------
 X.UP(j)=5;
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







T11..   EXP(X('3')) -1.-X('2') =G=M('1')             ;
T21..   EXP(X('5')/1.2) -1.- X('4')  =G= M('2')      ;
T31..   1.5 * X('9') + X('10') -X('8')=G=M('3')      ;
T41..   X('13')/1.5-( X('12')+X('14')) =G= M('4')    ;
T51..   2. * X('16')-X('15')   =G= M('5')             ;
T61..   EXP(X('20')/1.5) -1.-X('19') =G=  M('6')     ;
T71..   EXP(X('22')) -1. - X('21')  =G= M('7')        ;
T81..   EXP(X('18')) -1. -( X('10') + X('17'))=G=M('8');
T101..  EXP(X('29')/1.9) -1. - X('28')=G=M('10')     ;
T91..   EXP(X('27')/1.2) -1. - X('26')=G=M('9')     ;


OBJETIVO.. z=E=sum(i,M(i)) ;


Model Relaxed
/
            T11
            T21
            T31
            T41
            T51
            T61
            T71
            T81
            T91
            T101
            OBJETIVO/;
Solve Relaxed using NLP maximizing z;
MODEL PROC8 / ALL / ;

