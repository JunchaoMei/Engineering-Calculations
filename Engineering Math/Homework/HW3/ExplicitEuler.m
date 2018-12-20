clear;
a=0;     % Initial time
b=2;     % Final time
y0=1;    % Initial value y(a)
H=[0.1,0.2,0.5,1,1.5,2]; % Incremental time steps

% analytical solution
[tau_ana,y_ana] = analytical();

% Explicit Euler
for k=1:6
    h=H(k);
    N=ceil((b-a)/h);
    tau(k,1)=a; % assign initial time
    y(k,1) = y0; % assign initial condition
    for i=1:N
        tau(k,i+1) = tau(k,i)+h;
        y(k,i+1) = y(k,i)+h*f(y(k,i));
    end
    % calculate error
    for i=1:N+1
        errsum2 = 0;
        for j=1:i
            errsum2 = errsum2 + ((y(k,j)-1/(tau(k,j)+1))/(1/(tau(k,j)+1)))^2;
        end
        error(k,i) = sqrt(errsum2);
    end
    % fill blank cells
    if N<20
        for j=N+2:21
            tau(k,j)=NaN;
            y(k,j)=NaN;
            error(k,j)=NaN;
        end
    end
end

% plots
figure
plot(tau_ana,y_ana,tau(1,:),y(1,:),tau(2,:),y(2,:),tau(3,:),y(3,:),tau(4,:),y(4,:),tau(5,:),y(5,:),tau(6,:),y(6,:));
title('Explicit Euler');
xlabel('¦Ó'); ylabel('y');
axis([0 2 -1 1]);
legend('Analytical','h=0.1','h=0.2','h=0.5','h=1.0','h=1.5','h=2.0');

figure
plot(tau(1,:),error(1,:),tau(2,:),error(2,:),tau(3,:),error(3,:),tau(4,:),error(4,:),tau(5,:),error(5,:),tau(6,:),error(6,:));
title('Percentage Relative Error - Explicit Euler');
xlabel('¦Ó'); ylabel('Percentage Relative Error');
legend('h=0.1','h=0.2','h=0.5','h=1.0','h=1.5','h=2.0');
axis([0 2 0 4]);