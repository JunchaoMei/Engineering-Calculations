a=0;b=10;   % Initial and Final time
k1=1;k2=0.5;k3=1;   % Rate Coefficients
yA0=1;yG0=0;yC0=0;    % Initial values
H=[0.1,0.2,0.3,0.4,0.5,0.6]; % Incremental time steps

% analytical solution
[t_ana,yA_ana,yG_ana,yC_ana] = Analytical();

% Explicit Euler
for k=1:6
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
plot(t_ana,yA_ana,t(1,:),yA(1,:),t(2,:),yA(2,:),t(3,:),yA(3,:),t(4,:),yA(4,:),t(5,:),yA(5,:),t(6,:),yA(6,:));
title('Explicit Euler - yA');
xlabel('t'); ylabel('yA');
axis([a b 0 1]);
legend('Analytical','h=0.1','h=0.2','h=0.3','h=0.4','h=0.5','h=0.6');
figure
plot(t_ana,yG_ana,t(1,:),yG(1,:),t(2,:),yG(2,:),t(3,:),yG(3,:),t(4,:),yG(4,:),t(5,:),yG(5,:),t(6,:),yG(6,:));
title('Explicit Euler - yG');
xlabel('t'); ylabel('yG');
axis([a b 0 1]);
legend('Analytical','h=0.1','h=0.2','h=0.3','h=0.4','h=0.5','h=0.6');
figure
plot(t_ana,yC_ana,t(1,:),yC(1,:),t(2,:),yC(2,:),t(3,:),yC(3,:),t(4,:),yC(4,:),t(5,:),yC(5,:),t(6,:),yC(6,:));
title('Explicit Euler - yC');
xlabel('t'); ylabel('yC');
axis([a b 0 1]);
legend('Analytical','h=0.1','h=0.2','h=0.3','h=0.4','h=0.5','h=0.6');