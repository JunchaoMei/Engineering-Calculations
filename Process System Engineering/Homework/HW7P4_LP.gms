$TITLE HW7P4_LP
$OFFSYMXREF
$OFFSYMLIST

 VARIABLES  QS11,QS12,QS13,QS23,QS24,Q1W4,Q2W4,Q112,Q113,Q123,Q124,Q213,Q223,Q224, RS1,RS2,RS3,R12,R13,R23, QS,QW, COST;
 POSITIVE VARIABLES QS,QW, QS11,QS12,QS13,QS23,QS24,Q1W4,Q2W4,Q112,Q113,Q123,Q124,Q213,Q223,Q224, RS1,RS2,RS3,R12,R13,R23;
* BINARY VARIABLES Y1;

 EQUATIONS  CON1,CON2,CON3,CON4,CON5,CON6,CON7,CON8,CON9,CON10,CON11,CON12,CON13,CON14,CON15,CON16,CON17, OBJ;

 CON1..     -QS+RS1+QS11 =E= -0;
 CON2..     QS11 =E= 30;
 CON3..     -RS1+RS2+QS12 =E= 0;
 CON4..     Q112+R12 =E= 60;
 CON5..     QS12+Q112 =E= 90;
 CON6..     -RS2+RS3+QS13+QS23 =E= 0;
 CON7..     -R12+R13+Q113+Q123 =E= 160;
 CON8..     R23+Q213+Q223 =E= 320;
 CON9..     QS13+Q113+Q213 =E= 240;
 CON10..    QS23+Q123+Q223  =E= 117;
 CON11..    -RS3+QS24 =E= 0;
 CON12..    -R13+Q124+Q1W4 =E= 60;
 CON13..    -R23+Q224+Q2W4 =E= 120;
 CON14..    QS24+Q124+Q224 =E= 78;
 CON15..    Q1W4+Q2W4-QW =E= 0;
 CON16..    Q112 =E= 0;
 CON17..    Q113 =E= 0;
 OBJ..      COST =E= QS+QW;

* Upper Bounds
*X1.UP = 4;

* Initial point
*Y1.L = 1;

 MODEL HW7P4_LP  / ALL / ;

 OPTION LIMROW = 0;
 OPTION LIMCOL = 0;
 OPTION LP = CONOPT;
* OPTION SOLPRINT = OFF;

 SOLVE HW7P4_LP USING LP MINIMIZING COST;
* DISPLAY X.L, Y.L, Z.L;