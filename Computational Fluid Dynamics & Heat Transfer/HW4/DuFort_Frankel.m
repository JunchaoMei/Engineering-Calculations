function [T,x,t] = DuFort_Frankel(dx,dt)
L=0.5;
alpha=0.1;
b=alpha*dt/(dx^2);
T0=100;
Ts=300;
n = L/dx + 1;

% get x
for j=1:n
    x(j)=(j-1)*dx;
end

% initialization
for j=1:n
    if j==1
        T(1,j)=Ts;
    else
        T(1,j)=T0;
    end
end

% i==1
if j==1
    T(2,j)=Ts;
elseif j==n
    T(2,j)=((1-2*b)/(1+2*b))*T(1,j)+((2*b)/(1+2*b))*(T(1,j-1)+T(1,j-1));
else
    T(2,j)=((1-2*b)/(1+2*b))*T(1,j)+((2*b)/(1+2*b))*(T(1,j+1)+T(1,j-1));
end

i=2;
T_final=T0;
% recursion
while abs(T_final-Ts)>0.1  % T_final=T(i,n);
    for j=1:n
        if j==1
            T(i+1,j)=Ts;
        elseif j==n
            T(i+1,j)=((1-2*b)/(1+2*b))*T(i-1,j)+((2*b)/(1+2*b))*(T(i,j-1)+T(i,j-1));
        else
            T(i+1,j)=((1-2*b)/(1+2*b))*T(i-1,j)+((2*b)/(1+2*b))*(T(i,j+1)+T(i,j-1));
        end
    end
    T_final=T(i,n);
    i=i+1;
end

for k=1:i
    t(k)=k*dt;
end

end