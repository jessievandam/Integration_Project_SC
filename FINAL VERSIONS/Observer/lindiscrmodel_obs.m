clear all; close all; clc;
run('parameters_model.m');
load('linmat_sim.mat');
load('theta_zeroinput.mat');
Ts = 0.01;

% eq1, downdown, [pi;0;0;0]
% eq2, upup, [0;0;0;0]

%% Kalman Filter 
R_kal = cov(theta.data);

%% Luenberger Observer 
% DOWN DOWN
p1 = pole(ss(linmat.A1,linmat.B1,linmat.C1,linmat.D1));
pdes1 = p1/3;
L1 = place(linmat.A1',linmat.C1',pdes1)';
eig_obs1 = eig(linmat.A1-L1*linmat.C1);
