% Problem 1(b)
clear; clc;

% parameters
K=1.6352;
ta=0; tb=200;
xa=0; xb=100;
dt=0.01; dx=0.25;
Nt=(tb-ta)/dt; Nx=(xb-xa)/dx;
L=xb-xa; T=tb-ta;

% initialization
U = ones(Nx+1,Nt+1);
time =[0:dt:dt*Nt];
xloc=[0:dx:(dx*Nx)];

% obtain U(x,t)
for i=1:Nx+1
    x=(i-1)*dx;
    for j=1:Nt+1
        t=(j-1)*dt;
        sum=0;
        for n=1:5
            sum = sum + b(n)*sin(n*pi*x/L)*exp(-K*t*(n*pi/L)^2);
        end
        U(i,j) = sum;
    end
end

% plot
figure
imagesc(time,xloc,U);
colorbar;
title('Problem1(b) (¦¤x=0.25, ¦¤t=0.01)');
xlabel('t');
ylabel('x');