b2_est = 0.0002;
Order = [1 0 2];
Parameters = [par.I2;par.m2;par.g;par.c2;b2_est];
InitialStates = [-pi/2;0];


m = idnlgrey('nonlinmod',Order,Parameters,InitialStates);

m.Parameters(1).Fixed = false;%true;
m.Parameters(2).Fixed = false;%true;
m.Parameters(3).Fixed = false;%true;
m.Parameters(4).Fixed = false;%true;
m.Parameters(5).Fixed = false;%true;

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
%[min,index] = min(data);
data = data(29:end);

data_id = iddata(data,[],0.01);

m2 = nlgreyest(data_id,m);
