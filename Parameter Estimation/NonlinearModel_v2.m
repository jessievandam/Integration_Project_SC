function [dtheta, y] = NonlinearModel_v2(t,theta,u,par,l1,l2,I1,I2,m1,m2,c1,c2,b1,b2,varargin)

P1 = m1*c1^2+m2*l1^2+I1;        % Linear kinetic energy component 1
P2 = m2*c2^2 +I2;                       % Linear kinetic energy component 2
P3 = m2*l1*c2;                          % Linear kinetic energy component 3
g1 = (m1*c1+m2*l1)*par.g;           % Gravity component 1
g2 = m2*c2*par.g;                           % Gravity component 2

M = [P1+P2+2*P3*cos(theta(2,1)) P1+P3*cos(theta(2,1));
    P1+P3*cos(theta(2,1)) P2];
C = [b1-P3*theta(4,1)*sin(theta(2,1)) -P3*(theta(3,1)+theta(4,1))*sin(theta(2,1));
    P3*theta(3,1)*sin(theta(2,1)) b2];
G = [-g1*sin(theta(1,1))-g2*sin(theta(1,1)+theta(2,1));
    -g2*sin(theta(1,1)+theta(2,1))];

dtheta(1,1) = theta(3,1);
dtheta(2,1) = theta(4,1);
dtheta(3:4,1) = pinv(M)*(-C*[theta(3,1);theta(4,1)]-G+u(1:2,1));

y = theta(1,1);
% y = theta(1,1);
end