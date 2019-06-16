% close all
clear all
clc

%%
% Defining the error covariance and process covariance
err = load('error_est');
err = err.y_t.Data;
R_kal = cov(err);
Q_kal = 10^(-9)*[100 1 1 1; 1 100 1 1; 1 1 100 1; 1 1 1 100];

% Defining the linearization point ([0,0] is up up) 
angle1 = 0;
angle2 = 0;
    
% get the CT linearized model;
sys = getLinModel(angle1, angle2);

%Discretize
h = 0.001;
sysd = c2d(sys,h);

%%

%Define LQR controller
Q = [100 0 0 0;
    0 1 0 0;
    0 0 0.1 0;
    0 0 0 0.1];
R = 0.2;

K = lqr(sysd,Q,R);
 
%%

% Calculate LQI gain

% Lqi retuned:
% [K_lqi S E] = lqi(sysd, diag([200 1 1 0.1 100 1]), 100);

% Ref tracking:
[K_lqi S E] = lqi(sysd, diag([200 1 1 0.1 1000 1]), 80);

K_lqi
K = K_lqi(1:4);
Ki = K_lqi(5:6);

 