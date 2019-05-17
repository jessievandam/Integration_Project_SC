b2_est = 0.00009; % damping of joint [kg/s]
mu_est = 0.15;    % friction coefficient for contact between ring and cylinder [-]
r_est = 0.003;    % radius of fixed rigid cylinder [m]
Order = [1 0 2];
Parameters = [par.I2;par.m2;par.g;par.c2;b2_est;mu_est;r_est];
InitialStates = [-pi/2;0];

m = idnlgrey('nonlinmod_withCF',Order,Parameters,InitialStates);

m.Parameters(1).Fixed = true;
m.Parameters(2).Fixed = true;
m.Parameters(3).Fixed = true;
m.Parameters(4).Fixed = true;
m.Parameters(5).Fixed = false;
m.Parameters(6).Fixed = false;
m.Parameters(7).Fixed = true;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
%[min,index] = min(data);
data = data(29:end);

data_id = iddata(data,[],0.01);

m2 = nlgreyest(data_id,m);
