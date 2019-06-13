%% Main MPC file
% 
clear all
clc
close all

%% Define parameters/dataset
run('dynrotpend')
par.Ts = 0.01;                  % Sampling time
par.Tf = 50;                    % Final time
par.tpred = 0:par.Ts:par.Tf;    % Time for generation of prediction model
par.theta0 = zeros(4,1);        % Initial conditions

dim.nx = 4;                     % Number of states
dim.nu = 2;                     % Number of inputs
dim.N = 20;                      % Length receding horizon
dim.t = length(par.tpred)-dim.N;

weights.Q = 100*diag([1 1 1 1]);
weights.R = eye(dim.nu)/10;
weights.P = zeros(dim.nx);

Xref = reftrajectory(par,dim);
Uref = refinput(Xref,par, dim);

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
    0 1 0 0];

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

for i = 1:size(Xref,1)
    A(:,:,i) = sysd1.A;
    B(:,:,i) = sysd1.B;
end


%% Compute prediction model and quadratic costs
prediction = predmodel(A,B,dim);
quadcost = quadprob(prediction,weights,dim);

%% Inputs for LTV system

e=zeros(dim.t+1,dim.nx);
e(1,:)=[0.5 0.5 0 0];          %start from a nonzero initial error
uB=zeros(dim.t,dim.nu);

for k=1:dim.t
    uBopt=quadprog(quadcost.H(:,:,k),quadcost.h(:,:,k)*e(k,:)');
    uB(k,:)=uBopt(1:dim.nu)';
    e(k+1,:)=A(:,:,k)*e(k,:)'+B(:,:,k)*uB(k,:)';
end


%plot(e)
legend('theta1','theta2','dtheta1','dtheta2')

% %% Specify MPC object
% 
% [A,B,C,D] = dlinmod('NonlinearModelSimulink_2016b',0.01,[pi;0;0;0]);
% % A = [0.9999 3.3602e-05 0.0076 8.2770e-07;
% %     -0.0054 0.9942 0.0051 0.0099;
% %     -0.0269 0.0061 0.5630 1.6278e-04;
% %     -1.0767 -1.1477 0.9331 0.9811];
% % B = [0.0155; -0.0335; 2.8340;-6.0888];
% C = [1 0 0 0;
%     0 1 0 0];
% D = [0; 0];
% 
% sysd_eq1 = ss(A,B,C,D,0.01);
% mpcob.predictionhorizon = 10;
% mpcob.controlhorizon = 10;
% MV.Min = -1;
% MV.Max = 1;
% 
% MPCobj = mpc(sysd_eq1, Ts,mpcob.predictionhorizon,mpcob.controlhorizon,[],MV);