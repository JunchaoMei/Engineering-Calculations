$TITLE HW6_Problem2
$OFFSYMXREF
$OFFSYMLIST

 VARIABLES  Y1,Y2,Y3, X1,X2, f;
 BINARY VARIABLES Y1,Y2,Y3;
 POSITIVE VARIABLES X1,X2;

 EQUATIONS  CON1,CON2,CON3,CON4,CON5,CON6,CON7, OBJ;

 CON1..     SQR(X1-2)-X2 =L= 0;
 CON2..     X1-2*Y1 =G= 0;
 CON3..     X1-X2-4*(1-Y2) =L= 0;
 CON4..     X1-(1-Y1) =L= 0;
 CON5..     X2-Y2 =L= 0;
 CON6..     X1+X2-3*Y3 =G= 0;
 CON7..     Y1+Y2+Y3 =L= 1;
 OBJ..      f =E= Y1+1.5*Y2+0.5*Y3+X1**2+X2**2;

* Upper Bounds
X1.UP = 4;
X2.UP = 4;

* Initial point
Y1.L = 1;
Y2.L = 1;
Y3.L = 1;

 MODEL HW6_Problem2  / ALL / ;

 OPTION LIMROW = 0;
 OPTION LIMCOL = 0;
 OPTION MINLP = DICOPT;
* OPTION SOLPRINT = OFF;

 SOLVE HW6_Problem2 USING MINLP MINIMIZING f;
* DISPLAY X.L, Y.L, Z.L;