clear all; close all; clc;
run('parameters_model.m');
Ts = 0.01;
h = 0.01;

%% Linearized, discretized state space model

% equilibrium 1: [pi;0;0;0] DOWN DOWN
[A_eq1, B_eq1, C_eq1, D_eq1] = dlinmod('NonlinearModelSimulink_2016b_eq1',Ts,[pi;0;0;0],0);

% equilibrium 2: [0;0;0;0] UP UP
[A_eq2, B_eq2, C_eq2, D_eq2] = dlinmod('NonlinearModelSimulink_2016b_eq2',Ts,[0;0;0;0],0);

% equilibrium 3: [0;pi;0;0] UP DOWN
[A_eq3, B_eq3, C_eq3, D_eq3] = dlinmod('NonlinearModelSimulink_2016b_eq3',Ts,[0;pi;0;0],0);

% equilibrium 4: [pi;pi;0;0] DOWN UP
[A_eq4, B_eq4, C_eq4, D_eq4] = dlinmod('NonlinearModelSimulink_2016b_eq4',Ts,[pi;pi;0;0],0);

%% LQR Controller K
C_new = [1 0 0 0; 1 1 0 0];
sysd1 = ss(A_eq1,B_eq1,C_new,D_eq1,Ts);

% DOWN DOWN
Q1 = diag([0.2 0.4 0 0]); 
R1 = 1; 
[K1,~,~] = dlqr(A_eq1,B_eq1,Q1,R1,zeros(4,1));

%%
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

%% LQI Controllers Klq and Ki

% DOWN DOWN
Q1_lqi = diag([0.2 0.4 0 0 1 1]); 
R1_lqi = 1; 
[K1_lqi,~,~] = lqi(sysd1, diag([2 1 1 0.1 1 1]), 1, zeros(6,1));
% K1_lq = K1_2(1,1:4);
% Ki = K1_2(1,5:6);