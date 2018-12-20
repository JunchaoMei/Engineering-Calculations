function T = ICs(n,n1,m,m1)
% initialization
T = zeros(n,m);

% BC(2)
for j=m1:m
    T(n,j)=300;
end
% BC(3)
for i=1:n-1
    T(i,m)=300;
end
% BC(6)
for j=1:m
    T(1,j)=300;
end

% else [include BC(1)]
for i=1:n
    for j=1:m
        if T(i,j)==0
            T(i,j)=200;
        end
    end
end
end