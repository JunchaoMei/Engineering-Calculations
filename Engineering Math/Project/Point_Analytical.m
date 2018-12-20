% [Point Solution - Analytical] %
clear;
format compact;

% <Parameters>
% setting
Bo=30; K=200;
Q1=250; Q2=400;
f=80; Vw=5000; delta_V=0.675;
% derived
A=1-K/(Q1+Q2);
T=Vw/(delta_V*f);
% discretization
dt=1; ta=0; tb=240; Nt=(tb-ta)/dt+1;
t=ta:dt:tb;

% <Calculation>
cHB=Bo*A.^(t./T);

% <Plot>
figure
plot(t,cHB);
title('Point Solution cHB(t)');
xlabel('t (min)'); ylabel('cHB (mM)');
axis([0 240 10 30]);