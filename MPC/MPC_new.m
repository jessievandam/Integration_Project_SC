%% MPC new linearization 16-06
load('linmat')

%% Equilibrium 1: down-down
Ts = 0.01;
C2 = [1 0 0 0;
    1 1 0 0];
sysd1_downdown = ss(linmat.A1,linmat.B1,C2,linmat.D1,Ts);

mpcob.predictionhorizon = 100;
mpcob.controlhorizon = 5;
% OV(1).Min = -0.2;
% OV(1).Max = 0.2;
% OV(1).MinECR = 1;
% OV(1).MaxECR = 1;
% OV(2).Min = -0.001;
% OV(2).Max = 0.001;
% OV(2).MinECR = 0.05;
% OV(2).MaxECR = 0.05;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [0.3 0.4];
Weights.ManipulatedVariables = 0.3;
% Weights.ManipulatedVariablesRate = 0.3;
DV = [];

Models.Plant = sysd1_downdown;
Models.Disturbance = [];
DV = [];
MPCobj_downdown = mpc(sysd1_downdown, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV,[],DV);

%% Equilibrium 2: up-down
Ts = 0.01;
C_new = [1 0 0 0;
    1 1 0 0];
sysd1_updown = ss(linmat.A3,linmat.B3,C_new,linmat.D3,Ts);

mpcob.predictionhorizon = 100;
mpcob.controlhorizon = 5;
MV.Min = -1;
MV.Max = 1;
% OV(1).Min = -0.15;
% OV(1).Max = 0.15;
% OV(1).MinECR = 1;
% OV(1).MaxECR = 1;
% OV(2).Min = -0.01;
% OV(2).Max = 0.01;
% OV(2).MinECR = 0.05;
% OV(2).MaxECR = 0.05;
Weights.OutputVariables = [2.5 3];
Weights.ManipulatedVariables = 0;
Weights.ManipulatedVariablesRate = 0.2;

MPCobj_updown = mpc(sysd1_updown, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);

%% Equilibrium 3: down-up

Ts = 0.01;
C_new = [1 0 0 0;
    1 1 0 0];
sysd1_downup = ss(linmat.A4,linmat.B4,C_new,linmat.D4,Ts);

mpcob.predictionhorizon = 100;
mpcob.controlhorizon = 5;
MV.Min = -1;
MV.Max = 1;
% OV(1).Min = -0.15;
% OV(1).Max = 0.15;
% OV(1).MinECR = 1;
% OV(1).MaxECR = 1;
% OV(2).Min = -0.01;
% OV(2).Max = 0.01;
% OV(2).MinECR = 0.05;
% OV(2).MaxECR = 0.05;
Weights.OutputVariables = [3 9];
Weights.ManipulatedVariables = 2;
Weights.ManipulatedVariablesRate = 0.5;

MPCobj_downup = mpc(sysd1_downup, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);

%% Equilibrium 4: up-up

Ts = 0.01;
C_new = [1 0 0 0;
    1 1 0 0];
sysd1_upup = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);

mpcob.predictionhorizon = 40;
mpcob.controlhorizon = 10;
MV.Min = -1;
MV.Max = 1;
% OV(1).Min = -0.15;
% OV(1).Max = 0.15;
% OV(1).MinECR = 1;
% OV(1).MaxECR = 1;
% OV(2).Min = -0.01;
% OV(2).Max = 0.01;
% OV(2).MinECR = 0.05;
% OV(2).MaxECR = 0.05;
Weights.OutputVariables = [20 10];
Weights.ManipulatedVariables = 30;%100;
Weights.ManipulatedVariablesRate = 5;

MPCobj_upup = mpc(sysd1_upup, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);


%% Tuning equilibrium 4: up-up

Ts = 0.01;
C_new = [1 0 0 0;
    1 1 0 0];
sysd1_upup = ss(linmat.A2,linmat.B2,C_new,linmat.D2,Ts);

mpcob.predictionhorizon = 50;
mpcob.controlhorizon = 10;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 2;
Weights.ManipulatedVariablesRate = 0.1;
MD = [];
Models.Plant = sysd1_upup;
Models.Disturbance = [];

MPCobj_tuning = mpc(Models, 0.01,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV,[],MD);
review(MPCobj_tuning)

% MPCobj_tuning.DisturbanceVariables.Name = 'MD1';