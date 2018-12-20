a=0;b=10;   % Initial and Final time
k1=1;k2=0.5;k3=1;   % Rate Coefficients
yA0=1;yG0=0;yC0=0;    % Initial values
h=0.1; % time step
N=ceil((b-a)/h);
t(1)=a; % assign initial time
% assign initial conditions
Y = [yA0;yG0;yC0]; %Y(1)=yA;Y(2)=yG;Y(3)=yC;

% Trapezoidal
for i=1:N
    t(i+1) = t(i)+h;
    Ynr1 = [Y(1,i);Y(2,i);Y(3,i)];
    diff = [1;1;1];
    while abs(diff)>0.001
        F = [Ynr1(1)-Y(1,i)+0.5*h*(k1*(Y(1,i)^2+Ynr1(1)^2)+k3*(Y(1,i)^2+Ynr1(1)^2));
             Ynr1(2)-Y(2,i)-0.5*h*(k1*(Y(1,i)^2+Ynr1(1)^2)-k2*(Y(2,i)+Ynr1(2)));
             Ynr1(3)-Y(3,i)-0.5*h*(k3*(Y(1,i)^2+Ynr1(1)^2)+k2*(Y(2,i)+Ynr1(2)))];
        J = [1+h*(k1+k3)*Ynr1(1),0,0;
             -h*k1*Ynr1(1),1+0.5*k2*h,0;
             -h*k3*Ynr1(1),-0.5*k2*h,1];
        Ynr2 = Ynr1-inv(J)*F;
        diff = (Ynr2-Ynr1)./Ynr2;
        Ynr1 = Ynr2;
    end
    Y(1,i+1) = Ynr1(1,1);Y(2,i+1) = Ynr1(2,1);Y(3,i+1) = Ynr1(3,1);
end

% plots
figure
plot(t,Y(1,:),t,Y(2,:),t,Y(3,:));
title('Trapezoidal - h=0.1');
xlabel('t'); ylabel('y');
axis([a b 0 1]);
legend('yA','yG','yC');