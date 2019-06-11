function [error,y0_th1,y0_th2] = error_doublepend_discr(vec,theta_0,input,par,data_th1,data_th2)

I1 = vec(1);
I2 = vec(2);
m1 = vec(3);
m2 = vec(4);
c1 = vec(5);
c2 = vec(6);
l1 = vec(7);
b1 = vec(8);
b2 = vec(9);
km = vec(10);

matrcomp.P1 = m1*c1^2+m2*l1^2+I1;        % Linear kinetic energy component 1
matrcomp.P2 = m2*c2^2 +I2;                       % Linear kinetic energy component 2
matrcomp.P3 = m2*l1*c2;                          % Linear kinetic energy component 3
matrcomp.g1 = (m1*c1+m2*l1)*par.g;           % Gravity component 1
matrcomp.g2 = m2*c2*par.g;                           % Gravity component 2

frac = -1/(matrcomp.P1*matrcomp.P2-(matrcomp.P3)^2);

% equilibrium 1: [pi;0;0;0]
A_eq1_part = frac*[matrcomp.g1*matrcomp.P2-matrcomp.g2*matrcomp.P3 -matrcomp.g2*matrcomp.P3 b1*matrcomp.P2 -b2*(matrcomp.P2+matrcomp.P3);
             -matrcomp.g1*(matrcomp.P2+matrcomp.P3)+matrcomp.g2*(matrcomp.P1+matrcomp.P3) matrcomp.g2*(matrcomp.P1+matrcomp.P3) -b1*(matrcomp.P2+matrcomp.P3) b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];

A_eq1 = [0 0 1 0;
        0 0 0 1;
        A_eq1_part];

% equilibrium 2: [0;0;0;0]
A_eq2_part = frac*[-matrcomp.g1*matrcomp.P2+matrcomp.g2*matrcomp.P3 matrcomp.g2*matrcomp.P3 b1*matrcomp.P2 -b2*(matrcomp.P2+matrcomp.P3);
             matrcomp.g1*(matrcomp.P2+matrcomp.P3)-matrcomp.g2*(matrcomp.P1+matrcomp.P3) -matrcomp.g2*(matrcomp.P1+matrcomp.P3) -b1*(matrcomp.P2+matrcomp.P3) b2*(matrcomp.P1+matrcomp.P2+2*matrcomp.P3)];
    
A_eq2 = [0 0 1 0;
        0 0 0 1;
        A_eq2_part];
    
B_part = frac*[-matrcomp.P2*km;
         km*(matrcomp.P2+matrcomp.P3)];
     
B = [0 0; 
    0 0; 
    B_part zeros(2,1)];

C = [1 0 0 0;
    0 1 0 0];

%% Discretization
Ts = 0.01; % sample time

x0_eq1 = -A_eq1*[pi;0;0;0];
B_eq1 = [B x0_eq1];
D_eq1 = zeros(2,3);

sys1 = ss(A_eq1,B_eq1,C,D_eq1);
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

%%

theta(1,:) = theta_0;
for i = 1:length(data_th1)-1
    theta(i+1,:) = A_eq1_d*theta(i,:)'+B_eq1_d*[input(i,:);0;1];
end

error = theta(:,1:2)-[data_th1,data_th2];
y0_th1 = theta(:,1);
y0_th2 = theta(:,2);
end