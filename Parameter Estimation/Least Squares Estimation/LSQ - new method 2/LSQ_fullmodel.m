%% LSQ full nonlinear model

run('dynrotpend.m');
par.Ts = 0.01;
b1_est = 4.8;
b2_est = 0.0009;
km_est = 50;

load('meas_double_square04');
data_th1 = theta1.Data(1:500);
data_th2 = theta2.Data(1:500);
% data_th1 = data_th1 - mean(data_th1);
% data_th2 = data_th2 - mean(data_th2);

input = Input.Data;
input_time = Input.Time;

vec_est = [par.I1;par.I2;par.m1;par.m2;par.c1;par.c2;par.l1;b1_est;b2_est;km_est];

theta_0 = [data_th1(1,1);data_th2(1,1);(data_th1(5,1)-data_th1(1,1))/0.04;(data_th2(5,1)-data_th2(1,1))/0.04];
lb = [vec_est(1:7)*0.8;0.00001;0.00001;1];
ub = [vec_est(1:7)*1.2;10;20;1000];

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

error_fullmodel_func = @(vec) error_fullmodel(vec,theta_0,input,par,data_th1,data_th2);

par_min_fullmodel_lsq = lsqnonlin(error_fullmodel_func,vec_est,lb,ub,opt);

[~,y0_fullmodel_lsq] = error_th1(par_min_fullmodel_lsq);

VAF_fullmodel_lsq = (1-var(data_th1-y0_fullmodel_lsq)/(var(data_th1)))*100;

%% Linearized, discretized model

run('dynrotpend.m');
par.Ts = 0.01;
par.b1_est = 4.8;
par.b2_est = 0.0009;
par.km_est = 50;

load('meas_full_square03_30s')
time_start = 1;
time_end = 2000;
data_th1_discr = theta1.data(time_start:time_end);
data_th2_discr = theta2.data(time_start:time_end);
data_time_discr = theta1.time(time_start:time_end);

input_discr = -Input.data;
input_time_discr = Input.time;

vec_est = [par.I1_est;par.I2_est;par.m1_est;par.m2_est;par.c1_est;par.c2_est;par.l1_est;b1_est;b2_est;km_est];

theta_0 = [data_th1_discr(1,1);data_th2_discr(1,1);(data_th1_discr(5,1)-data_th1_discr(1,1))/0.04;(data_th2_discr(5,1)-data_th2_discr(1,1))/0.04];
lb = [vec_est(1:7)*0.8;0.00001;0.00001;1];
ub = [vec_est(1:7)*1.2;10;20;1000];

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-15;
opt.StepTolerance  = 1*10^-15;

error_doublepend = @(vec) error_doublepend_discr(vec,theta_0,input_discr,par,data_th1_discr,data_th2_discr);

[par_min_doublepend_discr,fval,~,exitflag] = lsqnonlin(error_doublepend,vec_est,lb,ub,opt);

[~,y0_th1_doublepend_discr,y0_th2_doublepend_discr] = error_doublepend(par_min_doublepend_discr);

%% Make plots

figure; hold on 
plot(y0_th1_doublepend_discr)
plot(data_th1_discr)
legend('Estimated','True')

figure; hold on
plot(y0_th2_doublepend_discr)
plot(data_th2_discr)
legend('Estimated','True')

%% Calculate VAF
VAF_th1_doublepend_discr = (1-var(data_th1_discr-y0_th1_doublepend_discr)/(var(data_th1_discr)))*100;
VAF_th2_doublepend_discr = (1-var(data_th2_discr-y0_th2_doublepend_discr)/(var(data_th2_discr)))*100;