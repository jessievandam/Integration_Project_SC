%% Sensor Calibration

%% Bias theta 1

% 0 rad
load('theta1_3_v2.mat'); th1m3.v2 = theta1.data;
load('theta1_3_v3.mat'); th1m3.v3 = theta1.data;
load('theta1_3_v4.mat'); th1m3.v4 = theta1.data;
load('theta1_3_v5.mat'); th1m3.v5 = theta1.data;

offset_th1 = mean([mean(th1m3.v2),mean(th1m3.v3),mean(th1m3.v4),mean(th1m3.v5)]);

%% Gain theta 1

% pi rad
load('theta1_1_v2.mat'); th1m1.v2 = theta1.data;
load('theta1_1_v3.mat'); th1m1.v3 = theta1.data;
load('theta1_1_v4.mat'); th1m1.v4 = theta1.data;
load('theta1_1_v5.mat'); th1m1.v5 = theta1.data;

gain_th1_pi = pi/(mean([mean(th1m1.v2),mean(th1m1.v3),mean(th1m1.v4),mean(th1m1.v5)])-offset_th1);

%% Bias theta 2

% 0 rad
% load('theta2_3_v2.mat'); th2m3.v2 = theta2.data;
% load('theta2_3_v3.mat'); th2m3.v3 = theta2.data;
% load('theta2_3_v4.mat'); th2m3.v4 = theta2.data;
% load('theta2_3_v5.mat'); th2m3.v5 = theta2.data;
load('theta2_3_v11.mat'); th2m3.v11 = theta2.data;
load('theta2_3_v12.mat'); th2m3.v12 = theta2.data;
load('theta2_3_v13.mat'); th2m3.v13 = theta2.data;
load('theta2_3_v14.mat'); th2m3.v14 = theta2.data;
load('theta2_3_v15.mat'); th2m3.v15 = theta2.data;

offset_th2 = mean([mean(th2m3.v11),mean(th2m3.v12),mean(th2m3.v13),mean(th2m3.v14),mean(th2m3.v15)]);

%% Gain theta 2

% pi rad
load('theta2_1_v2.mat'); th2m1.v2 = theta2.data;
load('theta2_1_v3.mat'); th2m1.v3 = theta2.data;
load('theta2_1_v4.mat'); th2m1.v4 = theta2.data;
load('theta2_1_v5.mat'); th2m1.v5 = theta2.data;

gain_th2 = pi/(mean([mean(th2m1.v2),mean(th2m1.v3),mean(th2m1.v4),mean(th2m1.v5)])-offset_th2);