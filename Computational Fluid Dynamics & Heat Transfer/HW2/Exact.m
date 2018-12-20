function [T,X] = Exact(dX)
N = 1 / dX + 1;

for i=1:N
    X(i)=(i-1)*dX;
    T(i)=(2/9)-((((2/3)-X(i))^2)/2);
end

end