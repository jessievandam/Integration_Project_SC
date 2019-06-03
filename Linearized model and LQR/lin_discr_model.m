clear all; close all; clc;
run('parameters_model.m');

%% Linearized state space model
frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

% equilibrium 1: [pi 0 0 0]
A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];

% equilibrium 2: [0 0 0 0]
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

%% LQR
r1 = 0.5;  % weight to be varied for eq1
r2 = 0.5;  % weight to be varied for eq2

Q1 = eyes(4);
Q2 = eyes(4);
R1 = r1*eyes(4);
R2 = r2*eyes(4);

[K1,S1,e1] = LQR(A_eq1,B,Q1,R1); % optimal gain K1 for eq1
[K2,S2,e2] = LQR(A_eq2,B,Q2,R2); % optimal gain K2 for eq2

%% Discretization
T = 0.01; % sample time

[S1,J1] = jordan(A_eq1);
A_eq1_d = S1*exp(J1*T)*inv(S1);

[S2,J2] = jordan(A_eq2);
A_eq2_d = S2*exp(J2*T)*inv(S2);

B_eq1_d = inv(A_eq1)*(A_eq1_d-eye(4))*B;

B_eq2_d = inv(A_eq2)*(A_eq2_d-eye(4))*B;

C_d = C;

%% Kalman filter
P_eq1 = eig(A_eq1_d-B); % desired spectrum of the poles of matrix (A-KC)

% K_eq1 = place(A_eq1_d',C_d',SP)';
% K_eq2 = place(A_eq2_d',C_d',SP)';

