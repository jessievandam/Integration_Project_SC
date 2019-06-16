%% MPC new linearization 16-06
load('linmat')

%% Equilibrium 1: down-down
Ts = 0.002;
C2 = [1 0 0 0;
    1 1 0 0]
sysd1_downdown = ss(linmat.A2,linmat.B2,C2,linmat.D2,Ts);

mpcob.predictionhorizon = 10;
mpcob.controlhorizon = 2;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 0;

MPCobj_down = mpc(sysd1_downdown, Ts,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);