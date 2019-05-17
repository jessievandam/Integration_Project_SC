b1_est = 4.8;      % damping of first joint [kg/s]  
b2_est = 0.00009;  % damping of second joint [kg/s]
Order = [2 1 4];
Parameters = [par.P1; par.P2; par.P3; par.g1; par.g2; b1_est; b2_est];
InitialStates = [-pi/2;0];

m = idnlgrey('NonlinearModel_v2',Order,Parameters,InitialStates,0);

m.Parameters(1).Fixed = true;
m.Parameters(2).Fixed = true;
m.Parameters(3).Fixed = true;
m.Parameters(4).Fixed = true;
m.Parameters(5).Fixed = true;
m.Parameters(6).Fixed = false;  % parameter b1
m.Parameters(7).Fixed = false;  % parameter b2

load('Data_real_simplifiedv3');
data_real = theta2.Data;
data = -data_real;
%[min,index] = min(data);
data = data(29:end);

data_id = iddata(data,zeros(size(data)),0.01);

m2 = nlgreyest(data_id,m);