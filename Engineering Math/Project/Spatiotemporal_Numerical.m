% [Spatiotemporal Solution - Numerical] %
clear;
format compact;

% <Parameters>
% setting
uB=400;
K=200; Q1=250; Q2=400;
f=80; Vw=5000; delta_V=0.675;
Diffu=30; Rm=0.1; d=0.25; Rc=100;
% derived
uD=Q2*uB/Q1;
T=Vw/(delta_V*f);
A=1-K/(Q1+Q2);
L1=2*Diffu/(Rm*d);
L2=2*Diffu/((Rc+Rm+d)*d);
% variation
k1=-uB; k2=-L1; k3=uD; k4=L2;
% initials
Bo=30; %known
Doo=12.5; %guess
% discretization
dz=0.001; za=0; zb=0.25; Nz=(zb-za)/dz+1;
dt=1; ta=0; tb=240; Nt=(tb-ta)/dt+1;
z=za:dz:zb; t=ta:dt:tb;

% <Initialization>
B=zeros(Nz,Nt); D=zeros(Nz,Nt);
for j=1:Nt
    B(1,j)=Bo*A^(t(j)/T);
end

% <Iteration>
Do=Doo; dDo=0.01; error=1; E=0.0022;
while (error>E)
    for j=1:Nt
        D(1,j)=Do*A^(t(j)/T);
    end
    for i=2:Nz
        for j=1:Nt-1
            B(i,j)=(1-(dz/(k1*dt))-(k2*dz/k1))*B(i-1,j)+(dz/(k1*dt))*B(i-1,j+1)+(k2*dz/k1)*D(i-1,j);
            D(i,j)=(1-(dz/(k3*dt))+(k4*dz/k3))*D(i-1,j)+(dz/(k3*dt))*D(i-1,j+1)-(k4*dz/k3)*B(i-1,j);
        end
        % assume linear for last 3 points
        B(i,Nt)=2*B(i,Nt-1)-B(i,Nt-2);
        D(i,Nt)=2*D(i,Nt-1)-D(i,Nt-2);
    end
    % get error
    error=abs(D(Nz,Nt));
    % iterate Do
    if D(Nz,Nt)>0
        Do = Do-dDo;
    else %D(Nz,Nt)<0
        Do = Do+dDo;
    end
end

% <Plot>
figure % cB
surf(t,z,B);
title('Spatiotemporal Solution [Numerical] cB(t,z)');
xlabel('t (min)'); ylabel('z (m)'); zlabel('cB (mM)');
colorbar;
axis([0 240 0 0.25 0 30]);
shading interp;
figure % cD
surf(t,z,D);
title('Spatiotemporal Solution [Numerical] cD(t,z)');
xlabel('t (min)'); ylabel('z (m)'); zlabel('cD (mM)');
colorbar;
axis([0 240 0 0.25 0 0.02]);
shading interp;