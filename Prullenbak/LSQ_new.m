%% Least squares, new method, theta 2
run('dynrotpend.m');
b2_est = 0.00009;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
par.startpoint = 29;
par.endpoint = 3800;
par.checkpoint = 3400;
data = data(par.startpoint:par.endpoint);
data = data - mean(data);
par.Ts = 0.01;
endtime = par.endpoint-par.startpoint+1;
time = theta2.time(1:endtime);

%vec_est = [par.I2;par.m2;par.c2;b2_est];
vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];

error = @(vec) error_th2(vec,[-pi/2;0],par,data);
% options = optimoptions(@lsqnonlin,'display','iter-detailed','MaxFunctionEvaluations','10^5');

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;
opt.Algorithm = 'levenberg-marquardt';

par_min_th2_new = lsqnonlin(error,vec_est,lb,ub,opt);

[~,y0] = error_th2(par_min_th2_new,[-pi/2;0],par,data);

VAF_th2_new = (1-var(data-y0)/(var(data)))*100;

data_check = -data_real(par.startpoint:par.checkpoint);
time_check = theta2.time(1:(par.checkpoint-par.startpoint+1));
[~,y0_check] = error_th1(par_min_th2_new,[-pi/2;0],par,data_check);

VAF_th2_new_check = (1-var(data_check-y0_check)/(var(data_check)))*100;

figure; hold on
plot(time, y0)
plot(time,data)
legend('Estimated parameters','Data')
hold off

figure; hold on
plot(time_check,y0_check)
plot(time_check,data_check)
legend('Estimated parameters','Data')
hold off

%% Least squares, new method, theta 2, fmincon

opt_fmincon = optimoptions('fmincon');
opt_fmincon.Display = 'iter';
opt_fmincon.MaxFunctionEvaluations = 10^5;
opt_fmincon.MaxIterations = 10^5;
opt_fmincon.FunctionTolerance = 1*10^-12;
opt_fmincon.StepTolerance  = 1*10^-12;
opt_fmincon.Algorithm = 'interior-point';

[optimal_par,fval,exitflag] = fmincon(error, vec_est,[],[],[],[],lb,ub,[],opt_fmincon);

[~,y0] = error_th2(optimal_par,[-pi/2;0],par,data);
data_check_th2 = -data_real(29:3400);
data_check_th2 = data_check_th2 - mean(data_check_th2);
[~,y0_check_th2] = error_th2(optimal_par,[-pi/2;0],par,data_check_th2);

VAF_th2_fmincon = (1-var(data-y0)/(var(data)))*100;
VAF_th2_fmincon_alldata = (1-var(data_check_th2-y0_check_th2)/(var(data_check_th2)))*100;

%% LSQ fmincon, initial model
run('dynrotpend')
b2_est = 0.00009;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data_start = 29;
data_end = 3700;
time_end = data_start-data_end+1;
data = data(data_start:data_end);
data = data - mean(data);
time = theta2.time;
time = time(data_start:end);

opt_fmincon = optimoptions('fmincon');
opt_fmincon.Display = 'iter';
opt_fmincon.MaxFunctionEvaluations = 10^5;
opt_fmincon.MaxIterations = 10^5;
opt_fmincon.FunctionTolerance = 1*10^-12;
opt_fmincon.StepTolerance  = 1*10^-12;
opt_fmincon.Algorithm = 'interior-point';

vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];

t0 = theta2.time(1:time_end);

error = @(vec) MakeError_singlepend(vec,par,data);
[par_min_fmincon_v2,fval2,exitflag2] = fmincon(error,vec_est,[],[],[],[],lb,ub,[],opt_fmincon);

[~,y0_v2] = MakeError_singlepend(par_min_fmincon_v2,par,data);
VAF_th2_fmincon_v2 = (1-var(data-y0_v2)/(var(data)))*100;

data_check_v2 = -data_real(29:end);
[~,y0_v2_check] = MakeError_singlepend(par_min_fmincon_v2,par,(data_check_v2));
VAF_th2_fmincon_v2_check = (1-var(data_check_v2-y0_v2_check)/(var(data_check_v2)))*100;

figure; hold on
plot(time(data_start:data_end), y0_v2)
plot(time(data_start:data_end),data)
legend('Estimated parameters','Data')
hold off

figure; hold on
plot(time,y0_v2_check)
plot(time,data_check_v2)
legend('Estimated parameters','Data')
hold off
