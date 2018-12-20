a=0;     % Initial time
b=10;     % Final time
k1=1;
k2=0.5;
k3=1;
yA0=1;    % Initial values
yG0=0;
yC0=0;
H=[0.1]; % Incremental time steps

% Explicit Euler
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
        yA(k,i+1) = yA(k,i)+h*fA(yA(k,i));
        yG(k,i+1) = yG(k,i)+h*fG(yA(k,i),yG(k,i));
        yC(k,i+1) = yC(k,i)+h*fC(yA(k,i),yG(k,i));
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
title('Explicit Euler - h=0.1');
xlabel('t'); ylabel('y');
axis([a b 0 1]);
legend('yA','yG','yC');