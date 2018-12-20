%% Kinetics HM 3 
% Student: Yunze Tian 

%% Part 1

% Solve concentration expression 
   tspan = [0 30];
    x0 = [1 0 0 0 6 0 30+273];
    [t,x] = ode45(@batchconcentration_trial1,tspan,x0);
    FAME30C = max(x(:,6))
    tFAME30C = t(x(:,6) == FAME30C)
    TG30C = min(x(:,1))
    tTG30C = t(x(:,6) == TG30C)

 subplot(2,2,1)
 plot(t,x(:,[1 2 3 4 5 6]));  
 xlim([0,30]);
 ylim([0,6]);
 title('Concentration at T = 30 C');
 xlabel('Time [min]');
ylabel('Concentration [mol L-1]');
 legend('TG','DG','MG','GL','MeOH','FAME');


   tspan = [0 30];
    x0 = [1 0 0 0 6 0 40+273];
    [t,x] = ode45(@batchconcentration_trial1,tspan,x0);
    FAME40C = max(x(:,6))
    tFAME40C = t(x(:,6) == FAME40C)
    TG40C = min(x(:,1))
    tTG40C = t(x(:,6) == TG40C)
    
 subplot(2,2,2)
 plot(t,x(:,[1 2 3 4 5 6]));  
 xlim([0,30]);
 ylim([0,6]);
 title('Concentration at T = 40 C');
 xlabel('Time [min]');
ylabel('Concentration [mol L-1]');
 legend('TG','DG','MG','GL','MeOH','FAME');

 
   tspan = [0 30];
    x0 = [1 0 0 0 6 0 50+273];
    [t,x] = ode45(@batchconcentration_trial1,tspan,x0);
     FAME50C = max(x(:,6))
    tFAME50C = t(x(:,6) == FAME50C)
    TG50C = min(x(:,1))
    tTG50C = t(x(:,6) == TG50C)
    
 subplot(2,2,3)
 plot(t,x(:,[1 2 3 4 5 6]));  
 xlim([0,30]);
 ylim([0,6]);
 title('Concentration at T = 50 C');
 xlabel('Time [min]');
ylabel('Concentration [mol L-1]');
 legend('TG','DG','MG','GL','MeOH','FAME');
 
 
   tspan = [0 30];
    x0 = [1 0 0 0 6 0 60+273];
    [t,x] = ode45(@batchconcentration_trial1,tspan,x0);
    FAME60C = max(x(:,6))
    tFAME60C = t(x(:,6) == FAME60C)
    TG60C = min(x(:,1))
    tTG60C = t(x(:,6) == TG60C)
    
 subplot(2,2,4)
 plot(t,x(:,[1 2 3 4 5 6]));  
 xlim([0,30]);
 ylim([0,6]);
 title('Concentration at T = 60 C');
 xlabel('Time [min]');
ylabel('Concentration [mol L-1]');
 legend('TG','DG','MG','GL','MeOH','FAME');

