%% Linearize/discretize system

[A_discr, B_discr, C_discr, D_discr] = dlinmod('NonlinearModelSimulink_2018av2',0.01,[pi;0;0;0],0);

% Discrete system
Ts = 0.01;
sysd1_eq_1 = ss(A_discr,B_discr,C_discr,D_discr,0.01);

mpcob.predictionhorizon = 10;
mpcob.controlhorizon = 2;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 2;

MPCobj = mpc(sysd1_eq_1, Ts,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);