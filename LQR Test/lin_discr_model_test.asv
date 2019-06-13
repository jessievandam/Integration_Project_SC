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
    
B_part = frac*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    0 1 0 0];

% equilibrium 2: [0;0;0;0] UP UP
A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
   

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

% equilibrium 4: [pi;pi;0;0] DOWN UP


%% Discretization
Ts = 0.01; % sample time
h = 0.01; % sample time

% DOWN DOWN
sys1 = ss(A_eq1,B(:,1),C,zeros(2,1));
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;

C_new = [1 0 0 0; 1 1 0 0];
sys1_n = ss(A_eq1,B(:,1),C_new,zeros(2,1));
sysd1_n = c2d(sys1_n,Ts);
C_eq1_d_n = sysd1_n.C;

% UP UP
sys2 = ss(A_eq2,B(:,1),C,zeros(2,1));
sysd2 = c2d(sys2,Ts);
A_eq2_d = sysd2.A;
B_eq2_d = sysd2.B;
C_eq2_d = sysd2.C;
D_eq2_d = sysd2.D;

% UP DOWN
sys3 = ss(A_eq3,B_eq3(:,1),C,zeros(2,1));
sysd3 = c2d(sys3,Ts);
A_eq3_d = sysd3.A;
B_eq3_d = sysd3.B;
C_eq3_d = sysd3.C;
D_eq3_d = sysd3.D;

C_new_eq3 = [1 0 0 0; 1 1 0 0];
sys3_n = ss(A_eq3,B_eq3(:,1),C_new_eq3,zeros(2,1));
sysd3_n = c2d(sys3_n,Ts);
C_eq3_d_n = sysd3_n.C;

%% LQR Controller K

% DOWN DOWN
Q1 = diag([0.2 0.4 0 0]); 
R1 = 1; 

[K1,~,~] = dlqr(A_eq1_d,B_eq1_d,Q1,R1,zeros(4,1));
[K1_2,~,~] = lqr(sysd1,Q1,R1);
[K1_3,~,~] = lqr(sysd1_n,Q1,R1);

% UP DOWN
Q3 = diag([0.02 0.08 0 0]); 
R3 = 100; 

[K3,~,~] = dlqr(A_eq3_d,B_eq3_d,Q3,R3,zeros(4,1));
[K3_2,~,~] = lqr(sysd3,Q3,R3);
[K3_3,~,~] = lqr(sysd3_n,Q3,R3);


