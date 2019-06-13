%Identification Fmincon
close all
clear all

%Load desired experiment data
u1 = load('u_t_09053.mat');
y1 = load('y_t_09053.mat');
dat = load('UY_305.mat');
u2 = dat.u_t;
y2 = dat.y_t; 

%Choose initial values for design parameters
par_0 = [0.100000076766013,0.179999924466894,0.0600000383822383,0.0369998475993046,7.76528013495079e-05,0.0599997734003052,0.0450002885575143,1.38025031473599,-9.48404216749001e-06,-6.90462811414762,9.98062277740736e-05,1.36489750177105e-05, 0.4e-3,0.01,0.6];

%Optimisation options
opts = gaoptimset('UseParallel',true);

%Genetic algorithm
x = ga( @(par)nonlinsim_opti(par,u1,y1,u2,y2),15,[],[],[],[],[0.08  0.16  0.04 0.03 0 0.04 0.04 0 0 1 0 0 0.1031 0.00 0.5137],[0.11 0.19 0.08 0.05 0.0001 0.09 0.05 2 0.0001 2 0.0001 0.050 10 0.10 10.5137],[],opts)

%Final result
nonlinsim_opti(x,u1,y1,u2,y2)


