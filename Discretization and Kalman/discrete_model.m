clear all; close all; clc;
run('parameters_model.m');

%% Linearized state space model
frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];

A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
    
B_part = frac*[matrcomp.P2*par.km;
         -par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0; 0; B_part];

C = [1 0 0 0;
    0 1 0 0];

%% Discretization
T = 0.01; % sample time

[S1,J1] = jordan(A_eq1);
A_eq1_d = S1*exp(J1*T)*inv(S1);

[S2,J2] = jordan(A_eq2);
A_eq2_d = S2*exp(J2*T)*inv(S2);

B_eq1_d = inv(A_eq1).*(A_eq1_d-eye(4)).*B;

B_eq2_d = inv(A_eq2).*(A_eq2_d-eye(4)).*B;

C_d = C;

%% Kalman filter
P_eq1 = eig(A_eq1_d-B); % desired spectrum of the poles of matrix (A-KC)

% K_eq1 = place(A_eq1_d',C_d',SP)';
% K_eq2 = place(A_eq2_d',C_d',SP)';



