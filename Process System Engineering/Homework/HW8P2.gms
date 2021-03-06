$TITLE HW8P2
$OFFSYMXREF
$OFFSYMLIST

 VARIABLES  a1,a2,a3,a4,a5,a6,a7,a8,a9,a10, y1,y2,y3,y4,y5,y6,y7,y8,y9,y10, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10, F1,F2,F3,F4,F5,F6,F7,F8,F9,F10, Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10, K1,K2,K3,K4,K5,K6,K7,K8,K9,K10, xA,xB,xC,xD, e1A,e1BCD,e2AB,e2CD,e3ABC,e3D,e4B,e4CD,e5BC,e5D,e6A,e6BC,e7AB,e7C,e8C,e8D,e9B,e9C,e10A,e10B, CW,Steam,F,COST;
 POSITIVE VARIABLES F1,F2,F3,F4,F5,F6,F7,F8,F9,F10;
 BINARY VARIABLES y1,y2,y3,y4,y5,y6,y7,y8,y9,y10;

 EQUATIONS  CON1,CON2,CON3,CON4,CON5,CON6,CON7,CON8,CON9,CON10,CON11,CON12,CON13,CON14,CON15,CON16,CON17,CON18,CON19,CON20,CON21,CON22,CON23,CON24,CON25,CON26,CON27,CON28,CON29,CON30,CON31,CON32,CON33,CON34,CON35,CON36,CON37,CON38,CON39,CON40,CON41,CON42,CON43,CON44,CON45,CON46,CON47,CON48,CON49,CON50,CON51,CON52,CON53,CON54,CON55,CON56,CON57,CON58,CON59,CON60,CON61,CON62,CON63,CON64,CON65,CON66,CON67,CON68,CON69,CON70,CON71,CON72,CON73,CON74,CON75,CON76,CON77,CON78,CON79,CON80,CON81,CON82,CON83, OBJ;

 CON1..     CW =E= 20;
 CON2..     Steam =E= 90;
 CON3..     F =E= 1000;
 CON4..     xA =E= 0.15;
 CON5..     xB =E= 0.3;
 CON6..     xC =E= 0.35;
 CON7..     xD =E= 0.2;
 CON8..     e1A =E= xA;
 CON9..     e1BCD =E= 1-e1A;
 CON10..    e2AB =E= xA+xB;
 CON11..    e2CD =E= 1-e2AB;
 CON12..    e3ABC =E= xA+xB+xC;
 CON13..    e3D =E= 1-e3ABC;
 CON14..    e4B =E= xB/e1BCD;
 CON15..    e4CD =E= 1-e4B;
 CON16..    e5BC =E= (xB+xC)/e1BCD;
 CON17..    e5D =E= 1-e5BC;
 CON18..    e6A =E= xA/e3ABC;
 CON19..    e6BC =E= 1-e6A;
 CON20..    e7AB =E= (xA+xB)/e3ABC;
 CON21..    e7C =E= 1-e7AB;
 CON22..    e8C =E= xC/(xC+xD);
 CON23..    e8D =E= 1-e8C;
 CON24..    e9B =E= xB/(xB+xC);
 CON25..    e9C =E= 1-e9B;
 CON26..    e10A =E= xA/(xA+xB);
 CON27..    e10B =E= 1-e10A;
 CON28..    F1+F2+F3 =E= F;
 CON29..    F4+F5 =E= e1BCD*F1;
 CON30..    F6+F7 =E= e3ABC*F3;
 CON31..    e2AB*F2+e7AB*F7 =E= F10;
 CON32..    e5BC*F5+e6BC*F6 =E= F9;
 CON33..    e2CD*F2+e4CD*F4 =E= F8;
 CON34..    Q1 =E= 0.277*K1*F1;
 CON35..    Q2 =E= 0.277*K2*F2;
 CON36..    Q3 =E= 0.277*K3*F3;
 CON37..    Q4 =E= 0.277*K4*F4;
 CON38..    Q5 =E= 0.277*K5*F5;
 CON39..    Q6 =E= 0.277*K6*F6;
 CON40..    Q7 =E= 0.277*K7*F7;
 CON41..    Q8 =E= 0.277*K8*F8;
 CON42..    Q9 =E= 0.277*K9*F9;
 CON43..    Q10 =E= 0.277*K10*F10;
 CON44..    F1 =L= F*y1;
 CON45..    F2 =L= F*y2;
 CON46..    F3 =L= F*y3;
 CON47..    F4 =L= F*y4;
 CON48..    F5 =L= F*y5;
 CON49..    F6 =L= F*y6;
 CON50..    F7 =L= F*y7;
 CON51..    F8 =L= F*y8;
 CON52..    F9 =L= F*y9;
 CON53..    F10 =L= F*y10;
 CON54..    a1 =E= 145;
 CON55..    a2 =E= 52;
 CON56..    a3 =E= 76;
 CON57..    a4 =E= 125;
 CON58..    a5 =E= 44;
 CON59..    a6 =E= 38;
 CON60..    a7 =E= 66;
 CON61..    a8 =E= 112;
 CON62..    a9 =E= 37;
 CON63..    a10 =E= 58;
 CON64..    b1 =E= 0.42;
 CON65..    b2 =E= 0.12;
 CON66..    b3 =E= 0.25;
 CON67..    b4 =E= 0.78;
 CON68..    b5 =E= 0.11;
 CON69..    b6 =E= 0.14;
 CON70..    b7 =E= 0.21;
 CON71..    b8 =E= 0.39;
 CON72..    b9 =E= 0.08;
 CON73..    b10 =E= 0.19;
 CON74..    K1 =E= 0.028;
 CON75..    K2 =E= 0.042;
 CON76..    K3 =E= 0.054;
 CON77..    K4 =E= 0.024;
 CON78..    K5 =E= 0.039;
 CON79..    K6 =E= 0.040;
 CON80..    K7 =E= 0.047;
 CON81..    K8 =E= 0.022;
 CON82..    K9 =E= 0.036;
 CON83..    K10 =E= 0.044;
 OBJ..      COST =E= (a1*y1+b1*F1)+(a2*y2+b2*F2)+(a3*y3+b3*F3)+(a4*y4+b4*F4)+(a5*y5+b5*F5)+(a6*y6+b6*F6)+(a7*y7+b7*F7)+(a8*y8+b8*F8)+(a9*y9+b9*F9)+(a10*y10+b10*F10)+(CW+Steam)*(Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10);

* Upper Bounds
*X1.UP = 4;

* Initial point
*Y1.L = 1;

 MODEL HW8P2  / ALL / ;

 OPTION LIMROW = 0;
 OPTION LIMCOL = 0;
 OPTION MIP = BARON;
* OPTION SOLPRINT = OFF;

 SOLVE HW8P2 USING MIP MINIMIZING COST;
* DISPLAY X.L, Y.L, Z.L;