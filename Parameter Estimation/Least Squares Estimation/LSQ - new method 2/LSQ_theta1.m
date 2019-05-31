%% Theta 1, LSQ method Daan-Peppie
run('dynrotpend.m');
par.Ts = 0.01;
b1_est = 4.8;
km_est = 50;

load('LSQ_th1_Chirp_gain04');
data_th1 = -theta1.Data(1:end);
data_th1 = data_th1 - mean(data_th1);
time = theta1.time;

input = Chirp.Data;
input_time = Chirp.Time;

vec_est = [par.I1;(par.m1+par.m2);par.c1;b1_est;km_est];

theta_0 = [data_th1(1,1);(data_th1(5,1)-data_th1(1,1))/0.04];
%lb_th1 = [0.001;0.2;0.04;0;1];
%ub_th1 = [0.2;0.3;0.08;20;1000];
lb_th1 = [vec_est(1:3)*0.8;0;1];
ub_th1 = [vec_est(1:3)*1.2;20;1000];

opt_fmincon = optimoptions('fmincon');
opt_fmincon.Display = 'iter';
opt_fmincon.MaxFunctionEvaluations = 10^5;
opt_fmincon.MaxIterations = 10^5;
opt_fmincon.FunctionTolerance = 1*10^-12;
opt_fmincon.StepTolerance  = 1*10^-12;
opt_fmincon.Algorithm = 'interior-point';

error_th1_rms = @(vec) error_th1_rms(vec,theta_0,input,par,data_th1);
% options = optimoptions(@lsqnonlin,'display','iter-detailed');
[par_min_th1,fval,exitflag] = fmincon(error_th1_rms,vec_est,[],[],[],[],lb_th1,ub_th1,[],opt_fmincon);

[~,y0] = error_th1_rms(par_min_th1);
VAF_th1 = (1-var(data_th1-y0)/(var(data_th1)))*100;

figure; hold on
plot(time, y0)
plot(time,data_th1)
legend('model','data')

%% Theta 1, lsqnonlin

run('dynrotpend.m');
par.Ts = 0.015;
b1_est = 4.8;
km_est = 50;

load('LSQ_th1_Chirp_gain04');
data_th1 = -theta1.Data(1:end);
data_th1 = data_th1 - mean(data_th1);
time = theta1.time;

input = Chirp.Data;
input_time = Chirp.Time;

vec_est = [par.I1;(par.m1+par.m2);par.c1;b1_est;km_est];

theta_0 = [data_th1(1,1);(data_th1(5,1)-data_th1(1,1))/0.04];
% lb_th1 = [0.001;0.2;0.04;0;1];
% ub_th1 = [0.2;0.3;0.08;20;1000];
lb_th1 = [vec_est(1:3)*0.8;0;1];
ub_th1 = [vec_est(1:3)*1.2;20;1000];

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

error_th1 = @(vec) error_th1(vec,theta_0,input,par,data_th1);

par_min_th1_lsq = lsqnonlin(error_th1,vec_est,lb_th1,ub_th1,opt);

[~,y0_th1] = error_th1(par_min_th1_lsq);

VAF_th1_lsq = (1-var(data_th1-y0_th1)/(var(data_th1)))*100;

figure; hold on
plot(time, y0_th1)
plot(time,data_th1)
legend('model','data')
