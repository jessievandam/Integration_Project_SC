function [error, y, M_inv] = error_fullmodel(vec,theta_0,input,par,data_th1,data_th2,varargin)

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

theta(1,:) = theta_0;

P1 = m1*c1^2+m2*l1^2+I1;                % Linear kinetic energy component 1
P2 = m2*c2^2 +I2;                       % Linear kinetic energy component 2
P3 = m2*l1*c2;                          % Linear kinetic energy component 3
g1 = (m1*c1+m2*l1)*par.g;               % Gravity component 1
g2 = m2*c2*par.g;                       % Gravity component 2

for i = 1:length(data_th1)-1
    M = [P1+P2+2*P3*cos(theta(i,2)) P1+P3*cos(theta(i,2));
        P1+P3*cos(theta(i,2)) P2];
    C = [b1-P3*theta(i,4)*sin(theta(i,2)) -P3*(theta(i,3)+theta(i,4))*sin(theta(i,2));
        P3*theta(i,3)*sin(theta(i,2)) b2];
    G = [-g1*sin(theta(i,1))-g2*sin(theta(i,1)+theta(i,2));
        -g2*sin(theta(i,1)+theta(i,2))];
    
    dtheta(1,1) = theta(i,3);
    dtheta(2,1) = theta(i,4);
    dtheta(3:4,1) = M^(-1)*(-C*dtheta(1:2,1)-G+km*[input(i,:);0]);
    
    theta(i+1,:) = theta(i,:) + dtheta'*par.Ts;
end
y = theta(:,1:2);
error = y-[data_th1,data_th2];
M_inv = M^(-1);
end