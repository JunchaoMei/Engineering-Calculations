function [r,theta,T] = Line_GS(dr,dtheta)
K=0; % iterative step
maxError = 0.1;
q3 = 5e7;
k = 20;
R = 10e-3;
R1 = 7e-3;
Theta = 75;
Theta1 = 25;
n = round(R/dr+1);
n1 = round(R1/dr+1);
m = round(Theta/dtheta+1);
m1 = round(Theta1/dtheta+1);

% get values of r & theta
for i=1:n
    r(i)=(i-1)*dr;
end
for j=1:m
    theta(j)=(j-1)*dtheta;
end

% initialization
T = ICs(n,n1,m,m1);
T_old = ICs(n,n1,m,m1);
[A,B,C,D,G] = abcdg(n,dr,dtheta);

% iteration
error_K = maxError+1;
while error_K>maxError
    error_K = 0;
    
    % get T_old
    for i=1:n
        for j=1:m
            T_old(i,j)=T(i,j);
        end
    end
    
    % BC(4)
    for  i=2:n1-1
        T(i,2) = T(i,1);
    end
    % BC(5)
    for j=2:m1-2
        T(n1,j) = T(n1-1,j);
    end

    % GE
    for j=2:m1
        % initialize RHS
        for i=1:n1-1
            if i==2
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-A(i)*300-q3/k;
            elseif i==n1-1
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-B(i)*T(i+1,j)-q3/k;
            else
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-q3/k;
            end
        end
        % calculation
        T(i,j) = Gauss_Elimination(RHS);
    end
    
    for j=m1+1:m-1
        % initialize RHS
        for i=1:n-1
            if i==2
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-A(i)*300-q3/k;
            elseif i==n-1
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-B(i)*T(i+1,j)-q3/k;
            else
                RHS(i)=C(i)*T(i,j+1)+D(i)*T(i,j-1)-q3/k;
            end
        end
        % calculation
        T(i,j) = Gauss_Elimination(RHS);
    end
    
    % error judge - for all points error<maxError
    for j=1:m
        for i=1:n
            error_new = abs(T_old(i,j)-T(i,j));
            if error_new>error_K
                error_K = error_new;
            end
        end
    end
    % iterative step +1
    K=K+1;
end

% empty the non-exist part
for i=n1+1:n
    for j=1:m1-1
        T(i,j) = NaN;
    end
end

end