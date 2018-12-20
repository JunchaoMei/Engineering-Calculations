% Problem 1(d) & 1(f)
clear; clc;

% parameters
K=1.6352;
ta=0; tb=200; % tb=1500 for Problem1(e)
xa=0; xb=100; dx=0.25;
% stability condition (K*dt)/(dx^2) < 0.5
dt=0.01; % dt=0.019120,0.019121,0.019122 for stability checking
Nt=ceil((tb-ta)/dt); Nx=ceil((xb-xa)/dx);
L=xb-xa; T=tb-ta;

% initialization
U = ones(Nx+1,Nt+1);
time =[0:dt:dt*Nt];
xloc=[0:dx:(dx*Nx)];

% I.C.
for i=1:Nx+1
    if (i<=((Nx/2)+1))
        U(i,1)=0.8*dx*(i-1);
    else
        U(i,1)=0.8*(100-(i-1)*dx);
    end
end

% obtain U(x,t)
for j=2:Nt+1
   % B.C.
    % For Part (d), uncomment the next 2 lines
%     U(1,j) = 0;
%     U(Nx+1,j) = 0;
    % For Part (f), uncomment the next 3 lines
    t=(j-1)*dt;
    U(1,j) = 30+30*sin(2*pi*t/50);
    U(Nx+1,j) = 30+30*sin(2*pi*t/50);

   % calculation
    for i=1:Nx-1
        depth_2D(i) = (U(i,j-1)-2*U(i+1,j-1)+U(i+2,j-1))/dx^2;
        time_1D(i) = K*depth_2D(i);
        U(i+1,j) = time_1D(i)*dt + U(i+1,j-1);
    end
end

% plot
figure
imagesc(time,xloc,U);
colorbar;
%title('Problem1(d) (¦¤x=0.25, ¦¤t=0.01)');
%title('Problem1(d) (¦¤x=0.25, ¦¤t=0.01, tb=1500)');
%title('Problem1(d) (¦¤x=0.25, ¦¤t=0.019122)');
title('Problem1(f) (¦¤x=0.25, ¦¤t=0.01)');
xlabel('t');
ylabel('x');