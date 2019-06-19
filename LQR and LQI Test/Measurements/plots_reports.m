clc; clear all; close all;

%% OBSERVER
% Simulink model: zero input, with noise, Kalman and Luenberger
figure;
load('obs_zeroinputwithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,1));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_1 [rad]');
title('Error in \theta_1 for zero input signal');
std_kal1 = std(out.error.data(:,1));

figure;
load('obs_zeroinputwithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,2));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_2 [rad]');
title('Error in \theta_2 for zero input signal');
std_kal2 = std(out.error.data(:,2));

figure;
load('obs_zeroinputwithnoise_luenberger_error.mat');
plot(out.error.time,out.error.data(:,1));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_1 [rad]');
title('Error in \theta_1 for zero input signal');
std_luen1 = std(out.error.data(:,1));

figure;
load('obs_zeroinputwithnoise_luenberger_error.mat');
plot(out.error.time,out.error.data(:,2));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_2 [rad]');
title('Error in \theta_2 for zero input signal');
std_luen2 = std(out.error.data(:,2));

%% OBSERVER
% Sine input 0.3 rad, 0.5 Hz
% Simulink model
figure;
grid on; hold on;
load('obs_sinewithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,1));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_1 [rad]');
title('Error in \theta_1 for sine input signal');
std_sine_sim_1 = std(out.error.data(:,1));

figure;
grid on; hold on;
load('obs_sinewithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,2));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_2 [rad]');
title('Error in \theta_2 for sine input signal');
std_sine_sim_2 = std(out.error.data(:,2));

% Real system
figure;
grid on; hold on;
load('obs_sine0.3a0.5hz_error.mat');
plot(error_y.time,error_y.data(:,1));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_1 [rad]');
title('Error in \theta_1 for sine input signal');
std_sine_real_1 = std(error_y.data(:,1));

figure;
grid on; hold on;
load('obs_sine0.3a0.5hz_error.mat');
plot(error_y.time,error_y.data(:,2));
xlabel('time [sec]');
ylabel('error measured-filtered \theta_2 [rad]');
title('Error in \theta_2 for sine input signal');
std_sine_real_2 = std(error_y.data(:,2));

%%
% Velocities
figure;
grid on; hold on;
load('obs_sinewithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,3));
xlabel('time [sec]');
ylabel('error measured-filtered velocity \theta_1 [rad/s]');
title('Error in velocity \theta_1 for sine input signal');
std_sine_sim_3 = std(out.error.data(:,3));

figure;
grid on; hold on;
load('obs_sinewithnoise_kalman_error.mat');
plot(out.error.time,out.error.data(:,4));
xlabel('time [sec]');
ylabel('error measured-filtered velocity \theta_2 [rad/s]');
title('Error in velocity \theta_2 for sine input signal');
std_sine_sim_4 = std(out.error.data(:,4));