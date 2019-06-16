clear all; close all; clc;
run('parameters_model.m');
load('linmat.mat')
Ts = 0.01;
h = 0.01;

% eq1, downdown, [pi;0;0;0]
% eq2, upup, [0;0;0;0]

% xref
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
    
x0_eq1 = -A_eq1*[pi;0;0;0];
B_eq1 = [B x0_eq1];
D_eq1 = zeros(2,3);

sys1_val = ss(A_eq1,B_eq1,C,D_eq1);
sysd1_val = c2d(sys1_val,Ts);
B_eq1_d_val = sysd1_val.B;
xref = B_eq1_d_val(:,3);

%% Luenberger Observer 
% DOWN DOWN
p1 = pole(ss(linmat.A1,linmat.B1,linmat.C1,linmat.D1));
pdes1 = p1/3;
L1 = place(linmat.A1',linmat.C1',pdes1)';
eig_obs1 = eig(linmat.A1-L1*linmat.C1);

% UP UP
p2 = pole(ss(linmat.A2,linmat.B2,linmat.C2,linmat.D2));
pdes2 = p2/3;
L2 = place(linmat.A2',linmat.C2',pdes2)';
eig_obs2 = eig(linmat.A2-L2*linmat.C2);

%% LQR Controller K
Q2 = diag([300 1 1 0]); 
R2 = 50; 
[K2,~,~] = dlqr(linmat.A2,linmat.B2,Q2,R2,zeros(4,1));

%% LQI Controllers
C_new = [1 0 0 0; 1 1 0 0];
sysd2 = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);

Q2_lqi = diag([3 2 0 0 0.1 0.1]); 
R2_lqi = 1; 

[K2_lqi,~,~] = lqi(sysd2, Q2_lqi, R2_lqi, zeros(6,1));
K2_lq = K2_lqi(1,1:4);
K2_i = K2_lqi(1,5:6);

