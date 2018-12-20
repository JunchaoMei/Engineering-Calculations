function [T,x,y,k] = Point_SOR(maxError,w)
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
 
% iteration
error_k = maxError+1;
while error_k>maxError
    error_k = 0;
    for j=2:25
        for i=2:25
            % recursion
            T_new=0.25*w*(T(i-1,j)+T(i+1,j)+T(i,j-1)+T(i,j+1))+(1-w)*T(i,j);
            error_new = abs(T_new-T(i,j));
            T(i,j)=T_new;
            % error judge - for all points error<maxError
            if error_new>error_k
                error_k = error_new;
            end
        end
    end
    k=k+1;
end

T = T'*Psi_max;
y = y*L;
x = x*L;
end