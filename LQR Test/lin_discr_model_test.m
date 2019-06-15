clear all; close all; clc;
run('parameters_model.m');

%% Linearized state space model

% equilibrium 1: [pi;0;0;0] DOWN DOWN
frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];
    
B_part_eq1 = frac*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2+matrcomp.P3)];
     
B_eq1 = [0 0; 
    0 0; 
    B_part_eq1 zeros(2,1)];

C_eq1 = [1 0 0 0;
    0 1 0 0];

% equilibrium 2: [0;0;0;0] UP UP
A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
    
B_eq2 = B_eq1;
C_eq2 = C_eq1;

% equilibrium 3: [0;pi;0;0] UP DOWN
frac2 = 1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

A_eq3_part = frac2*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2-matrcomp.P3);
             matrcomp.g1*(matrcomp.P2-matrcomp.P3)+matrcomp.g2*(matrcomp.P1-matrcomp.P3) matrcomp.g2*(matrcomp.P1-matrcomp.P3) par.b1*(-matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2-2*matrcomp.P3)];
    
A_eq3 = [0 0 1 0;
        0 0 0 1;
        A_eq3_part];
    
B_part_eq3 = frac2*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2-matrcomp.P3)];
     
B_eq3 = [0 0; 
    0 0; 
    B_part_eq3 zeros(2,1)];

C_eq3 = C_eq1;

% equilibrium 4: [pi;pi;0;0] DOWN UP
A_eq4_part = frac2*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 par.b2*(-matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(-matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1-matrcomp.P3) matrcomp.g2*(matrcomp.P1-matrcomp.P3) par.b1*(-matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2-2*matrcomp.P3)];
    
A_eq4 = [0 0 1 0;
        0 0 0 1;
        A_eq4_part];

B_eq4 = B_eq3;
C_eq4 = C_eq1;

%% Discretization
Ts = 0.01; % sample time
h = 0.01; % sample time

% DOWN DOWN
sys1 = ss(A_eq1,B_eq1(:,1),C_eq1,zeros(2,1));
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;

C_new_eq1 = [1 0 0 0; 1 1 0 0];
sys1_n = ss(A_eq1,B_eq1(:,1),C_new_eq1,zeros(2,1));
sysd1_n = c2d(sys1_n,Ts);
C_eq1_d_n = sysd1_n.C;

% UP UP
sys2 = ss(A_eq2,B_eq2(:,1),C_eq2,zeros(2,1));
sysd2 = c2d(sys2,Ts);
A_eq2_d = sysd2.A;
B_eq2_d = sysd2.B;
C_eq2_d = sysd2.C;
D_eq2_d = sysd2.D;

C_new_eq2 = [1 0 0 0; 1 1 0 0];
sys2_n = ss(A_eq2,B_eq2(:,1),C_new_eq2,zeros(2,1));
sysd2_n = c2d(sys2_n,Ts);
C_eq2_d_n = sysd2_n.C;

% UP DOWN
sys3 = ss(A_eq3,B_eq3(:,1),C_eq3,zeros(2,1));
sysd3 = c2d(sys3,Ts);
A_eq3_d = sysd3.A;
B_eq3_d = sysd3.B;
C_eq3_d = sysd3.C;
D_eq3_d = sysd3.D;

C_new_eq3 = [1 0 0 0; 1 1 0 0];
sys3_n = ss(A_eq3,B_eq3(:,1),C_new_eq3,zeros(2,1));
sysd3_n = c2d(sys3_n,Ts);
C_eq3_d_n = sysd3_n.C;

% DOWN UP
sys4 = ss(A_eq4,B_eq4(:,1),C_eq4,zeros(2,1));
sysd4 = c2d(sys4,Ts);
A_eq4_d = sysd4.A;
B_eq4_d = sysd4.B;
C_eq4_d = sysd4.C;
D_eq4_d = sysd4.D;

C_new_eq4 = [1 0 0 0; 1 1 0 0];
sys4_n = ss(A_eq4,B_eq4(:,1),C_new_eq4,zeros(2,1));
sysd4_n = c2d(sys4_n,Ts);
C_eq4_d_n = sysd4_n.C;

%% LQR Controller K

% DOWN DOWN
Q1 = diag([0.2 0.4 0 0]); 
R1 = 1; 
[K1,~,~] = dlqr(A_eq1_d,B_eq1_d,Q1,R1,zeros(4,1));

% Q1_2 = diag([0.2 0.4 0 0 0 0]); 
% R1_2 = 1; 
% [K1_2,~,~] = lqi(sysd1_n, Q1_2, R1_2);
% K1_lq = K1_2(1,1:4);
% Ki = K1_2(1,5:6);

% UP UP
Q2 = diag([200 1 1 0.1]); 
R2 = 1; 
[K2,~,~] = dlqr(A_eq2_d,B_eq2_d,Q2,R2,zeros(4,1));

% UP DOWN
Q3 = diag([0.2 0.8 .01 .01]); 
R3 = 1000; 
[K3,~,~] = dlqr(A_eq3_d,B_eq3_d,Q3,R3,zeros(4,1));

% Q3_2 = diag([0.2 0.8 0 0 0.1 0.1]); 
% R3_2 = 1000; 
% [K3_2,~,~] = lqi(sysd3_n, Q3_2, R3_2);
% K3_lq = K3_2(1,1:4);
% Ki3 = K3_2(1,5:6);

% DOWN UP
Q4 = diag([0.02 0.04 0 0]); 
R4 = 1000; 
[K4,~,~] = dlqr(A_eq4_d,B_eq4_d,Q4,R4,zeros(4,1));
