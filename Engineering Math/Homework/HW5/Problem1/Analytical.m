function [t,yA,yG,yC]=Analytical()
%parameters
a=0;b=10;
yA0=1;yG0=0;yC0=0;% Initial values
initcond = [yA0 yG0 yC0];% set initial conditions
intlimits  = [a b];% set integration limits
% solve
[t,y] = ode45('Analytical_f',intlimits,initcond);
% return
yA = y(:,1);
yG = y(:,2);
yC = y(:,3);
end