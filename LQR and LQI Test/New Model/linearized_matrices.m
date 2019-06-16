%% Linearized, discretized state space model

% equilibrium 1: [pi;0;0;0] DOWN DOWN
[A_eq1, B_eq1, C_eq1, D_eq1] = dlinmod('NonlinearModelSimulink_2016b_eq1',Ts,[pi;0;0;0],0);
linmat.A1 = A_eq1;
linmat.B1 = B_eq1;
linmat.C1 = C_eq1;
linmat.D1 = D_eq1;

% equilibrium 2: [0;0;0;0] UP UP
[A_eq2, B_eq2, C_eq2, D_eq2] = dlinmod('NonlinearModelSimulink_2016b_eq2',Ts,[0;0;0;0],0);
linmat.A2 = A_eq2;
linmat.B2 = B_eq2;
linmat.C2 = C_eq2;
linmat.D2 = D_eq2;

% equilibrium 3: [0;pi;0;0] UP DOWN
[A_eq3, B_eq3, C_eq3, D_eq3] = dlinmod('NonlinearModelSimulink_2016b_eq3',Ts,[0;pi;0;0],0);
linmat.A3 = A_eq3;
linmat.B3 = B_eq3;
linmat.C3 = C_eq3;
linmat.D3 = D_eq3;

% equilibrium 4: [pi;pi;0;0] DOWN UP
[A_eq4, B_eq4, C_eq4, D_eq4] = dlinmod('NonlinearModelSimulink_2016b_eq4',Ts,[pi;pi;0;0],0);
linmat.A4 = A_eq4;
linmat.B4 = B_eq4;
linmat.C4 = C_eq4;
linmat.D4 = D_eq4;

save('linmat.mat', 'linmat');
