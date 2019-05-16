function [dtheta,y] = nonlinmod_withCF(t,theta,u,I2,m2,g,c2,b2,mu,r,varargin)

dtheta(1) = theta(2);
dtheta(2) = 1/I2*(-m2*g*c2*sin(theta(1))-b2*theta(2)-mu*(m2*c2*theta(2)^2 + m2*g*cos(theta(1)))*r*sign(theta(2)));

y = theta(1);
end
