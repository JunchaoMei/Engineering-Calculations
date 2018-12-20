function [T,X] = Gauss_Elimination(dX)
N = 1 / dX + 1;
 
% initialization
for i=1:N
    if i == 1
        a(i,1)=-2;
        a(i,2)=1;
        for j=3:N
            a(i,j)=0;
        end
        a(i,N+1)=-dX^2;
    elseif i == N
        for j=1:N-2
            a(i,j)=0;
        end
        a(i,N-1)=2;
        a(i,N)=-2*(1+2*dX);
        a(i,N+1)=-dX^2;
    else
        for j=1:N
            a(i,j)=0;
        end
        a(i,i-1)=1;
        a(i,i)=-2;
        a(i,i+1)=1;
        a(i,N+1)=-dX^2;
    end
end
 
% 1st elimination
for i=1:N-1
    for j=1:N-i
        c=a(i+j,i)/a(i,i);
        for k=1:N-i+2
            a(i+j,i+k-1)=a(i+j,i+k-1)-c*a(i,i+k-1);
        end
    end
end

% 2nd elimination
for i=1:N-1
    for j=1:N-i
        c=a(N-i-j+1,N-i+1)/a(N-i+1,N-i+1);
        for k=1:i+1
            a(N-i-j+1,N-k+2)=a(N-i-j+1,N-k+2)-c*a(N-i+1,N-k+2);
        end
    end
end
 
% final result
for i=1:N
    T(i)=a(i,N+1)/a(i,i);
    X(i)=(i-1)*dX;
end
 
end
