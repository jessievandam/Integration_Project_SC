function [dtheta, y] = NonlinearModel_v2(t,theta,u,P1,P2,P3,g1,g2,b1,b2,varargin)

theta(2) = theta(2)-theta(1);

M = [P1+P2+2*P3*cos(theta(2)) P1+P3*cos(theta(2));
    P1+P3*cos(theta(2)) P2];
C = [b1-P3*theta(4)*sin(theta(2)) -P3*(theta(3)+theta(4))*sin(theta(2));
    P3*theta(3)*sin(theta(2)) b2];
G = [-g1*sin(theta(1))-g2*sin(theta(1)+theta(2));
    -g2*sin(theta(1)+theta(2))];

dtheta(1) = theta(3);
dtheta(2) = theta(4);
dtheta(3:4) = pinv(M)*(-C*[theta(3);theta(4)]-G+u);

y = [theta(1); theta(2)];

end