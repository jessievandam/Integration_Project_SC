% Specify parameters
par.l1 = 0.1;       % Length of first link, m
par.l2 = 0.1;       % Length of second link, m
par.g = 9.81;       % Gravitational acceleration, m/s^2

% Version 1
% par.I2 = 2e-4;
% par.m2 = 0.0552;
% par.c2 = 0.0438;
% par.b2 = 1.8206e-5;
% par.I1 = 0.0297;
% par.m1 = 0.2867-par.m2;
% par.c1 = 0.0717;
% par.b1 = 0.8031;
% par.km = 5.0549;

% Version 2
% par.I2 = 1.8699e-4;
% par.m2 = 0.0553;
% par.c2 = 0.0400;
% par.b2 = 1.8088e-5;
% par.I1 = 0.0297;
% par.m1 = 0.2867-par.m2;
% par.c1 = 0.0717;
% par.b1 = 0.8031;
% par.km = 5.0549;

% Version 3
par.I2 = 1.8364e-4;
par.m2 = 0.0551;
par.c2 = 0.0401;
par.b2 = 1.6576e-5;
par.I1 = 0.0297;
par.m1 = 0.2867-par.m2;
par.c1 = 0.06;
par.b1 = 0.8031;
par.km = 5.0549;

% Specify matrices
matrcomp.P1 = par.m1*par.c1^2+par.m2*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2 = par.m2*par.c2^2 +par.I2;                       % Linear kinetic energy component 2
matrcomp.P3 = par.m2*par.l1*par.c2;                          % Linear kinetic energy component 3
matrcomp.g1 = (par.m1*par.c1+par.m2*par.l1)*par.g;           % Gravity component 1
matrcomp.g2 = par.m2*par.c2*par.g;                           % Gravity component 2