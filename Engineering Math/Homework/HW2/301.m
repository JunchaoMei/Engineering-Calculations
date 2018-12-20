syms x
syms c2
y = (2+c2*x+1.5*x^2+(1/6)*x^3)*exp(-2*x);
y1 = diff(y)