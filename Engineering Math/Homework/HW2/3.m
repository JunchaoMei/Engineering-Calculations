syms x
syms A
syms B
yp = (A*x^3+B*x^2)*exp(-2*x);
yp1 = diff(yp)
yp2 = diff(yp1)
yp2+4*yp1+4*yp