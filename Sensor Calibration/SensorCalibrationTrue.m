%% Sensor Calibration

%% Bias theta 1

% 0 rad
load('theta1_3_v2.mat'); th1m3.v2 = theta1.data;
load('theta1_3_v3.mat'); th1m3.v3 = theta1.data;
load('theta1_3_v4.mat'); th1m3.v4 = theta1.data;
load('theta1_3_v5.mat'); th1m3.v5 = theta1.data;

offset_th1 = mean2([th1m3.v2,th1m3.v3,th1m3.v4,th1m3.v5]);

%% Gain theta 1

% pi rad
load('theta1_1_v2.mat'); th1m1.v2 = theta1.data;
load('theta1_1_v3.mat'); th1m1.v3 = theta1.data;
load('theta1_1_v4.mat'); th1m1.v4 = theta1.data;
load('theta1_1_v5.mat'); th1m1.v5 = theta1.data;

gain_th1_pi = pi/(mean2([th1m1.v2,th1m1.v3,th1m1.v4,th1m1.v5])-offset_th1);

%% Bias theta 2

% 0 rad

load('theta2_3_v16.mat'); th2m3.v16 = theta2.data;
load('theta2_3_v17.mat'); th2m3.v17 = theta2.data;
load('theta2_3_v18.mat'); th2m3.v18 = theta2.data;
load('theta2_3_v19.mat'); th2m3.v19 = theta2.data;

offset_th2 = mean2([th2m3.v16,th2m3.v17,th2m3.v18,th2m3.v19]);

%% Gain theta 2

% pi rad
load('theta2_1_v2.mat'); th2m1.v2 = theta2.data;
load('theta2_1_v3.mat'); th2m1.v3 = theta2.data;
load('theta2_1_v4.mat'); th2m1.v4 = theta2.data;
load('theta2_1_v5.mat'); th2m1.v5 = theta2.data;

gain_th2 = pi/(mean2([th2m1.v2,th2m1.v3,th2m1.v4,th2m1.v5])-offset_th2);
