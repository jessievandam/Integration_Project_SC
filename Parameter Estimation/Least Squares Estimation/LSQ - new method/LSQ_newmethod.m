%% Parameter estimation without ode solver, theta2
run('dynrotpend.m')
b2_est = 0.00009;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
time_start = 29;
time_end = 3400;
time = theta2.time(1:3372);
data = data(time_start:time_end);

% alphadot = smooth(gradient(y1.Data((tstart:end),1))./gradient(y1.Time(tstart:end)));
dtheta = [0;smooth(gradient(data(1:(end-1)))./gradient(time(1:(end-1))))];
ddtheta = smooth(gradient(dtheta)./gradient(time));

par_est = [par.I2; par.m2; par.c2; b2_est];
beta_est = 0.00009;
lb = [0.00001;0.055;0.04;0];
ub = [0.0002;0.065;0.05;1];
%error_th2 = @(param) asin(-1/(param(2)*par.g*param(3))*(param(1)*ddtheta+param(4)*dtheta))-data;
error_th2_beta = @(beta) asin(-1/(par.m2*par.g*par.c2)*(par.I2*ddtheta+beta*dtheta))-data;
% par_min_th2 = lsqnonlin(error_th2,par_est,lb,ub);
par_min_th2_beta = lsqnonlin(error_th2_beta,beta_est,0,1);

% theta_result = asin(-1/(par_min_th2(2)*par.g*par_min_th2(3))*(par_min_th2(1)*ddtheta+par_min_th2(4)*dtheta));
theta_result_beta = asin(-1/(par.m2*par.g*par.c2)*(par.I2*ddtheta+par_min_th2_beta*dtheta));
figure(1);
hold on;
plot(time,theta_result_beta)
plot(time,data)
legend('ode','real')
title('Linear model vs real data')

VAF_th2 = (1-(var(data-theta_result_beta))/(var(data)))*100;

%% Parameter estimation without ode solver, theta1
run('dynrotpend.m');

b1_est = 4.8;
km_est = 50;

load('LSQ_th1_Chirp_gain03');
data_th1 = theta1.Data;
time_th1 = theta1.time;
input = Chirp.Data(1:(end-2));

vec_est_th1 = [par.I1;(par.m1+par.m2);par.c1;b1_est;km_est];

lb_th1 = [0.00001;0.2;0.04;0;0];
ub_th1 = [0.0002;0.3;0.05;20;1000];

dtheta1 = smooth(gradient(data_th1)./gradient(time_th1));
ddtheta1 = smooth(gradient(dtheta1)./gradient(time_th1));

error_th1 = @(param) asin(-1/(param(2)*par.g*param(3))*(param(1)*ddtheta1+param(4)*dtheta1-param(5)*input))-data_th1;

%error_th1 = @(vec) MakeError_th1(vec,par,data_th1,input);
options = optimoptions(@lsqnonlin,'display','iter-detailed');
par_min_th1 = lsqnonlin(error_th1,vec_est_th1,lb_th1,ub_th1,options);

theta_1_result = asin(-1/(par_min_th1(2)*par.g*par_min_th1(3))*(par_min_th1(1)*ddtheta1+par_min_th1(4)*dtheta1-par_min_th1(5)*input));

VAF_th1 = (1-(var(data_th1-theta_1_result))/(var(data_th1)))*100;