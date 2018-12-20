function Sum = Sum_InfiteSeries(alpha,L,x,t)
syms m f a b c;
lower_bound = 1;
upper_bound = 5;
a = -((m*pi/L)^2)*alpha*t;
b = (1-(-1)^m)/(m*pi);
c = sin(m*pi*x/L);
f = exp(a)*b*c;
Sum = eval(symsum(f,m,lower_bound,upper_bound));
end