function [u,v] = HW10_numerical(eta)
x_max = 1e6;
dx = 0.01*x_max;
n = 101;

y_max = eta*sqrt(x_max);
dy = 0.01*y_max;
m = 101;

% initialization
U = zeros(n+1,m);
V = zeros(n,m);
for i=1:n+1
    X(i) = (i-1)*dx;
end
for i=1:m
    Y(i) = (i-1)*dy;
end

for i=1:n+1
    U(i,1)=0;
    V(i,1)=0;
end
for j=2:m
    U(1,j)=1;
end

% iteration
for i=1:n
    for j=2:m
        if j<m
            U(i+1,j) = ((U(i,j+1)-2*U(i,j)+U(i,j-1))/(dy^2)-(V(i,j)*(U(i,j+1)-U(i,j)))/(dy))/U(i,j)+U(i,j);
        else % j==m
            U(i+1,m) = 2*U(i+1,m-1)-U(i+1,m-2);
        end
            V(i,j+1) = (U(i,j)-U(i+1,j))*dy+V(i,j);
    end
end

% get results
u=1;
for i=2:n+1
    if U(i,2) < u
        u = U(i,2);
    end
end
v=V(2,3);

end