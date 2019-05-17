function [dtheta,y] = nonlinmod(t,theta,u,I2,m2,g,c2,b2,varargin)

dtheta(1,1) = theta(2,1);
dtheta(2,1) = 1/I2*(-m2*g*c2*sin(theta(1,1))-b2*theta(2,1));

y = theta(1);
end
