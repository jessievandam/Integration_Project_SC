function [dtheta, y] = NonlinearModel_v2(t,theta,u,P1,P2,P3,g1,g2,b1,b2,varargin)

theta(2,1) = theta(2,1)-theta(1,1);

M = [P1+P2+2*P3*cos(theta(2,1)) P1+P3*cos(theta(2,1));
    P1+P3*cos(theta(2,1)) P2];
C = [b1-P3*theta(4,1)*sin(theta(2,1)) -P3*(theta(3,1)+theta(4,1))*sin(theta(2,1));
    P3*theta(3,1)*sin(theta(2,1)) b2];
G = [-g1*sin(theta(1,1))-g2*sin(theta(1,1)+theta(2,1));
    -g2*sin(theta(1,1)+theta(2,1))];

dtheta(1,1) = theta(3,1);
dtheta(2,1) = theta(4,1);
dtheta(3:4,1) = pinv(M)*(-C*[theta(3,1);theta(4,1)]-G+u(1:2,1));

y = [theta(1,1); theta(2,1)];
% y = theta(1,1);
end