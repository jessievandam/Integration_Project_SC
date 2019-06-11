%% Discretization
Ts = 0.01; % sample time

sys1 = ss(A_eq1,B,C,zeros(2));
sysd1 = c2d(sys1,Ts);
A_eq1_d = sysd1.A;
B_eq1_d = sysd1.B;
C_eq1_d = sysd1.C;
D_eq1_d = sysd1.D;

sys2 = ss(A_eq2,B,C,zeros(2));
sysd2 = c2d(sys2,Ts);
A_eq2_d = sysd2.A;
B_eq2_d = sysd2.B;
C_eq2_d = sysd2.C;
D_eq2_d = sysd2.D;

%% Discretization with offset equilibrium taken into account method 2
A_eq1_d2 = [A_eq1_d ones(4,4); zeros(4,8)];
B_eq1_d2 = [B_eq1_d; zeros(4,2)];
C_eq1_d2 = [C_eq1_d zeros(2,4)];
D_eq1_d2 = D_eq1_d;
x0_eq1 = -A_eq1_d*[pi;0;0;0];

%% Discretization with offset equilibrium taken into account method 3
x0_eq1 = -A_eq1_d*[pi;0;0;0];
A_eq1_d3 = A_eq1_d;
B_eq1_d3 = [B_eq1_d x0_eq1];
C_eq1_d3 = C_eq1_d;
D_eq1_d3 = [D_eq1_d zeros(2,1)];
