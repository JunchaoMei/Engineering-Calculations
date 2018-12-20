% [Spatiotemporal Solution - Analytical] %
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
lumda=-(L1/uB-L2/uD);
% initials
Bo=30; %known
% discretization
dz=0.001; za=0; zb=0.25; Nz=(zb-za)/dz+1;
dt=1; ta=0; tb=240; Nt=(tb-ta)/dt+1;
z=za:dz:zb; t=ta:dt:tb;

% <Initialization>
B=zeros(Nz,Nt); D=zeros(Nz,Nt);

% <Calculation>
for j=1:Nt
   for i=1:Nz
        B(i,j)=Bo*((1-(K/(Q1+Q2)))^(t(j)/T))*(((L2*uB)/(L1*uD))*exp(lumda*zb)-exp(lumda*z(i)))/(((L2*uB)/(L1*uD))*exp(lumda*zb)-1);
        D(i,j)=Bo*((1-(K/(Q1+Q2)))^(t(j)/T))*(((L2*uB)/(L1*uD))*(exp(lumda*zb)-exp(lumda*z(i))))/(((L2*uB)/(L1*uD))*exp(lumda*zb)-1);
    end
end

% <Plot>
figure
surf(t,z,B)
title('Spatiotemporal Solution [Analytical] cB(t,z)');
xlabel('t (min)'); ylabel('z (m)'); zlabel('cB (mM)');
colorbar;
axis([0 240 0 0.25 0 30]);
shading interp;
figure
surf(t,z,D)
title('Spatiotemporal Solution [Analytical] cD(t,z)');
xlabel('t (min)'); ylabel('z (m)'); zlabel('cD (mM)');
colorbar;
axis([0 240 0 0.25 0 0.015]);
shading interp;