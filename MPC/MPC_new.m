%% MPC new linearization 16-06
load('linmat')

%% Equilibrium 1: down-down
Ts = 0.01;
C2 = [1 0 0 0;
    1 1 0 0];
sysd1_downdown = ss(linmat.A2,linmat.B2,C2,linmat.D2,Ts);

mpcob.predictionhorizon = 50;
mpcob.controlhorizon = 10;
OV.Min = [-0.2 -0.01];
OV.Max = [0.2 0.01];
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 0;

MPCobj_downdown = mpc(sysd1_downdown, 0.001,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);

%% Equilibrium 2: up-down

C_new = [1 0 0 0;
    1 1 0 0];
sysd1_updown = ss(linmat.A3,linmat.B3,C_new,linmat.D3,Ts);

mpcob.predictionhorizon = 150;
mpcob.controlhorizon = 10;
MV.Min = -1;
MV.Max = 1;
OV.Min = [-0.2 -0.01];
OV.Max = [0.2 0.01];
Weights.OutputVariables = [0.1 1];
Weights.ManipulatedVariables = 0.1;

MPCobj_updown = mpc(sysd1_updown, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);

%% Equilibrium 3: down-up

C_new = [1 0 0 0;
    1 1 0 0];
sysd1_downup = ss(linmat.A4,linmat.B4,C_new,linmat.D4,Ts);

mpcob.predictionhorizon = 10/0.01;
mpcob.controlhorizon = 10;
% MV.Min = -1;
% MV.Max = 1;
Weights.OutputVariables = [0.6 0.9];
Weights.ManipulatedVariables = 0.6;
Weights.ManipulatedVariablesRate = 0.3320;

MPCobj_downup = mpc(sysd1_updown, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,[],OV);
