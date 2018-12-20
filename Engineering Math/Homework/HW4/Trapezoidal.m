a=0;     % Initial time
b=10;     % Final time
k1=1;
k2=0.5;
k3=1;
yA0=1;    % Initial values
yG0=0.1;
yC0=0.1;
H=[0.1]; % Incremental time steps

% Trapezoidal
for k=1:1
    h=H(k);
    N=ceil((b-a)/h);
    t(k,1)=a; % assign initial time
    % assign initial conditions
    yA(k,1) = yA0;
    yG(k,1) = yG0;
    yC(k,1) = yC0;
    for i=1:N
        t(k,i+1) = t(k,i)+h;
        
        yAnr1 = yA(k,i);
        diffA = 1;
        while abs(diffA)>0.001
            yAnr2 = yAnr1 - (1.5*h*((yAnr1^2)+(yA(k,i)^2))+yAnr1-yA(k,i))/(1+3*h*yAnr1);
            diffA = (yAnr2-yAnr1)/yAnr2;
            yAnr1 = yAnr2;
        end
        yA(k,i+1) = yAnr1;

        yGnr1 = yG(k,i);
        diffG = 1;
        while abs(diffG)>0.001
            yGnr2 = yGnr1 - ((1+h)*yGnr1+(h-1)*yG(k,i)-1.5*h*((yAnr1^2)-(yA(k,i)^2)))/(1+h);
            diffG = (yGnr2-yGnr1)/yGnr2;
            yGnr1 = yGnr2;
        end
        yG(k,i+1) = yGnr1;

        yCnr1 = yC(k,i);
        diffC = 1;
        while abs(diffC)>0.001
            yCnr2 = yCnr1 - (yCnr1-yC(k,i)-0.75*h*((yAnr1^2)+(yA(k,i)^2))-h*(yGnr1+yG(k,i)))/1;
            diffC = (yCnr2-yCnr1)/yCnr2;
            yCnr1 = yCnr2;
        end
        yC(k,i+1) = yCnr1;
    end
    % fill blank cells
    if N<ceil((b-a)/H(1))
        for j=N+2:ceil((b-a)/H(1))+1
            t(k,j)=NaN;
            yA(k,j)=NaN;
            yG(k,j)=NaN;
            yC(k,j)=NaN;
            %error(k,j)=NaN;
        end
    end
end

% plots
figure
plot(t(1,:),yA(1,:),t(1,:),yG(1,:),t(1,:),yC(1,:));
title('Trapezoidal - h=0.1');
xlabel('t'); ylabel('y');
axis([a b 0 1]);
legend('yA','yG','yC');