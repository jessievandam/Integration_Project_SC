%% Parameter estimation, theta1 only, theta2 only and combination

clear all; close all; clc

%% Theta 2 only
% Load required parameters
run('dynrotpend')
b2_est = 0.00009;

% Load and modify dataset
load('meas_th2_lefteq');
data_real = theta2.Data;
data = wrapToPi(data_real);
datav2 = data-mean(data);

data_start_th2 = 110;                       
data_end_th2 = 1500+data_start_th2-1;
time_end = data_start_th2-data_end_th2+1;
data = -datav2(data_start_th2:data_end_th2);

time = theta2.time;
time = time(data_start_th2:end);

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

% Initial estimate parameters
vec_est_th2 = [par.I2;par.m2;par.c2;b2_est];

lb_th2 = [0.00001;0.055;0.04;0];
ub_th2 = [0.0002;0.065;0.05;1];

t0 = theta2.time(1:time_end);

% Estimate parameters based on dataset
error_th2 = @(vec) MakeErrorTh2(vec,par,data);
par_min_th2 = lsqnonlin(error_th2,vec_est_th2,lb_th2,ub_th2,opt);


[~,theta2_est] = MakeErrorTh2(par_min_th2,par,data);
VAF_th2 = (1-var(data-theta2_est)/(var(data)))*100;

% Check simulation for longer time period
data_check = -datav2(110:end);
[~,theta_est_check] = MakeErrorTh2(par_min_th2,par,(data_check));
VAF_th2_check = (1-var(data_check-theta_est_check)/(var(data_check)))*100;

figure; hold on
plot(time(data_start_th2:data_end_th2), theta2_est,'-.')
plot(time(data_start_th2:data_end_th2),data)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

figure; hold on
plot(time,theta_est_check,'-.')
plot(time,data_check)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

%% Theta 1 only
par.Ts = 0.01;
b1_est = 4.8;
km_est = 50;

% Load and modify dataset
load('meas_th1_Chirp04');
data_th1_check = -theta1.Data(1:end);
data_th1_check = data_th1_check - mean(data_th1_check);

data_start_th1 = 1;
data_end_th1 = 1500;
data_th1 = -theta1.Data(data_start_th1:data_end_th1);
data_th1 = data_th1 - mean(data_th1);
time = theta1.time;

input = Input.Data;
input_time = Input.Time;


vec_est = [par.I1;(par.m1+par_min_th2(2));par.c1;b1_est;km_est];

theta_0 = [data_th1(1,1);(data_th1(5,1)-data_th1(1,1))/0.04];

lb_th1 = [vec_est(1:3)*0.8;0;1];
ub_th1 = [vec_est(1:3)*1.2;20;1000];

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

error_th1 = @(vec) MakeErrorTh1(vec,theta_0,input,par,data_th1);

par_min_th1 = lsqnonlin(error_th1,vec_est,lb_th1,ub_th1,opt);

[~,y0_th1] = error_th1(par_min_th1);
[~,y0_th1_check] = MakeErrorTh1(par_min_th1,theta_0,input,par,data_th1_check);

VAF_th1 = (1-var(data_th1-y0_th1)/(var(data_th1)))*100;
VAF_th1_check = (1-var(data_th1_check-y0_th1_check)/(var(data_th1_check)))*100;

figure; hold on
plot(time(data_start_th1:data_end_th1), y0_th1, '-.')
plot(time(data_start_th1:data_end_th1),data_th1)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

figure; hold on
plot(time, (y0_th1_check-mean(y0_th1_check)), '-.')
plot(time,data_th1_check)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

%% Full model

load('meas_full_square03_30s')
time_start = 1;
time_end = 2000;
data_th1_discr = theta1.data(time_start:time_end);
data_th2_discr = theta2.data(time_start:time_end);
data_time_discr = theta1.time(time_start:time_end);

input_discr = -Input.data;
input_time_discr = Input.time;

vec_est = [par_min_th1(1);par_min_th2(1);(par_min_th1(2)-par_min_th2(2));par_min_th2(2);par_min_th1(3);par_min_th2(3);par.l1_est;par_min_th1(4);par_min_th2(4);par_min_th1(5)];

theta_0 = [data_th1_discr(1,1);data_th2_discr(1,1);(data_th1_discr(5,1)-data_th1_discr(1,1))/0.04;(data_th2_discr(5,1)-data_th2_discr(1,1))/0.04];
lb = [vec_est(1:7)*0.8;0.00001;0.00001;1];
ub = [vec_est(1:7)*1.2;10;20;1000];

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-15;
opt.StepTolerance  = 1*10^-15;

error_doublepend = @(vec) error_doublepend_discr(vec,theta_0,input_discr,par,data_th1_discr,data_th2_discr);

[par_min_doublepend_discr,fval,~,exitflag] = lsqnonlin(error_doublepend,vec_est,lb,ub,opt);

[~,y0_th1_doublepend_discr,y0_th2_doublepend_discr] = error_doublepend(par_min_doublepend_discr);
[~,y0_th1_vec_est,y0_th2_vec_est] = error_doublepend([par_min_th1(1);par_min_th2(1);(par_min_th1(2)-par_min_th2(2));par_min_th2(2);par_min_th1(3);par_min_th2(3);par.l1_est;par_min_th1(4);par_min_th2(4);par_min_th1(5)]);

%% Make plots

figure; hold on 
plot(y0_th1_doublepend_discr,'-.')
plot(data_th1_discr)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

figure; hold on
plot(y0_th2_doublepend_discr,'-.')
plot(data_th2_discr)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

%% Calculate VAF
VAF_th1_doublepend_discr = (1-var(data_th1_discr-y0_th1_doublepend_discr)/(var(data_th1_discr)))*100;
VAF_th1_doublepend_initial = (1-var(data_th1_discr-y0_th1_vec_est)/(var(data_th1_discr)))*100;
VAF_th2_doublepend_discr = (1-var(data_th2_discr-y0_th2_doublepend_discr)/(var(data_th2_discr)))*100;
VAF_th2_doublepend_inital = (1-var(data_th2_discr-y0_th2_vec_est)/(var(data_th2_discr)))*100;