%% Kinetics HM 3 
% Student: Yunze Tian 

%% Part 1

% Matlab-file to solve 
% parallel reaction in PFR with heat exchange
%
%    A -> 2B, 
%    B + C -> D + E,  
%
% x(1)=CTG   concentration of A    [mol/L]
% x(2)=CDG   concentration of B    [mol/L]
% x(3)=CMG   concentration of C    [mol/L]
% x(4)=CG   concentration of D    [mol/L]
% x(5)=CMeOH   concentration of E    [mol/L]
% x(6)=CFAME    initial temperature   [K]

function concentration = batchconcentration_trial1(t, x)
% KINETICS
% activation energies  in J/mol!
E1 = 38.39e+03; %(J/mol)
Erev1 = 39.93e+3; %(J/mol)
E2 = 34.58e+3; %(J/mol)
Erev2 = 29.54e+3; %(J/mol)
E3 = 27.85e+3; %(J/mol)
Erev3 = 32.63e+3; %(J/mol)

A1 = 1.6e+5; %(L/mol/min)
Arev1 = 1.79e+5; %(L/mol/min)
A2 = 1.8e+05; %(L/mol/min)
Arev2 = 4e+4; %(L/mol/min)
A3 = 5.04e+3; %(L/mol/min)
Arev3 = 6.89e+4; %(L/mol/min)

R = 8.314;   % [J/(mol K)]

% rate coefficients

k1 = A1*exp(-E1/(R*x(7)));   % [1/s]
krev1 = Arev2*exp(-Erev2/(R*x(7)));   % [1/s]
k2 = A2*exp(-E2/(R*x(7)));    % [1/s]
krev2 = Arev2*exp(-Erev2/(R*x(7)));   % [1/s]
k3 = A3*exp(-E3/(R*x(7)));    % [1/s]
krev3 = Arev3*exp(-Erev3/(R*x(7)));   % [1/s]

% reaction rates
concentration(1,:) =-k1*x(1)*x(5)+krev1*x(2)*x(6);
concentration(2,:) =k1*x(1)*x(5)-krev1*x(2)*x(6)-k2*x(2)*x(5)+krev2*x(3)*x(6);
concentration(3,:) = k2*x(2)*x(5)-krev2*x(3)*x(6)-k3*x(3)*x(5)+krev3*x(4)*x(6);
concentration(4,:) = k3*x(3)*x(5)-krev3*x(4)*x(6);
concentration(5,:) = -k1*x(1)*x(5)+krev1*x(2)*x(6)-k2*x(2)*x(5)+krev2*x(3)*x(6)-k3*x(3)*x(5)+krev3*x(4)*x(6);
concentration(6,:) = -concentration(5,:);
concentration(7,:) = 0;

% concentration(1,:) =-k1*x(1)+krev1*x(2);
% concentration(2,:) =k1*x(1)-krev1*x(2)-k2*x(2);
% concentration(3,:) = k2*x(2)-krev2*x(3)-k3*x(3);
% concentration(4,:) = k3*x(3)-krev3*x(4);
% concentration(5,:) = -k1*x(1)+krev1*x(2)-k2*x(2);
% concentration(6,:) = -concentration(5,:);
% concentration(7,:) = 0;




   end