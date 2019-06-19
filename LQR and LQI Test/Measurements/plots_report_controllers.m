clc; clear all; close all;

%% LQR

% Simulink, init condition [0; 0.05; 0; 0]
figure;
grid on; hold on;
load('lqr_eq_y.mat');
plot(out.y.time,out.y.data(:,1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(out.y.time,out.y.data(:,2));
legend('\theta_1','\theta_2');
S1_sim = stepinfo(out.y.data(:,1), out.y.time);
settling1_sim = S1_sim.SettlingTime;
S2_sim = stepinfo(out.y.data(:,2), out.y.time);
settling2_sim = S2_sim.SettlingTime;

figure;
grid on; hold on;
load('lqr_eq_input.mat');
plot(out.input.time,out.input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% Real system, eq, first QR
figure;
grid on; hold on;
load('lqr_noinput_firstQR_y.mat');
plot(y.time(1:1500),y.data((1:1500),1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(y.time(1:1500),y.data((1:1500),2));
legend('\theta_1','\theta_2');
S1_real = stepinfo(y.data((1:1500),1), y.time(1:1500));
settling1_real = S1_real.SettlingTime;
S2_real = stepinfo(y.data((1:1500),2), y.time(1:1500));
settling2_real = S2_real.SettlingTime;
mean1_eq1 = mean(y.data((1:1500),1));
mean2_eq1 = mean(y.data((1:1500),2));

figure;
grid on; hold on;
load('lqr_noinput_firstQR_input.mat');
plot(input.time(1:1500),input.data((1:1500),1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% Real system, eq, final QR
figure;
grid on; hold on;
load('lqr_noinput_finalQR_R10_y.mat');
plot(y.time(1:1500),y.data((1:1500),1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(y.time(1:1500),y.data((1:1500),2));
legend('\theta_1','\theta_2');
S1_real_fin = stepinfo(y.data((1:1500),1), y.time(1:1500));
settling1_real_fin = S1_real_fin.SettlingTime;
S2_real_fin = stepinfo(y.data((1:1500),2), y.time(1:1500));
settling2_real_fin = S2_real_fin.SettlingTime;
mean1_eq2 = mean(y.data((1:1500),1));
mean2_eq2 = mean(y.data((1:1500),2));

figure;
grid on; hold on;
load('lqr_noinput_finalQR_R10_input.mat');
plot(input.time(1:1500),input.data((1:1500),1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

%% LQI
% Simulink, init condition [0; 0.05; 0; 0]
figure;
grid on; hold on;
load('lqi_eq_y.mat');
plot(out.y.time,out.y.data(:,1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(out.y.time,out.y.data(:,2));
legend('\theta_1','\theta_2');

figure;
grid on; hold on;
load('lqi_eq_input.mat');
plot(out.input.time,out.input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% Real model, eq, first QR
figure;
grid on; hold on;
load('lqi_noinput_firstQR_y.mat');
plot(y.time(1:1500),y.data((1:1500),1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(y.time(1:1500),y.data((1:1500),2));
legend('\theta_1','\theta_2');
S1_real = stepinfo(y.data((1:1500),1), y.time(1:1500));
settling1_real = S1_real.SettlingTime;
S2_real = stepinfo(y.data((1:1500),2), y.time(1:1500));
settling2_real = S2_real.SettlingTime;
mean1_eq1 = mean(y.data((1:1500),1));
mean2_eq1 = mean(y.data((1:1500),2));

figure;
grid on; hold on;
load('lqi_noinput_firstQR_input.mat');
plot(input.time(1:1500),input.data((1:1500),1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% Real model, eq, final QR
figure;
grid on; hold on;
load('lqi_noinput_finalQR_y.mat');
plot(y.time(1:1500),y.data((1:1500),1));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1 and \theta_2 [rad]');
hold on;
plot(y.time(1:1500),y.data((1:1500),2));
legend('\theta_1','\theta_2');
S1_real_fin = stepinfo(y.data((1:1500),1), y.time(1:1500));
settling1_real_fin = S1_real_fin.SettlingTime;
S2_real_fin = stepinfo(y.data((1:1500),2), y.time(1:1500));
settling2_real_fin = S2_real_fin.SettlingTime;
mean1_eq2 = mean(y.data((1:1500),1));
mean2_eq2 = mean(y.data((1:1500),2));

figure;
grid on; hold on;
load('lqi_noinput_finalQR_input.mat');
plot(input.time(1:1500),input.data((1:1500),1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

%% LQI REFERENCE
% real model, square, first try
figure;
grid on; hold on;
load('lqi_square_firstQR_y_ref.mat');
plot(y_ref.time,y_ref.data(:,3));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1, \theta_2 and square reference [rad]');
hold on; plot(y_ref.time,y_ref.data(:,4));
hold on; plot(y_ref.time,y_ref.data(:,1),'--k');
hold on; plot(y_ref.time,y_ref.data(:,2),'--k');
legend('\theta_1','\theta_2','ref \theta_1', 'ref \theta_2');
RMSE_square_first = rms(y_ref.data(:,3)-y_ref.data(:,1));

figure;
grid on; hold on;
load('lqi_square_firstQR_input.mat');
plot(input.time,input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% real model, square, final try
figure;
grid on; hold on;
load('lqi_square_finalQR_y_ref.mat');
plot(y_ref.time,y_ref.data(:,3));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1, \theta_2 and square reference [rad]');
hold on; plot(y_ref.time,y_ref.data(:,4));
hold on; plot(y_ref.time,y_ref.data(:,1),'--k');
hold on; plot(y_ref.time,y_ref.data(:,2),'--k');
legend('\theta_1','\theta_2','ref \theta_1', 'ref \theta_2');
RMSE_square_final = rms(y_ref.data(:,3)-y_ref.data(:,1));
std_square = std(y_ref.data(:,3));

figure;
grid on; hold on;
load('lqi_square_finalQR_input.mat');
plot(input.time,input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

% real model, sine
figure;
grid on; hold on;
load('lqi_sine_finalQR_y_ref.mat');
plot(y_ref.time,y_ref.data(:,3));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1, \theta_2 and sine reference [rad]');
hold on; plot(y_ref.time,y_ref.data(:,4));
hold on; plot(y_ref.time,y_ref.data(:,1),'--k');
hold on; plot(y_ref.time,y_ref.data(:,2),'--k');
legend('\theta_1','\theta_2','ref \theta_1', 'ref \theta_2');
RMSE_sine = rms(y_ref.data(:,3)-y_ref.data(:,1));
std_sine = std(y_ref.data(:,3));

figure;
grid on; hold on;
load('lqi_sine_finalQR_input.mat');
plot(input.time,input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action [V]');

%% LQI DISTURBANCE
figure;
grid on; hold on;
load('lqi_dist_finalQR_y_pulse.mat');
plot(y_pulse.time,y_pulse.data(:,2));
xlabel('time [sec]');
ylabel('angle [rad]');
title('Output: angles \theta_1, \theta_2 and pulse signal [rad]');
hold on; plot(y_pulse.time,y_pulse.data(:,3));
hold on; plot(y_pulse.time,y_pulse.data(:,1),'--k');
legend('\theta_1','\theta_2','pulse signal');

figure;
grid on; hold on;
load('lqi_dist_finalQR_input.mat');
plot(input.time,input.data(:,1),'r');
xlabel('time [sec]');
ylabel('input [V]');
title('Input control action with added pulse signal [V]');