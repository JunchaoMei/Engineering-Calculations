a=0;b=10;   % Initial and Final time
k1=1;k2=0.5;k3=1;   % Rate Coefficients
yA0=1;yG0=0;yC0=0;    % Initial values
h=0.1; % time step
N=ceil((b-a)/h);
t(1)=a; % assign initial time
% assign initial conditions
Y = [yA0;yG0;yC0]; %Y(1)=yA;Y(2)=yG;Y(3)=yC;
A=(sqrt(2)-1)/2;B=(2-sqrt(2))/2;C=-sqrt(2)/2;D=(2+sqrt(2))/2;

% Runge-Kutta
for i=1:N
    t(i+1) = t(i)+h;
    k1 = h*[fA(Y(1,i));fG(Y(1,i),Y(2,i));fC(Y(1,i),Y(2,i))];
    k2 = h*[fA(Y(1,i)+0.5*k1(1));fG(Y(1,i)+0.5*k1(1),Y(2,i)+0.5*k1(2));fC(Y(1,i)+0.5*k1(1),Y(2,i)+0.5*k1(2))];
    k3 = h*[fA(Y(1,i)+A*k1(1)+B*k2(1));fG(Y(1,i)+A*k1(1)+B*k2(1),Y(2,i)+A*k1(2)+B*k2(2));fC(Y(1,i)+A*k1(1)+B*k2(1),Y(2,i)+A*k1(2)+B*k2(2))];
    k4 = h*[fA(Y(1,i)+C*k2(1)+D*k3(1));fG(Y(1,i)+C*k2(1)+D*k3(1),Y(2,i)+C*k2(2)+D*k3(2));fC(Y(1,i)+C*k2(1)+D*k3(1),Y(2,i)+C*k2(2)+D*k3(2))];
    Y(:,i+1) = Y(:,i)+(1/6)*(k1+k4)+(1/3)*(B*k2+D*k3);
end

% plots
figure
plot(t,Y(1,:),t,Y(2,:),t,Y(3,:));
title('Runge-Kutta(4th order) - h=0.1');
xlabel('t'); ylabel('y');
axis([a b 0 1]);
legend('yA','yG','yC');