syms x
syms A
syms B
yp = A*x+B;
yp1 = diff(yp)
yp2 = diff(yp1)
yp2+3*yp