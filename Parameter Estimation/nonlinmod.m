function [dtheta,y] = nonlinmod(t,theta,u,I2,m2,g,c2,b2,varargin)

dtheta(1) = theta(2);
dtheta(2) = 1/I2*(-m2*g*c2*sin(theta(1))-b2*theta(2));

y = theta(1);
end
