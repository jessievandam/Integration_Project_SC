clear all; close all; clc;
run('parameters_model.m');

%% Linearized state space model
frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

% equilibrium 1: [pi;0;0;0]
A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];

% equilibrium 2: [0;0;0;0]
A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 par.b1*matrcomp.P2 -par.b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -par.b1*(matrcomp.P2+matrcomp.P3) par.b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
    
B_part = frac*[-matrcomp.P2*par.km;
         par.km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    0 1 0 0];

%% Discretization
Ts = 0.01; % sample time

% Validation Models
x0_eq1 = -A_eq1*[pi;0;0;0];
B_eq1 = [B x0_eq1];
D_eq1 = zeros(2,3);

sys1_val = ss(A_eq1,B_eq1,C,D_eq1);
sysd1_val = c2d(sys1_val,Ts);
A_eq1_d_val = sysd1_val.A;
B_eq1_d_val = sysd1_val.B;
C_eq1_d_val = sysd1_val.C;
D_eq1_d_val = sysd1_val.D;

B_eq1_d2_val = B_eq1_d_val(:,1);
D_eq1_d2_val = D_eq1_d_val(:,1);
xref = B_eq1_d_val(:,3);

% Controller models
sys1 = ss(A_eq1,B,C,zeros(2));
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;
B_eq1_d = B_eq1_d(:,1);
D_eq1_d = D_eq1_d(:,1);

sys2 = ss(A_eq2,B,C,zeros(2));
sysd2 = c2d(sys2,Ts);
A_eq2_d = sysd2.A;
B_eq2_d = sysd2.B;
C_eq2_d = sysd2.C;
D_eq2_d = sysd2.D;

%% PID Controller
Kp = 0; % proportional gain
Ki = 0; % integral gain
Kd = 0; % derivative gain
Tf = 0; % time constant of the first-order derivative filter.
K_PID = pid(Kp,Ki,Kd,Tf);


