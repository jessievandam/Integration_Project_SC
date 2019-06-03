b2_est = 0.00001;
b2_est = 0.00009;
Order = [1 1 2];
Parameters = [par.I2;par.m2;par.g;par.c2;b2_est];
InitialStates = [-pi/2;0];

%nonlinmod_discrete = c2d(nonlinmod,0.01,'zoh');
m = idnlgrey('nonlinmod',Order,Parameters,InitialStates,0);

m.Parameters(1).Fixed = true;
m.Parameters(2).Fixed = true;
m.Parameters(3).Fixed = true;
m.Parameters(4).Fixed = true;
m.Parameters(5).Fixed = false;%true;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
%[min,index] = min(data);
data = data(29:end);

data_id = iddata(data,zeros(size(data)),0.01);

opt = nlgreyestOptions;
opt.display = 'on';
m2 = nlgreyest(data_id,m, opt);
