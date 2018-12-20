function dydt=Analytical_f(t,y)
k1=1;k2=0.5;k3=1;
% reaction rates
r1 = k1*y(1)^2;
r2 = k2*y(2);
r3 = k3*y(1)^2;
% kinetics equations
dydt(1,:)=-r1-r3;
dydt(2,:)=r1-r2;
dydt(3,:)=r3+r2;
end
