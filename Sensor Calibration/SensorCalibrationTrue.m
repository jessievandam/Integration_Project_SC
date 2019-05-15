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

% pi/2 rad
load('theta1_4_v2.mat'); th1m4.v2 = theta1.data;
load('theta1_4_v3.mat'); th1m4.v3 = theta1.data;
load('theta1_4_v4.mat'); th1m4.v4 = theta1.data;
load('theta1_4_v5.mat'); th1m4.v5 = theta1.data;

gain_th1_pi2 = (pi/2)/(mean([mean(th1m4.v2),mean(th1m4.v3),mean(th1m4.v4),mean(th1m4.v5)])-offset_th1);

% 3pi/2
load('theta1_2_v2.mat'); th1m2.v2 = theta1.data;
load('theta1_2_v3.mat'); th1m2.v3 = theta1.data;
load('theta1_2_v4.mat'); th1m2.v4 = theta1.data;
load('theta1_2_v5.mat'); th1m2.v5 = theta1.data;

gain_th1_3pi2 = (3*pi/2)/(mean([mean(th1m2.v2),mean(th1m2.v3),mean(th1m2.v4),mean(th1m2.v5)])-offset_th1);

gain_th1 = polyfit([pi/2 pi 3*pi/2],[gain_th1_pi2, gain_th1_pi, gain_th1_3pi2],2);

figure; hold on, grid on
plot([pi/2 pi 3*pi/2],[gain_th1_pi2, gain_th1_pi, gain_th1_3pi2])
plot([pi/2 pi 3*pi/2], gain_th1(1)*[pi/2 pi 3*pi/2].^2+gain_th1(2)*[pi/2 pi 3*pi/2]+gain_th1(3))
%% Bias theta 2

% 0 rad
load('theta2_3_v2.mat'); th2m3.v2 = theta2.data;
load('theta2_3_v3.mat'); th2m3.v3 = theta2.data;
load('theta2_3_v4.mat'); th2m3.v4 = theta2.data;
load('theta2_3_v5.mat'); th2m3.v5 = theta2.data;

offset_th2 = mean([mean(th2m3.v2),mean(th2m3.v3),mean(th2m3.v4),mean(th2m3.v5)]);

%% Gain theta 2

% pi rad
load('theta2_1_v2.mat'); th2m1.v2 = theta2.data;
load('theta2_1_v3.mat'); th2m1.v3 = theta2.data;
load('theta2_1_v4.mat'); th2m1.v4 = theta2.data;
load('theta2_1_v5.mat'); th2m1.v5 = theta2.data;

gain_th2 = pi/(mean([mean(th2m1.v2),mean(th2m1.v3),mean(th2m1.v4),mean(th2m1.v5)])-offset_th2);