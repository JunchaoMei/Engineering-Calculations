function [T,x,t] = Exact(dx,dt)
L=1;
alpha=0.1;
T0=100;
Ts=300;
n = L/dx + 1;

% get x(j)
for j=1:n
    x(j)=(j-1)*dx;
end
% get t(i)
t = 0:dt:0.5;

% get T(x,t)
for i=1:length(t)
    for j=1:n
        T(i,j)=Ts+2*(T0-Ts)*Sum_InfiteSeries(alpha,L,x(j),t(i));
    end
end

end