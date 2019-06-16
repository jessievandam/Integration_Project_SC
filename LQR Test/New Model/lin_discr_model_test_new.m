clear all; close all; clc;
run('parameters_model.m');
load('linmat.mat')
Ts = 0.01;
h = 0.01;

%% LQR Controller K
% DOWN DOWN
Q1 = diag([0.2 0.4 0 0]); 
R1 = 1; 
[K1,~,~] = dlqr(linmat.A1,linmat.B1,Q1,R1,zeros(4,1));

% UP UP
Q2 = diag([200 1 1 0.1]); 
R2 = 1; 
[K2,~,~] = dlqr(linmat.A2,linmat.B2,Q2,R2,zeros(4,1));

% UP DOWN
Q3 = diag([0.2 0.8 .01 .01]); 
R3 = 1000; 
[K3,~,~] = dlqr(linmat.A3,linmat.B3,Q3,R3,zeros(4,1));

% DOWN UP
Q4 = diag([0.02 0.04 0 0]); 
R4 = 1000; 
[K4,~,~] = dlqr(linmat.A4,linmat.B4,Q4,R4,zeros(4,1));

%% LQI Controllers Klq and Ki
C_new = [1 0 0 0; 1 1 0 0];
sysd1 = ss(linmat.A1,linmat.B1,C_new,linmat.D1,Ts);
sysd2 = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);
sysd3 = ss(linmat.A3,linmat.B3,C_new,linmat.D3,Ts);
sysd4 = ss(linmat.A4,linmat.B4,C_new,linmat.D4,Ts);

% DOWN DOWN
Q1_lqi = diag([2 1 1 0.1 1 1]); 
R1_lqi = 1; 
[K1_lqi,~,~] = lqi(sysd1, Q1_lqi, R1_lqi, zeros(6,1));
K1_lq = K1_lqi(1,1:4);
K1_i = K1_lqi(1,5:6);

% UP UP
Q2_lqi = diag([2 1 1 0.1 1 1]); 
R2_lqi = 1; 
[K2_lqi,~,~] = lqi(sysd2, Q2_lqi, R2_lqi, zeros(6,1));
K2_lq = K2_lqi(1,1:4);
K2_i = K2_lqi(1,5:6);

% UP DOWN
Q3_lqi = diag([2 1 0 0 0.1 0.1]); 
R3_lqi = 0.1; 
[K3_lqi,~,~] = lqi(sysd3, Q3_lqi, R3_lqi, zeros(6,1));
K3_lq = K3_lqi(1,1:4);
K3_i = K3_lqi(1,5:6);

% DOWN UP
Q4_lqi = diag([10 10 1 0.1 0 1]); 
R4_lqi = 80; 
% [K4_lqi,~,~] = lqi(sysd4, Q4_lqi, R4_lqi, zeros(6,1));
% K4_lq = K4_lqi(1,1:4);
% K4_i = K4_lqi(1,5:6);