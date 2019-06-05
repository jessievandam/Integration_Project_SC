%clear all; close all;

%% Initial parameters
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

%% Estimated parameters version 1
% par.I2_est = 2e-4;
% par.m2_est = 0.0552;
% par.c2_est = 0.0438;
% par.b2_est = 1.8206e-5;
% par.I1_est = 0.0297;
% par.m1_est = 0.2867-par.m2;
% par.c1_est = 0.0717;
% par.b1_est = 0.8031;
% par.km_est = 5.0549;

%% Estimated parameters version 2
% par.I2_est = 1.8699e-4;
% par.m2_est = 0.0553;
% par.c2_est = 0.0400;
% par.b2_est = 1.8088e-5;
% par.I1_est = 0.0297;
% par.m1_est = 0.2867-par.m2;
% par.c1_est = 0.0717;
% par.b1_est = 0.8031;
% par.km_est = 5.0549;

%% Estimated parameters version 3
par.I2_est = 1.8364e-4;
par.m2_est = 0.0551;
par.c2_est = 0.0401;
par.b2_est = 1.6576e-5;
par.I1_est = 0.0297;
par.m1_est = 0.2867-par.m2;
par.c1_est = 0.0717;
par.b1_est = 0.8031;
par.km_est = 5.0549;

matrcomp.P1_est = par.m1_est*par.c1_est^2+par.m2_est*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2_est = par.m2_est*par.c2_est^2 +par.I2_est;                       % Linear kinetic energy component 2
matrcomp.P3_est = par.m2_est*par.l1*par.c2_est;                          % Linear kinetic energy component 3
matrcomp.g1_est = (par.m1_est*par.c1_est+par.m2_est*par.l1)*par.g;           % Gravity component 1
matrcomp.g2_est = par.m2_est*par.c2_est*par.g;                           % Gravity component 2