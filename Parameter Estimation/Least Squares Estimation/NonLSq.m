%% Comparing model data to real data - single pendulum without CF, estimate all parameters
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

%% Comparing model data to real data - single pendulum without CF, estimate b2 only
b2_est = 0.00009;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

lb_b2 = 0;
ub_b2 = 10;

error_b2 = @(vec) MakeError_singlepend_b2(vec,par,data);
par_min_single_b2 = lsqnonlin(error_b2,b2_est,lb_b2,ub_b2);

%% Comparing model data to real data - single pendulum with CF
mu_est = 0.15;
r_est = 0.003;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

vec_est_CF = [par.I2;par.m2;par.c2;b2_est;mu_est;r_est];

lb_CF = [0.00001;0.055;0.04;0;0;0.0015];
ub_CF = [0.0002;0.065;0.05;1;10;0.004];

error_single_CF = @(vec) MakeError_singlependwithCF(vec,par,data);
par_min_single_CF = lsqnonlin(error_single_CF,vec_est_CF,lb_CF,ub_CF);

%% Comparing model data to real data - single pendulum with CF without b2
mu_est = 0.15;
r_est = 0.003;
run('dynrotpend.m');
load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data = data(29:3400);

vec_est_CF_nob = [par.I2;par.m2;par.c2;mu_est;r_est];

lb_CF_nob = [0.00001;0.055;0.04;0;0.0015];
ub_CF_nob = [0.0002;0.065;0.05;10;0.004];

error_single_CF_nob = @(vec) MakeError_singlependwithCF_v2(vec,par,data);
par_min_single_CF_nob = lsqnonlin(error_single_CF_nob,vec_est_CF_nob,lb_CF_nob,ub_CF_nob);

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

%% Comparing model data to real data - double pendulum

% load measured senspr data
load('data_medium_meas_nonlinear');
data_sensor_th1 = theta1.Data;
data_sensor_th2 = theta2.Data;

% filter measured sensor data, such that theta_1 makes one quarter circle from
% 0 to -1/2*pi (in sensor data) and theta_2 from 0 to 1/2*pi
data_sensor_th1 = data_sensor_th1(1340:1621);
data_sensor_th2 = data_sensor_th2(1340:1621);

% convert sensor data to the nonlinear model scale
data_th1 = -data_sensor_th1-pi;
data_th2 = data_sensor_th2;

b2_est = 4.8;
lb_double = [0.097;0.097;0.08;0.15;0.055;0];
ub_double = [0.103;0.103;0.12;0.21;0.065;10];
vec_est_double = [par.l1;par.l2;par.I1;par.m1;par.c1;b2_est];

error_double = @(vec) MakeError_doublepend(vec,par,par_min_single,data_th1);
par_min_double = lsqnonlin(error_double,vec_est_double,lb_double,ub_double);
