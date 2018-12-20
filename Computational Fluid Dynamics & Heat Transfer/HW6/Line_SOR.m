function [T,x,y,k] = Line_SOR(maxError,w)
k=0; % iterative step
L=5;
Psi_max = 100;

% get values of x & y
for i=1:26
    x(i)=(i-1)*0.04;
    y(i)=x(i);
end
 
% initialization
T=zeros(26,26);
% BCs
for i=7:26
    T(i,1)=1;
end
for j=1:16
    T(26,j)=1;
end

% define T_new
T_new=zeros(26,26);
for i=7:26
T(i,1)=1;
end
for j=1:16
    T(26,j)=1;
end
    
error_k = maxError+1;
% iteration
while error_k>maxError
    error_k = 0;

    for j=2:25
        % initialize RHS
        for p=1:24
            if p==1
                RHS(p)=-w*(T(p+1,j+1)+T(p+1,j-1))+(1-w)*(-4*T(p+1,j)+T(p+2,j));
            elseif p==24
                RHS(p)=-w*(T(p+1,j+1)+T(p+1,j-1)+T(p+2,j))+(1-w)*(T(p,j)-4*T(p+1,j));
            else
                RHS(p)=-w*(T(p+1,j+1)+T(p+1,j-1))+(1-w)*(T(p,j)-4*T(p+1,j)+T(p+2,j));                
            end
        end
        % calculation
        T_j = Gauss_Elimination(RHS);
        for p=1:24
            T_new(p+1,j)=T_j(p);
        end
    end
    
    for j=2:25
        for i=2:25
            error_new = abs(T_new(i,j)-T(i,j));
            if error_new>error_k
                error_k = error_new;
            end
            T(i,j)=T_new(i,j);
        end
    end
    k=k+1;
end
 
% Change parameters
T = T'*Psi_max;
y = y*L;
x = x*L;

end