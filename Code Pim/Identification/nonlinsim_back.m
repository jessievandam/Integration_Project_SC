function dx = nonlinsim_back(t,x,u,par)
%Simulation for model without motor dynamics
theta1  = x(1);
theta2  = x(2);
theta1d = x(3);
theta2d = x(4);

%Define parameters
L1 = par(1);m1 = par(2);m2 = par(3); I1 = par(4); I2 = par(5);
c1 = par(6); c2 = par(7); 
b1 = par(8); b2 = par(9); M = par(10); Bc1 = par(11); Bc2 = par(12); g = 9.81;

%Input
Tau = interp1(u.Time,u.Data,t);

%Differential equations
dx(1) = x(3);
dx(2) = x(4);
dx(3) = (3*I2*M*Tau - 2*Bc1*I2*atan(500*theta1d) - 2*Bc2*I2*atan(500*theta1d - 500*theta2d) - 3*I2*b1*theta1d - 3*I2*b2*theta1d + 3*I2*b2*theta2d - 2*Bc1*c2^2*m2*atan(500*theta1d) + 3*M*Tau*c2^2*m2 - 4*Bc2*c2^2*m2*atan(500*theta1d - 500*theta2d) - 3*b1*c2^2*m2*theta1d - 6*b2*c2^2*m2*theta1d + 6*b2*c2^2*m2*theta2d + 3*L1*c2^2*g*m2^2*sin(theta1) + 3*I2*c2*g*m2*sin(theta1 + theta2) + 3*I2*L1*g*m2*sin(theta1) + 3*I2*c1*g*m1*sin(theta1) + 3*L1*c2^3*m2^2*theta1d^2*sin(theta2) + 3*L1*c2^3*m2^2*theta2d^2*sin(theta2) + 6*L1*c2^3*m2^2*theta1d*theta2d*sin(theta2) - 3*L1*b2*c2*m2*theta1d*cos(theta2) + 3*L1*b2*c2*m2*theta2d*cos(theta2) + 3*L1^2*c2^2*m2^2*theta1d^2*cos(theta2)*sin(theta2) - 3*L1*c2^2*g*m2^2*sin(theta1 + theta2)*cos(theta2) + 3*I2*L1*c2*m2*theta2d^2*sin(theta2) + 3*c1*c2^2*g*m1*m2*sin(theta1) - 2*Bc2*L1*c2*m2*atan(500*theta1d - 500*theta2d)*cos(theta2) + 6*I2*L1*c2*m2*theta1d*theta2d*sin(theta2))/(3*(I1*I2 + L1^2*c2^2*m2^2 + I2*L1^2*m2 + I1*c2^2*m2 + I2*c2^2*m2 - L1^2*c2^2*m2^2*cos(theta2)^2 + 2*I2*L1*c2*m2*cos(theta2)));
dx(4) =  -(3*I1*b2*theta2d - 3*I1*b2*theta1d - 2*Bc2*I1*atan(500*theta1d - 500*theta2d) - 2*Bc1*c2^2*m2*atan(500*theta1d) - 2*Bc2*L1^2*m2*atan(500*theta1d - 500*theta2d) + 3*M*Tau*c2^2*m2 - 4*Bc2*c2^2*m2*atan(500*theta1d - 500*theta2d) - 3*L1^2*b2*m2*theta1d + 3*L1^2*b2*m2*theta2d - 3*b1*c2^2*m2*theta1d - 6*b2*c2^2*m2*theta1d + 6*b2*c2^2*m2*theta2d - 3*L1^2*c2*g*m2^2*sin(theta1 + theta2) + 3*L1*c2^2*g*m2^2*sin(theta1) - 3*I1*c2*g*m2*sin(theta1 + theta2) + 3*L1*c2^3*m2^2*theta1d^2*sin(theta2) + 3*L1^3*c2*m2^2*theta1d^2*sin(theta2) + 3*L1*c2^3*m2^2*theta2d^2*sin(theta2) + 6*L1*c2^3*m2^2*theta1d*theta2d*sin(theta2) - 3*L1*b1*c2*m2*theta1d*cos(theta2) - 9*L1*b2*c2*m2*theta1d*cos(theta2) + 9*L1*b2*c2*m2*theta2d*cos(theta2) + 6*L1^2*c2^2*m2^2*theta1d^2*cos(theta2)*sin(theta2) + 3*L1^2*c2^2*m2^2*theta2d^2*cos(theta2)*sin(theta2) - 3*L1*c2^2*g*m2^2*sin(theta1 + theta2)*cos(theta2) + 3*L1^2*c2*g*m2^2*cos(theta2)*sin(theta1) + 3*I1*L1*c2*m2*theta1d^2*sin(theta2) + 3*c1*c2^2*g*m1*m2*sin(theta1) - 2*Bc1*L1*c2*m2*atan(500*theta1d)*cos(theta2) + 3*L1*M*Tau*c2*m2*cos(theta2) - 6*Bc2*L1*c2*m2*atan(500*theta1d - 500*theta2d)*cos(theta2) + 6*L1^2*c2^2*m2^2*theta1d*theta2d*cos(theta2)*sin(theta2) + 3*L1*c1*c2*g*m1*m2*cos(theta2)*sin(theta1))/(3*(I1*I2 + L1^2*c2^2*m2^2 + I2*L1^2*m2 + I1*c2^2*m2 + I2*c2^2*m2 - L1^2*c2^2*m2^2*cos(theta2)^2 + 2*I2*L1*c2*m2*cos(theta2)));
dx = dx';

end