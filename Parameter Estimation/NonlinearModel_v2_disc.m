function [dtheta, y] = NonlinearModel_v2_disc(theta_0,u,par,l1,l2,I1,I2,m1,m2,c1,c2,b1,b2,km,varargin)

theta(:,1) = theta_0;

P1 = m1*c1^2+m2*l1^2+I1;        % Linear kinetic energy component 1
P2 = m2*c2^2 +I2;                       % Linear kinetic energy component 2
P3 = m2*l1*c2;                          % Linear kinetic energy component 3
g1 = (m1*c1+m2*l1)*par.g;           % Gravity component 1
g2 = m2*c2*par.g;                           % Gravity component 2

for i = 1:length(u)-1
    M = [P1+P2+2*P3*cos(theta(2,i)) P1+P3*cos(theta(2,i));
        P1+P3*cos(theta(2,i)) P2];
    C = [b1-P3*theta(4,i)*sin(theta(2,i)) -P3*(theta(3,i)+theta(4,i))*sin(theta(2,i));
        P3*theta(3,i)*sin(theta(2,i)) b2];
    G = [-g1*sin(theta(1,i))-g2*sin(theta(1,i)+theta(2,i));
        -g2*sin(theta(1,1)+theta(2,1))];
    
    dtheta(1,1) = theta(3,i);
    dtheta(2,1) = theta(4,i);
    dtheta(3:4,1) = pinv(M)*(-C*theta(3:4,i)-G+[km*u(i,:);0]);
    
    theta(:,i+1) = theta(:,i) + dtheta*par.Ts;
end 

y = theta(:,1);
end