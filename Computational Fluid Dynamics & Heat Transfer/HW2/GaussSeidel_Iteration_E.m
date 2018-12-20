function [T,X] = GaussSeidel_Iteration_E(dX)
N = 1 / dX + 1;
 
% initialization
for i=1:N
    X(i)=(i-1)*dX;
    T(i)=0.4;
    T_new(i)=0.6;
    e(i)=10;
end
 
% iteration
E=10;
while (E>0.1)
    for i=1:N
        if i == 1
            T_new(i)=0;
            % T(i)=0;
        elseif i < N
            T_new(i)=(dX^2+T(i-1)+T(i+1))/2;
            % T(i)=(dX^2+T(i-1)+T(i+1))/2;
        else
            T_new(i)=(dX^2+2*T(i-1))/(2*(1+2*dX));
            % T(i)=(dX^2+2*T(i-1))/(2*(1+2*dX));
        end
    end
    E=0;
    for i=1:N
        e(i) = abs(100*(T_new(i)-T(i))/T(i));
        E = E+e(i);
        T(i) = T_new(i);
    end
end
 
end