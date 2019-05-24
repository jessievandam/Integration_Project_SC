%% Simulate model for single pendulum, without CF
b2_lin = 4.42687289201465e-05;
b2_noCF = 1.01304008857726e-05; 
b2_CF = 0.0015;
mu = 0.1803;
r = 0.003;
t0 = 0:.01:33.71; 

nonlinmodel = @(t,theta) nonlinmod(t,theta,0,par_min_single(1),par_min_single(2),par.g,par_min_single(3),par_min_single(4));
[t_lin,x_lin] = ode45(nonlinmodel, [0 34], [-1/2*pi;0]);
y0 = interp1(t_lin,x_lin,t0);
y0 = y0(:,1);
load('Data_real_simplifiedv3');

figure(1);
hold on;
plot(t_lin,x_lin(:,1))
plot(theta2.time(1:3372),-theta2.data(29:3400))
legend('ode','real')
title('Linear model vs real data')

VAF_singlepend_noCF = (1-(var(-theta2.data(29:3400)-y0))/(var(-theta2.data(29:3400))))*100;


%% Simulate model for single pendulum, without CF, b2 only
t0 = 0:.01:33.71; 

nonlinmodel = @(t,theta) nonlinmod(t,theta,0,par.I2,par.m2,par.g,par.c2,par_min_single_b2);
[t_single_b2,x_single_b2] = ode45(nonlinmodel, [0 34], [-1/2*pi;0]);
y0_b2 = interp1(t_single_b2,x_single_b2,t0);
y0_b2 = y0_b2(:,1);
load('Data_real_simplifiedv3');

figure(1);
hold on;
plot(t0,y0_b2)
plot(theta2.time(1:3372),-theta2.data(29:3400))
legend('ode','real')
title('Linear model vs real data')

VAF_singlepend_b2 = (1-(var(-theta2.data(29:3400)-y0_b2))/(var(-theta2.data(29:3400))))*100;

%% Simulate model for single pendulum, with CF
b2_CF = 0.0015;
mu = 0.1803;
r = 0.003;
t0 = 0:.01:33.71; 

nonlinmodel = @(t,theta) nonlinmod_withCF(t,theta,0,par_min_single_CF(1),par_min_single_CF(2),par.g,par_min_single_CF(3),par_min_single_CF(4),par_min_single_CF(5),par_min_single_CF(6));
[t_CF,x_CF] = ode45(nonlinmodel, [0 34], [-1/2*pi;0]);
y0_CF = interp1(t_CF,x_CF,t0);
y0_CF = y0_CF(:,1);
load('Data_real_simplifiedv3');

figure(1);
hold on;
plot(t_CF,x_CF(:,1))
plot(theta2.time(1:3372),-theta2.data(29:3400))
legend('ode','real')
title('Linear model vs real data')

VAF_singlepend_CF = (1-(var(-theta2.data(29:3400)-y0_CF))/(var(-theta2.data(29:3400))))*100;

%% Simulate model for double pendulum
load('LSQ_double_Chirp');
data_sensor_th1 = theta1.Data;
data_sensor_th2 = theta2.Data;
data_sensor_th1 = data_sensor_th1(2600:end);
data_sensor_th2 = data_sensor_th2(2600:end);

data = [data_sensor_th1';data_sensor_th2'];

t0_double = 0:.01:34.01;

nonlinmodel_double = @(t,theta) NonlinearModel_v2(t,theta,[input';zeros(size(input'))],par,par_min_double(1),par_min_double(2),par_min_double(3),par_min_single(1),par_min_double(4),par_min_single(2),par_min_double(5),par_min_single(3),par_min_double(6),par_min_single(4),par_min_double(7));
[t_double,x_double] = ode45(nonlinmodel_double, [0 35], [data(1,1);data(2,1);(data(1,5)-data(1,1))/0.04;(data(2,5)-data(2,1))/0.04]);
y0_double = interp1(t_double,x_double,t0_double);
y0_double = y0_double(:,1);


figure;
hold on;
plot(t0_double,y0_double)
plot(theta1.time(1:3402),data_sensor_th1)
legend('ode','real')
title('Linear model vs real data')

VAF_double = (1-(var(data_sensor_th1-y0_double))/(var(data_sensor_th1)))*100;
