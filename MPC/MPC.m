%% Main MPC file

clear all
clc
close all

%% Define parameters/dataset

par.Ts = 0.01;                  % Sampling time
par.Tf = 10;                    % Final time
par.tpred = 0:par.Ts:par.Tf;    % Time for generation of prediction model
par.theta0 = zeros(4,1);        % Initial conditions

dim.nx = 4;                     % Number of states
dim.nu = 2;                     % Number of inputs
dim.N = 5;                      % Length receding horizon
dim.t = length(par.tpred)-dim.N;

weights.Q = diag([1 1 1]);
weights.R = eye(dim.nu)/100;
weight.P = zeros(dim.nx);

%% Equilibrium point