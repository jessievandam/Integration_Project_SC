%% Comparing model data to real data - single pendulum
b2_est = 0.00009;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;-Inf];
ub = [0.0002;0.065;0.05;1];

error = @(vec) MakeError(vec,par,data);
par_min_single = lsqnonlin(error,vec_est,lb,ub);

%% Comparing model data to real data - double pendulum
b2_est = 0.00009;
b1_est = 4.8;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

vec_est = [b1_est;b2_est];

%lb = %[0.00001;0.055;0.04;-Inf];
%ub = %[0.0002;0.065;0.05;1];

error = @(vec) MakeError_nonlinmod(vec,matrcomp,data);
par_min_double = lsqnonlin(error,vec_est);