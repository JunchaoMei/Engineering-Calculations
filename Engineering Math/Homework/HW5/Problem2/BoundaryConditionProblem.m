u=1;L=1;D=1;k=1;C0=1;   % Parameters
h=0.01*L; % time step
A=0;B=L;   % Initial and Final time
N=ceil((B-A)/h);
x(1)=A; % assign initial position
Cm=0.6;pm=u*(Cm-C0)/D;    % Initial values
% assign initial conditions
Y = [Cm;pm]; %Y(1,:)=C;Y(2,:)=p;
Y(2,N+1)=1;
a=(sqrt(2)-1)/2;b=(2-sqrt(2))/2;c=-sqrt(2)/2;d=(2+sqrt(2))/2;

% Runge-Kutta
error=0.001;dC=0.0001;
while abs(Y(2,N+1))>error
    for i=1:N
        x(i+1) = x(i)+h;
        k1 = h*[fC(Y(2,i));fp(u,D,k,Y(2,i),Y(1,i))];
        k2 = h*[fC(Y(2,i)+0.5*k1(2));fp(u,D,k,Y(2,i)+0.5*k1(2),Y(1,i)+0.5*k1(1))];
        k3 = h*[fC(Y(2,i)+a*k1(2)+b*k2(2));fp(u,D,k,Y(2,i)+a*k1(2)+b*k2(2),Y(1,i)+a*k1(1)+b*k2(1))];
        k4 = h*[fC(Y(2,i)+c*k2(2)+d*k3(2));fp(u,D,k,Y(2,i)+c*k2(2)+d*k3(2),Y(1,i)+c*k2(1)+d*k3(1))];
        Y(:,i+1) = Y(:,i)+(1/6)*(k1+k4)+(1/3)*(b*k2+d*k3);
    end
    if Y(2,N+1)<-error
        Cm = Cm+dC;
    elseif Y(2,N+1)>error
        Cm = Cm-dC;
    end
    pm=u*(Cm-C0)/D;
    Y(:,1) = [Cm;pm];
end

% plots
figure
plot(x,Y(1,:));
title('BVP - Runge-Kutta(4th order)');
xlabel('x'); ylabel('C');
axis([A B 0.58 0.74]);

figure
plot(x,Y(2,:));
title('BVP - Runge-Kutta(4th order)');
xlabel('x'); ylabel('p');
axis([A B -0.3 0]);