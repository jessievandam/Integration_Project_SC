% construct nonlinear model
b1_est = 4.8;      % damping of first joint [kg/s]  
b2_est = 0.00009;  % damping of second joint [kg/s]
Order = [2 1 4];
Parameters = [matrcomp.P1; matrcomp.P2; matrcomp.P3; matrcomp.g1; matrcomp.g2; b1_est; b2_est];
InitialStates = [-pi; -3/2*pi; 0; 0];

m = idnlgrey('NonlinearModel_v2',Order,Parameters,InitialStates,0);

% fix certain parameters
m.Parameters(1).Fixed = true;
m.Parameters(2).Fixed = true;
m.Parameters(3).Fixed = true;
m.Parameters(4).Fixed = true;
m.Parameters(5).Fixed = true;
m.Parameters(6).Fixed = false;  % parameter b1
m.Parameters(7).Fixed = false;  % parameter b2

% load measured senspr data
load('data_medium_meas_nonlinear');
data_sensor_th1 = theta1.Data;
data_sensor_th2 = theta2.Data;

% filter measured sensor data, such that theta_1 makes one quarter circle from
% 0 to -1/2*pi (in sensor data) and theta_2 from 0 to 1/2*pi
data_sensor_th1 = data_sensor_th1(1340:1621);
data_sensor_th2 = data_sensor_th2(1340:1621);

% convert sensor data to the nonlinear model scale
data_th1 = -data_sensor_th1-2*pi;
data_th2 = data_sensor_th2;

% convert to id data
data_id_th1 = iddata(data_th1,zeros(size(data_th1)),0.01);
data_id_th2 = iddata(data_th2,zeros(size(data_th2)),0.01);

% compare sensor real data with nonlinear model data
m_th1 = nlgreyest(data_id_th1,m(1));
m_th2 = nlgreyest(data_id_th2,m(2));

