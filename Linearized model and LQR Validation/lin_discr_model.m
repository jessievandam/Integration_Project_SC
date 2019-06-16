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

% Validation Models
x0_eq1 = -A_eq1*[pi;0;0;0];
B_eq1 = [B x0_eq1];
D_eq1 = zeros(2,3);

sys1_val = ss(A_eq1,B_eq1,C,D_eq1);
sysd1_val = c2d(sys1_val,Ts);
A_eq1_d_val = sysd1_val.A;
B_eq1_d_val = sysd1_val.B;
C_eq1_d_val = sysd1_val.C;
D_eq1_d_val = sysd1_val.D;

B_eq1_d2_val = B_eq1_d_val(:,1);
D_eq1_d2_val = D_eq1_d_val(:,1);
xref = B_eq1_d_val(:,3);

% Controller models
sys1 = ss(A_eq1,B(:,1),C,zeros(2,1));
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

%% Luenberger Observer Validation
p_val = pole(ss(A_eq1_d_val,B_eq1_d2_val,C_eq1_d_val,D_eq1_d2_val));
pdes_val = p_val/3;
L_val = place(A_eq1_d',C_eq1_d',pdes_val)';
eig_obs_val = eig(A_eq1_d_val-L_val*C_eq1_d_val);

%% Luenberger Observer Controller
p = pole(ss(A_eq1_d,B_eq1_d,C_eq1_d,D_eq1_d));
pdes = p/3;
L = place(A_eq1_d',C_eq1_d',pdes)';
eig_obs = eig(A_eq1_d-L*C_eq1_d);

%% LQR Controller K
Q1 = diag([600 300 0 0]);
R1 = 0.001;
[K1,~,~] = lqr(A_eq1_d,B_eq1_d,Q1,R1);  % optimal gain K1 for eq1
[K12,~,~] = lqr(sysd1,Q1,R1);
K122 = K12(1,:);

% Q2 = diag([20 15 0.5 0.5]);
% R2 = diag([1 1]);
% [K2,~,~] = lqr(A_eq2_d,B_eq2_d,Q2,R2); % optimal gain K2 for eq2

