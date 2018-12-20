function T = Gauss_Elimination(RHS)
n=25;

% initialization
for p=1:n-1
    if p == 1
        a(p,1)=-4;
        a(p,2)=1;
        for q=3:n-1
            a(p,q)=0;
        end
    elseif p == n-1
        for q=1:n-3
            a(p,q)=0;
        end
        a(p,n-2)=1;
        a(p,n-1)=-4;
    else
        for q=1:n-1
            a(p,q)=0;
        end
        a(p,p-1)=1;
        a(p,p)=-4;
        a(p,p+1)=1;
    end
end
for p=1:n-1
    a(p,n)=RHS(p);
end
 
% 1st elimination
for p=1:n-2
    for q=1:n-p-1
        c=a(p+q,p)/a(p,p);
        for k=1:n-p+1
            a(p+q,p+k-1)=a(p+q,p+k-1)-c*a(p,p+k-1);
        end
    end
end

% 2nd elimination
for p=1:n-2
    for q=1:n-p-1
        c=a(n-p-q,n-p)/a(n-p,n-p);
        for k=1:p+1
            a(n-p-q,n-k+1)=a(n-p-q,n-k+1)-c*a(n-p,n-k+1);
        end
    end
end
 
% final result
for p=1:n-1
    T(p)=a(p,n)/a(p,p);
end
 
end
