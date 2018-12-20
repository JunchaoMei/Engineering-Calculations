function [Th,Tc,X]=exact_HW8(dX)
n = round(1/dX+1);

% get values of X
for i=1:n
    X(i)=(i-1)*dX;
end

% get values of T
Th(1)=1;Tc(1)=0;
for i=1:n-1
    Th(i+1)=(exp(-2*X(i+1))+1)/2;
    Tc(i+1)=1-Th(i+1);
end
 
end