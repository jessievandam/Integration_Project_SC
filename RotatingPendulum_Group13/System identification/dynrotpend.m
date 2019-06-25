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

%% Estimated parameters double pendulum model
% par.l1_est = 0.09028;       % Length of first link, m
% par.l2_est = 0.1;       % Length of second link, m
% par.m1_est = 0.2160;      % Mass of first link, kg
% par.m2_est = 0.0720;      % Mass of second link, kg
% par.c1_est = 0.0720;      % Center of mass of first link, m
% par.c2_est = 0.0470;     % Center of mass of second link, m
% par.I1_est = 0.0296;        % Inertia of first link, kg*m^2
% par.I2_est = 8.800e-05;     % Inertia of second link, kg*m^2
% par.g = 9.81;               % Gravitational acceleration, m/s^2
% par.b1_est = 2.1787;        % Damping first link
% par.b2_est = 0.0003001;     % Damping second link
% par.km_est = 14.1350;       % Motor gain

%% Estimated parameters double pendulum model v2
% par.l1_est = 0.0804329891286808;       % Length of first link, m
% par.l2_est = 0.1;       % Length of second link, m
% par.m1_est = 0.272545246546885;      % Mass of first link, kg
% par.m2_est = 0.0667262455373871;      % Mass of second link, kg
% par.c1_est = 0.0863993339162106;      % Center of mass of first link, m
% par.c2_est = 0.0475304258444246;     % Center of mass of second link, m
% par.I1_est =0.0272110717366075;        % Inertia of first link, kg*m^2
% par.I2_est = 0.000150255519626927;     % Inertia of second link, kg*m^2
% par.g = 9.81;               % Gravitational acceleration, m/s^2
% par.b1_est = 2.98458901393556;        % Damping first link
% par.b2_est = 0.000292060429803985;     % Damping second link
% par.km_est = 19.5658285816876;       % Motor gain

%% Estimated parameters double pendulum model v3
par.l1_est = 0.0804294093946102;       % Length of first link, m
par.l2_est = 0.1;       % Length of second link, m
par.m1_est = 0.272549112582789;      % Mass of first link, kg
par.m2_est = 0.0667528776558266;      % Mass of second link, kg
par.c1_est = 0.0863567426488841;      % Center of mass of first link, m
par.c2_est = 0.0475362943514164;     % Center of mass of second link, m
par.I1_est = 0.0272000365896942;        % Inertia of first link, kg*m^2
par.I2_est = 0.000150352582581866;     % Inertia of second link, kg*m^2
par.g = 9.81;               % Gravitational acceleration, m/s^2
par.b1_est = 2.98357229434069;        % Damping first link
par.b2_est = 0.000292377958001476;     % Damping second link
par.km_est = 19.5593682174979;       % Motor gain


% Specify matrices
matrcomp.P1_est = par.m1*par.c1^2+par.m2*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2_est = par.m2*par.c2^2 +par.I2;                       % Linear kinetic energy component 2
matrcomp.P3_est = par.m2*par.l1*par.c2;                          % Linear kinetic energy component 3
matrcomp.g1_est = (par.m1*par.c1+par.m2*par.l1)*par.g;           % Gravity component 1
matrcomp.g2_est = par.m2*par.c2*par.g;                           % Gravity component 2


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
% par.I2_est = 1.8364e-4;
% par.m2_est = 0.0551;
% par.c2_est = 0.0401;
% par.b2_est = 1.6576e-5;
% par.I1_est = 0.0297;
% par.m1_est = 0.2867-par.m2;
% par.c1_est = 0.06;%0.0717;
% par.b1_est = 0.8031;
% par.km_est = 5.0549;
% 
% matrcomp.P1_est = par.m1_est*par.c1_est^2+par.m2_est*par.l1^2+par.I1;        % Linear kinetic energy component 1
% matrcomp.P2_est = par.m2_est*par.c2_est^2 +par.I2_est;                       % Linear kinetic energy component 2
% matrcomp.P3_est = par.m2_est*par.l1*par.c2_est;                          % Linear kinetic energy component 3
% matrcomp.g1_est = (par.m1_est*par.c1_est+par.m2_est*par.l1)*par.g;           % Gravity component 1
% matrcomp.g2_est = par.m2_est*par.c2_est*par.g;                           % Gravity component 2