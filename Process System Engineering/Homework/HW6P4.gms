$TITLE HW6_Problem4
$OFFSYMXREF
$OFFSYMLIST

 VARIABLES  Y1,Y2,Y3, X1,X2,X3,X4,X5,X6,X7, income,cost,fixed_cost,variable_cost,Z;
 BINARY VARIABLES Y1,Y2,Y3;
 POSITIVE VARIABLES X1,X2,X3,X4,X5,X6,X7;

 EQUATIONS  CON1,CON2,CON3,CON4,CON5,CON6,CON7,CON8,CON9,CON10, OBJ;

 CON1..     income-13000*X7 =E= 0;
 CON2..     cost-fixed_cost-variable_cost =E= 0;
 CON3..     fixed_cost-3500*Y1-1000*Y2-1500*Y3 =E= 0;
 CON4..     variable_cost-1800*X1-1800*X2-1000*X3-1200*X4-7000*X5-2000*X7 =E= 0;
 CON5..     X7-0.9*X6 =E= 0;
 CON6..     X3-log(1+X1) =E= 0;
 CON7..     X4-1.2*log(1+X2) =E= 0;
 CON8..     X6-X3-X4-X5 =E= 0;
 CON9..     X7-Y1 =L= 0;
 CON10..    X3-5*Y2 =L= 0;
 OBJ..      Z =E= cost-income;

* Upper Bounds
X7.UP = 1;

* Initial point
*Y1.L = 1;

 MODEL HW6_Problem4  / ALL / ;

 OPTION LIMROW = 0;
 OPTION LIMCOL = 0;
 OPTION MINLP = DICOPT;
* OPTION SOLPRINT = OFF;

 SOLVE HW6_Problem4 USING MINLP MINIMIZING Z;
* DISPLAY X.L, Y.L, Z.L;
