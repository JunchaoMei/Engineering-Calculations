function [T,X] = GaussSeidel_Iteration_10e4(dX)
N = 1 / dX + 1;

% initialization
for i=1:N
    X(i)=(i-1)*dX;
    T(i)=0.5;
end
 
% iteration
for j=1:10000 % iteration times
    for i=1:N
        if i == 1
            T(i)=0;
        elseif i < N
            T(i)=(dX^2+T(i-1)+T(i+1))/2;
        else
            T(i)=(dX^2+2*T(i-1))/(2*(1+2*dX));
        end
    end
end
 
end