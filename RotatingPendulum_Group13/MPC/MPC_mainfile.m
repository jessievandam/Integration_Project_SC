%% MPC main

load('linmat')

%% Defining MPCobject

Ts = 0.01;
C_new = [1 0 0 0;
    1 1 0 0];
sysd1_upup = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);

mpcob.predictionhorizon = 50;
mpcob.controlhorizon = 10;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 1;
Weights.ManipulatedVariablesRate = 0.1;
MD = [];
Models.Plant = sysd1_upup;
Models.Disturbance = [];

MPCobj_tuning = mpc(Models, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV,[],MD);