%% Simulate model for single pendulum, without CF
b2_lin = 4.42687289201465e-05;
b2_noCF = 1.01304008857726e-05; 
b2_CF = 0.0015;
mu = 0.1803;
r = 0.003;
nonlinmodel = @(t,theta) nonlinmod(t,theta,0,par_min_single(1),par_min_single(2),par.g,par_min_single(3),par_min_single(4));
[t_lin,x_lin] = ode45(nonlinmodel, [0 34], [-1/2*pi;0]);
load('Data_real_simplifiedv3');

figure(1);
hold on;
plot(t_lin,x_lin(:,1))
plot(theta2.time(1:3372),-theta2.data(29:3400))
legend('ode','real')
title('Linear model vs real data')

VAF

%% Simulate model for single pendulum, with CF

nonlinmodel_noCF = @(t,theta) nonlinmod(t,theta,0,par.I2,par.m2,par.g,par.c2,b2_lin);
nonlinmodel_withCF = @(t,theta) nonlinmod_withCF(t,theta,0,par.I2,par.m2,par.g,par.c2,b2_CF,mu,r);


[t_noCF,x_noCF] = ode45(nonlinmodel_noCF, [0 60], [-1/2*pi;0]);
[t_CF,x_CF] = ode45(nonlinmodel_withCF,[0 60], [-1/2*pi;0]);





figure(2);
hold on;
plot(t_CF,x_CF(:,1))
plot(theta2.time,-theta2.data)
legend('ode','real')
title('Model with CF vs real data')

figure(3);
hold on
plot(t_noCF,x_noCF(:,1))
plot(theta2.time,-theta2.data)
legend('ode','real')
title('Model without CF vs real data')