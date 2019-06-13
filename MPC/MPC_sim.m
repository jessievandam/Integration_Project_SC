%% MPC simulink file

clear all; close all; clc

%% Linearized state space model, equilibrium point 1 
% Should still be made dependent on Xref/Uref!!
run('dynrotpend')
par.b1 = par.b1_est;
par.b2 = par.b2_est;
par.km = par.km_est;

frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

% equilibrium 1: [pi;0;0;0]
A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];
    
B_part = frac*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    -1 1 0 0];

%% Discretization
Ts = 0.01; % sample time

sys1 = ss(A_eq1,B,C,zeros(2));
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;
B_eq1_d = B_eq1_d(:,1);
D_eq1_d = D_eq1_d(:,1);


%% Specify MPC object
% sysd_eq1 = ss(A,B,C,D,0.01);
mpcob.predictionhorizon = 10;
mpcob.controlhorizon = 10;
MV.Min = -1;
MV.Max = 1;

MPCobj = mpc(sysd1, Ts,mpcob.predictionhorizon,mpcob.controlhorizon,[],MV);