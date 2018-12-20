function [T,x,t] = BTCS(dx,dt)
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

i=1;
T_final=T0;
% recursion
while abs(T_final-Ts)>0.1  % T_final=T(i,n);
    % initialize RHS
    for p=1:n-1
        if p==1
            RHS(p)=T(i,p+1)+b*Ts;
        else
            RHS(p)=T(i,p+1);
        end
    end
    
    % calculation
    T(i+1,1)=Ts;
    [T_get,J_get]=Gauss_Elimination(dx,dt,RHS);
    for p=1:n-1
        T(i+1,p+1)=T_get(p);
    end
    
    T_final=T(i,n);
    i=i+1;
end

for k=1:i
    t(k)=k*dt;
end

end