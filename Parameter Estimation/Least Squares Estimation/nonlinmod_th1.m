function [dtheta,y] = nonlinmod_th1(t,theta,u,I1,m1,g,c1,b1,km,varargin)

dtheta(1,1) = theta(2,1);
dtheta(2,1) = 1/I1*(-m1*g*c1*sin(theta(1,1))-b1*theta(2,1)+km*u);

y = theta(1);
end