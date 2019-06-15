%% Validation of results

clear all; close all; clc

%% Validation measurement 1, square wave, right equilibrium

load('Square_03_right_validation')
load('Square_03_sim_validationv4')

data_square_03_th1 = theta1.data(203:end);
data_square_03_th2 = theta2.data(203:end);
time_square_03 = theta1.time(1:end-202);

t0_square_03 = 0:.01:((length(time_square_03)/100)-0.01);

y0_square_03_th1 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,1),t0_square_03)';
y0_square_03_th2 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,2),t0_square_03)';


figure; hold on
plot(time_square_03,data_square_03_th1)
plot(time_square_03,data_square_03_th2)
plot(t0_square_03,y0_square_03_th1,'-.')
plot(t0_square_03,y0_square_03_th2,'-.')

VAF_square_03_th1 = (1-var(data_square_03_th1-y0_square_03_th1)/(var(data_square_03_th1)))*100;
VAF_square_03_th2 = (1-var(data_square_03_th2-y0_square_03_th2)/(var(data_square_03_th2)))*100;

%% Validation measurement 2, sine wave, right equilibrium

load('Sine_03_right_validation')
load('Sine_03_sim_validation')

start_sine_03 = 1;
data_sine_03_th1 = theta1.data(start_sine_03:end);
data_sine_03_th2 = theta2.data(start_sine_03:end);
time_sine_03 = theta1.time(1:(end-(start_sine_03)+1));

t0_sine_03 = 0:.01:((length(time_sine_03)/100)-0.01);

y0_sine_03_th1 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,1),t0_sine_03)';
y0_sine_03_th2 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,2),t0_sine_03)';


figure; hold on
plot(time_sine_03,data_sine_03_th1)
plot(time_sine_03,data_sine_03_th2)
plot(t0_sine_03,y0_sine_03_th1,'-.')
plot(t0_sine_03,y0_sine_03_th2,'-.')

VAF_sine_03_th1 = (1-var(data_sine_03_th1-y0_sine_03_th1)/(var(data_sine_03_th1)))*100;
VAF_sine_03_th2 = (1-var(data_sine_03_th2-y0_sine_03_th2)/(var(data_sine_03_th2)))*100;

%% Validation measurement 3, sawtooth, right equilibrium

load('Sawtooth_03_right_validation')
load('Sawtooth_03_sim_validationv4')

start_sawtooth_03 = 1;
data_sawtooth_03_th1 = theta1.data(start_sawtooth_03:end);
data_sawtooth_03_th2 = theta2.data(start_sawtooth_03:end);
time_sawtooth_03 = theta1.time(1:(end-(start_sawtooth_03)+1));

t0_sawtooth_03 = 0:.01:((length(time_sawtooth_03)/100)-0.01);

y0_sawtooth_03_th1 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,1),t0_sawtooth_03)';
y0_sawtooth_03_th2 = interp1(theta_sim_nonlin.time,theta_sim_nonlin.data(:,2),t0_sawtooth_03)';


figure; hold on
plot(time_sawtooth_03,data_sawtooth_03_th1)
plot(time_sawtooth_03,data_sawtooth_03_th2)
plot(t0_sawtooth_03,y0_sawtooth_03_th1,'-.')
plot(t0_sawtooth_03,y0_sawtooth_03_th2,'-.')

VAF_sawtooth_03_th1 = (1-var(data_sawtooth_03_th1-y0_sawtooth_03_th1)/(var(data_sawtooth_03_th1)))*100;
VAF_sawtooth_03_th2 = (1-var(data_sawtooth_03_th2-y0_sawtooth_03_th2)/(var(data_sawtooth_03_th2)))*100;
