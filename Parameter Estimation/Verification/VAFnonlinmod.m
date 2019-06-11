%% 
clear all; close all; clc;

%% Check nonlinear model

% Load simulation data
load('theta_sim_nonlinv4')
sim_th1 = theta_sim_nonlin.Data(:,1);
sim_th2 = theta_sim_nonlin.Data(:,2);
sim_time = theta_sim_nonlin.time;
totaltime = length(sim_time);

% Load real data
load('meas_full_square03_30s')
data_th1 = theta1.data;
% data_th1 = theta1.data(1:totaltime);
data_th2 = theta2.data;
% data_th2 = theta2.data(1:totaltime);
data_time = theta1.time;
% data_time = theta1.time(1:totaltime);

t0 = theta1.time;
sim_th1_new = interp1(sim_time,sim_th1,t0);
sim_th2_new = interp1(sim_time, sim_th2,t0);

figure; hold on;
plot(sim_time, sim_th1)
plot(data_time,data_th1)
legend('Simulation data','Real data')

figure; hold on;
plot(sim_time, sim_th2)
plot(data_time, data_th2)
legend('Simulation data','Real data')

%% Check VAF values
VAF_th1_nonlin_sim = (1-var(data_th1-sim_th1_new)/(var(data_th1)))*100;
VAF_th2_nonlin_sim = (1-var(data_th2-sim_th2_new)/(var(data_th2)))*100;

%% Check VAF values single pendulums

run('dynrotpend')

load('theta_sim_nonlin_squaretopeqv3')
sim_th1 = theta_sim_nonlin.data(:,1);
sim_th1 = sim_th1(1:500);
sim_th2 = theta_sim_nonlin.data(:,2);
sim_th2 = sim_th2(1:500);
sim_time = theta_sim_nonlin.time(1:500);

load('meas_verification_topeq')
data_th1 = theta1.data;
data_th1 = data_th1(1:500);
data_th2 = theta2.data-2*pi;
data_th2 = data_th2(1:500);

t0 = theta1.time(1:500);
sim_th1 = interp1(sim_time,sim_th1,t0);
sim_th2 = interp1(sim_time, sim_th2,t0);

figure; hold on
plot(sim_th1)
plot(data_th1)
legend('Simulated','Data')

figure; hold on
plot(sim_th2)
plot(data_th2)
legend('Simulated','Data')

VAF_th1_nonlin_sim = (1-var(data_th1-sim_th1)/(var(data_th1)))*100;
VAF_th2_nonlin_sim = (1-var(data_th2-sim_th2)/(var(data_th2)))*100;