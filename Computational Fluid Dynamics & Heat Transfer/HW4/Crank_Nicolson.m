function [T,x,t] = Crank_Nicolson(dx,dt)
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

% initialization @ i=1
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
            RHS(p)=(1-b)*T(i,2)+(b/2)*T(i,3)+b*Ts;
        elseif p==n-1
            RHS(p)=b*T(i,n-1)+(1-b)*T(i,n);
        else
            RHS(p)=(b/2)*T(i,p)+(1-b)*T(i,p+1)+(b/2)*T(i,p+2);
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