function [u,x,t]=Lax(dx,dt)
I = round(40/dx+1);
N = round(2.4/dt+1);

% get values of x & t
for i=1:I
    x(i)=(i-1)*dx;
end
for n=1:N
    t(n)=(n-1)*dt;
end

% initialization
u=zeros(I,N);
% ICs
for i=1:20/dx+1
    u(i,1)=5;
end
for i=20/dx+2:40/dx+1
    u(i,1)=0;
end

% iteration
for n=1:N-1
    % BC @ i=1
    u(1,n+1)=u(1,n)-(dt/dx)*u(1,n)*(u(2,n)-u(1,n));
    for i=2:I-1
        u(i,n+1)=0.5*(u(i+1,n)+u(i-1,n))-(dt/(4*dx))*(u(i+1,n)^2-u(i-1,n)^2);
    end
    % BC @ i=I
    u(I,n+1)=u(I,n)-(dt/dx)*u(I,n)*(u(I,n)-u(I-1,n));
end
 
end
