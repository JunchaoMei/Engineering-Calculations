function [u,x,t]=MacCormack(dx,dt)
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
    u_star(1)=u(1,n)-(dt/dx)*(E(u(2,n))-E(u(1,n)));
    u(1,n+1)=0.5*(u(1,n)+u_star(1)-(dt/dx)*(E(u_star(1))-E(2*u(1,n)-u(2,n)-(dt/dx)*(E(u(1,n))-E(2*u(1,n)-u(2,n))))));
    for i=2:I-1
        u_star(i)=u(i,n)-(dt/dx)*(E(u(i+1,n))-E(u(i,n)));
        u(i,n+1)=0.5*(u(i,n)+u_star(i)-(dt/dx)*(E(u_star(i))-E(u_star(i-1))));
    end
    % BC @ i=I
    u_star(I)=u(I,n)-(dt/dx)*(E(2*u(I,n)-u(I-1,n))-E(u(I,n)));
    u(I,n+1)=0.5*(u(I,n)+u_star(I)-(dt/dx)*(E(u_star(i))-E(u_star(i-1))));
end
 
end
