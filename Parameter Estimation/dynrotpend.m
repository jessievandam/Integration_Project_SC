%clear all; close all;
% Specify parameters
par.l1 = 0.1;       % Length of first link, m
par.l2 = 0.1;       % Length of second link, m
par.m1 = 0.18;      % Mass of first link, kg
par.m2 = 0.06;      % Mass of second link, kg
par.c1 = 0.06;      % Center of mass of first link, m
par.c2 = 0.045;     % Center of mass of second link, m
par.I1 = 0.037;     % Inertia of first link, kg*m^2
par.I2 = 0.00011;   % Inertia of second link, kg*m^2
par.g = 9.81;       % Gravitational acceleration, m/s^2

% Specify matrices
matrcomp.P1 = par.m1*par.c1^2+par.m2*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2 = par.m2*par.c2^2 +par.I2;                       % Linear kinetic energy component 2
matrcomp.P3 = par.m2*par.l1*par.c2;                          % Linear kinetic energy component 3
matrcomp.g1 = (par.m1*par.c1+par.m2*par.l1)*par.g;           % Gravity component 1
matrcomp.g2 = par.m2*par.c2*par.g;                           % Gravity component 2

%% Estimated parameters

% Theta 2
par.I2_est = 1.9912e-04;
par.m2_est = 0.0550;
par.c2_est = 0.04;
par.b2_est = 2.4071e-05;
par.I1_est = 0.0339;
par.m1_est = 0.2861-par.m2_est;
par.c1_est = 0.0715;
par.b1_est = 1.3715;
par.km_est = 5.7927;

matrcomp.P1_est = par.m1_est*par.c1_est^2+par.m2_est*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2_est = par.m2_est*par.c2_est^2 +par.I2_est;                       % Linear kinetic energy component 2
matrcomp.P3_est = par.m2_est*par.l1*par.c2_est;                          % Linear kinetic energy component 3
matrcomp.g1_est = (par.m1_est*par.c1_est+par.m2_est*par.l1)*par.g;           % Gravity component 1
matrcomp.g2_est = par.m2_est*par.c2_est*par.g;                           % Gravity component 2