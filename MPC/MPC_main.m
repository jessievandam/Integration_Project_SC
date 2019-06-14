%% Linearize/discretize system

% [A_discr, B_discr, C_discr, D_discr] = dlinmod('NonlinearModelSimulink_2016B_v2',0.01,[pi;0;0;0],0);
A_discr = [0.999 3.3602E-5 0.0076 8.2770E-7;
    -0.0054 0.9942 0.0051 0.0099;
    -0.0269 0.0061 0.5630 1.6287E-4;
    -1.0767 -1.1477 0.9331 0.9811];

B_discr = [-0.0155; 0.0335; -2.8340; 6.0888];
C_discr = [1 0 0 0;
    0 1 0 0];
D_discr = [0;0];
% Discrete system
Ts = 0.01;
sysd1_eq1 = ss(A_discr,B_discr,C_discr,D_discr,0.01);

mpcob.predictionhorizon = 10;
mpcob.controlhorizon = 2;
MV.Min = -1;
MV.Max = 1;
Weights.OutputVariables = [1 1];
Weights.ManipulatedVariables = 2;

MPCobj = mpc(sysd1_eq1, Ts,mpcob.predictionhorizon,mpcob.controlhorizon,Weights,MV);