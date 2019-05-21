%% Comparing model data to real data - single pendulum without CF
b2_est = 0.00009;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];

error = @(vec) MakeError_singlepend(vec,par,data);
par_min_single = lsqnonlin(error,vec_est,lb,ub);

%% Comparing model data to real data - single pendulum with CF
mu_est = 0.15;
r_est = 0.003;
vec_est_CF = [par.I2;par.m2;par.c2;b2_est;mu_est;r_est];

lb_CF = [0.00001;0.055;0.04;0;0;0.0015];
ub_CF = [0.0002;0.065;0.05;1;10;0.004];

error_single_CF = @(vec) MakeError_singlependwithCF(vec,par,data);
par_min_single_CF = lsqnonlin(error,vec_est_CF,lb,ub);

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

error = @(vec) MakeError_doublepend(vec,matrcomp,data);
par_min_double = lsqnonlin(error,vec_est);