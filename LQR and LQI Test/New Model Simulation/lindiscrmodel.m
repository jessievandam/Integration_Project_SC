clear all; close all; clc;
run('parameters_model.m');
load('linmat_sim.mat')
Ts = 0.01;
h = 0.01;

% eq1, downdown, [pi;0;0;0]
% eq2, upup, [0;0;0;0]

%% Luenberger Observer 
% DOWN DOWN
p1 = pole(ss(linmat.A1,linmat.B1,linmat.C1,linmat.D1));
pdes1 = p1/3;
L1 = place(linmat.A1',linmat.C1',pdes1)';
eig_obs1 = eig(linmat.A1-L1*linmat.C1);

%% LQR Controller K
Q1 = diag([0.2 0.4 0 0]); 
R1 = 1; 
[K1,~,~] = dlqr(linmat.A1,linmat.B1,Q1,R1,zeros(4,1));
 
Q2 = diag([300 1 1 0]); 
R2 = 50; 
[K2,~,~] = dlqr(linmat.A2,linmat.B2,Q2,R2,zeros(4,1));

%% LQI Controllers
C_new = [1 0 0 0; 1 1 0 0];
sysd2 = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);

% Q2_lqi = diag([500 1 1 0 400 1]); 
% R2_lqi = 100;

Q2_lqi = diag([3 3 0 0 0.5 0.5]); 
R2_lqi = 1; 

[K2_lqi,~,~] = lqi(sysd2, Q2_lqi, R2_lqi, zeros(6,1));
K2_lq = K2_lqi(1,1:4);
K2_i = K2_lqi(1,5:6);

