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
par.b1 = 4.8;
par.b2 = 0.0002;
par.km = 50;

% Specify matrices
matrcomp.P1 = par.m1*par.c1^2+par.m2*par.l1^2+par.I1;        % Linear kinetic energy component 1
matrcomp.P2 = par.m2*par.c2^2 +par.I2;                       % Linear kinetic energy component 2
matrcomp.P3 = par.m2*par.l1*par.c2;                          % Linear kinetic energy component 3
matrcomp.g1 = (par.m1*par.c1+par.m2*par.l1)*par.g;           % Gravity component 1
matrcomp.g2 = par.m2*par.c2*par.g;                           % Gravity component 2