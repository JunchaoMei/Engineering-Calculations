% [Steady-State Solution - Analytical] %
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
% initials & ends
Bb=11.565826416939132; % from numerical simulation results
dz=0.001; za=0; zb=0.25; Nz=(zb-za)/dz+1;
z=za:dz:zb;

% <Initialization>
B=zeros(Nz); D=zeros(Nz);

% <Calculation>
for i=1:Nz
    B(i)=Bb*(L1*uB/(L1*uD)*exp(lumda*zb)-exp(lumda*z(i)))/(L2*uB/(L1*uD)*exp(lumda*zb)-1);
    D(i)=Bb*(L2*uB/(L1*uD)*exp(lumda*zb)-exp(lumda*z(i)))/(L2*uB/(L1*uD)*exp(lumda*zb)-1);
end

% <Plot>
figure
plot(z,B);
title('Steady-State Solution cBs(z)');
axis([0 0.25 0 10]);
xlabel('z (m)'); ylabel('cBs (mM)');
figure
plot(z,D);
title('Steady-State Solution cDs(z)');
axis([0 0.25 0 12]);
xlabel('z (m)'); ylabel('cDs (mM)');