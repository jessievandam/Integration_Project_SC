%% Simulate model
run('dynrotpend.m')
b2_lin = 4.42687289201465e-05;
b2_noCF = 1.01304008857726e-05; 
b2_CF = 0.0015;
b1_nonlin_est =  4.8;
b2_nonlin_est = 0.00009;
mu = 0.1803;
r = 0.003;
nonlinmodel = @(t,theta) nonlinmod(t,theta,0,par.I2,par.m2,par.g,par.c2,b2_lin);
nonlinmodel_noCF = @(t,theta) nonlinmod(t,theta,0,par.I2,par.m2,par.g,par.c2,b2_lin);
nonlinmodel_withCF = @(t,theta) nonlinmod_withCF(t,theta,0,par.I2,par.m2,par.g,par.c2,b2_CF,mu,r);
nonlinmodel_doublepend = @(t,theta) NonlinearModel_v2(t,theta,0,matrcomp.P1,matrcomp.P2,matrcomp.P3,matrcomp.g1,matrcomp.g2,b1_nonlin_est,b2_nonlin_est)


[t_lin,x_lin] = ode45(nonlinmodel, [0 60], [-1/2*pi;0]);
[t_noCF,x_noCF] = ode45(nonlinmodel_noCF, [0 60], [-1/2*pi;0]);
[t_CF,x_CF] = ode45(nonlinmodel_withCF,[0 60], [-1/2*pi;0]);
[t_nonlin,x_nonlin] = ode45(nonlinmodel_doublepend, [0 60], [-pi; 0; -pi/8; 0]);
load('Data_real_simplifiedv3');

figure(1);
hold on;
plot(t_lin,x_lin(:,1))
plot(theta2.time,-theta2.data(29:end))
legend('ode','real')
title('Linear model vs real data')

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

figure(4);
hold on
plot(t_nonlin,x_nonlin(:,1))
%plot(theta2.time,-theta2.data)
legend('ode');%,'real')
title('Full nonlindear model vs real data')
