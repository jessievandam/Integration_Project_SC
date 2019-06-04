clear all; close all; clc;
run('parameters_model.m');

%% Linearized state space model
frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

% equilibrium 1: [pi;0;0;0]
A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];

% equilibrium 2: [0;0;0;0]
A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
    
B_part = frac*[matrcomp.P2*par.km;
         -par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    0 1 0 0];

%% Discretization
T = 0.01; % sample time

% [S1,J1] = jordan(A_eq1);
% A_eq1_d = S1*exp(J1*T)*inv(S1);
% A_eq1_d = real(A_eq1_d);
% 
% [S2,J2] = jordan(A_eq2);
% A_eq2_d = S2*exp(J2*T)*inv(S2);
% A_eq2_d = real(A_eq2_d);
% 
% B_eq1_d = inv(A_eq1)*(A_eq1_d-eye(4))*B;
% B_eq1_d = real(B_eq1_d);
% 
% B_eq2_d = inv(A_eq2)*(A_eq2_d-eye(4))*B;
% B_eq2_d = real(B_eq2_d);

A_eq1_d = A_eq1*T + eye(4);
A_eq2_d = A_eq2*T + eye(4);
B_d = B*T;
C_d = C;

%% LQR
Q1 = diag([1 1 1 1]);
Q2 = diag([1 1 1 1]);
R1 = diag([1 1]);
R2 = diag([1 1]);

[K1,~,~] = lqr(A_eq1_d,B_d,Q1,R1); % optimal gain K1 for eq1
[K2,~,~] = lqr(A_eq2_d,B_d,Q2,R2); % optimal gain K2 for eq2

