%% LSQ fmincon, initial model
run('dynrotpend')
b2_est = 0.00009;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
data_start = 29;
data_end = 3000;
time_end = data_start-data_end+1;
data = data(data_start:data_end);
data = data - mean(data);
time = theta2.time;
% time = time(data_start:end);

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

data_check_v2 = -data_real(29:3028);
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

%% LSQ fmincon, initial model, other eq. point
% run('dynrotpend')
b2_est = 0.00009;

load('meas_th2_lefteq');
data_real = theta2.Data;
data = wrapToPi(data_real);
datav2 = data-mean(data);
%data = -data_real;
data_start = 110;
data_end = 1500;
time_end = data_start-data_end+1;
data = -datav2(data_start:data_end);
%data = data - mean(data);
time = theta2.time;
time = time(data_start:end);

opt_fmincon = optimoptions('fmincon');
opt_fmincon.Display = 'iter';
opt_fmincon.MaxFunctionEvaluations = 10^5;
opt_fmincon.MaxIterations = 10^5;
opt_fmincon.FunctionTolerance = 1*10^-15;
opt_fmincon.StepTolerance  = 1*10^-15;
opt_fmincon.Algorithm = 'interior-point';

vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];

t0 = theta2.time(1:time_end);

error = @(vec) MakeError_singlepend(vec,par,data);
[par_min_fmincon_othereq,fval2,exitflag2] = fmincon(error,vec_est,[],[],[],[],lb,ub,[],opt_fmincon);

[~,y0_v2_othereq] = MakeError_singlepend(par_min_fmincon_othereq,par,data);
VAF_th2_fmincon_othereq = (1-var(data-y0_v2_othereq)/(var(data)))*100;

data_check_othereq = -datav2(110:end);
[~,y0_othereq_check] = MakeError_singlepend(par_min_fmincon_othereq,par,(data_check_othereq));
VAF_th2_fmincon_othereq_check = (1-var(data_check_othereq-y0_othereq_check)/(var(data_check_othereq)))*100;

figure; hold on
plot(time(data_start:data_end), y0_v2_othereq,'-.')
plot(time(data_start:data_end),data)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

figure; hold on
plot(time,y0_othereq_check,'-.')
plot(time,data_check_othereq)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off


%% LSQnonlin

run('dynrotpend')
b2_est = 0.00009;

load('meas_th2_lefteq');
data_real = theta2.Data;
data = wrapToPi(data_real);
datav2 = data-mean(data);
%data = -data_real;
data_start = 110;
data_end = 1500;
time_end = data_start-data_end+1;
data = -datav2(data_start:data_end);
%data = data - mean(data);
time = theta2.time;
time = time(data_start:end);

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

vec_est = [par.I2;par.m2;par.c2;b2_est];

lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];

t0 = theta2.time(1:time_end);

error_th2_lsqnonlin = @(vec) MakeErrorTh2(vec,par,data);
par_min_th2_lsq = lsqnonlin(error_th2_lsqnonlin,vec_est,lb,ub,opt);
%[par_min_fmincon_othereq,fval2,exitflag2] = fmincon(error,vec_est,[],[],[],[],lb,ub,[],opt_fmincon);

[~,y0_v2_othereq] = MakeError_singlepend(par_min_th2_lsq,par,data);
VAF_th2_fmincon_othereq = (1-var(data-y0_v2_othereq)/(var(data)))*100;

data_check_othereq = -datav2(110:end);
[~,y0_othereq_check] = MakeError_singlepend(par_min_th2_lsq,par,(data_check_othereq));
VAF_th2_fmincon_othereq_check = (1-var(data_check_othereq-y0_othereq_check)/(var(data_check_othereq)))*100;

figure; hold on
plot(time(data_start:data_end), y0_v2_othereq,'-.')
plot(time(data_start:data_end),data)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off

figure; hold on
plot(time,y0_othereq_check,'-.')
plot(time,data_check_othereq)
legend('Estimated parameters','Measured data')
xlabel('time [sec]');
ylabel('angle [rad]');
hold off
