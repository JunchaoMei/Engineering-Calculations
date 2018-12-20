function [T,X] = TRIDI_Algorithm(dX)
N = 1 / dX + 1;
 
% initialization
for i=1:N
    if i == 1
        a(i,1)=-2;
        a(i,2)=1;
        for j=3:N
            a(i,j)=0;
        end
    elseif i == N
        for j=1:N-2
            a(i,j)=0;
        end
        a(i,N-1)=2;
        a(i,N)=-2*(1+2*dX);
    else
        for j=1:N
            a(i,j)=0;
        end
        a(i,i-1)=1;
        a(i,i)=-2;
        a(i,i+1)=1;
    end
    d(i)=-dX^2;
    X(i)=(i-1)*dX;
end

% 1st elimination
v=zeros(N,1);
T=v;
w=a(1,1);
for i=2:N
    v(i-1)=a(i-1,i)/w;
    w=a(i,i)-a(i,i-1)*v(i-1);
    T(i)=(d(i)-a(i,i-1)*T(i-1))/w;
end
 
% 2nd elimination
for i=N-1:-1:1
    T(i)=T(i)-v(i)*T(i+1);
end
                
end