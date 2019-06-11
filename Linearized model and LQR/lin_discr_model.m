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
    
B_part = frac*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    0 1 0 0];

%% Discretization
Ts = 0.01; % sample time

x0_eq1 = -A_eq1*[pi;0;0;0];
B_eq1 = [B x0_eq1];
D_eq1 = zeros(2,3);

sys1 = ss(A_eq1,B_eq1,C,D_eq1);
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;

sys2 = ss(A_eq2,B,C,zeros(2));
sysd2 = c2d(sys2,Ts);
A_eq2_d = sysd2.A;
B_eq2_d = sysd2.B;
C_eq2_d = sysd2.C;
D_eq2_d = sysd2.D;

%% Luenberger Observer
L = 0.001*ones(4,4);
B_L = [B_eq1_d L];
C_L = diag([1,1,1,1]);
A_L = A_eq1_d-L*C_L;
D_L = zeros(4,7);

%% LQR
Q1 = diag([0.00001 1 1 1000]);
Q2 = diag([1 1 1 1]);
R1 = diag([0.9 0 0.0001]);
R2 = diag([1 1]);

[K1,~,~] = lqr(A_eq1_d,B_eq1_d,Q1,R1); % optimal gain K1 for eq1
[K2,~,~] = lqr(A_eq2_d,B_eq2_d,Q2,R2); % optimal gain K2 for eq2

