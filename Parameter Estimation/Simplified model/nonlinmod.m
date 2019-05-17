function [dtheta,y] = nonlinmod(t,theta,u,I2,m2,g,c2,b2,varargin)

<<<<<<< HEAD
dtheta(1,1) = theta(2,1);
%dtheta(2,1) = -b2/(m2*c2^2)*theta(2,1)-g/(c2)*sin(theta(1,1));
dtheta(2,1) = 1/I2*(-m2*g*c2*sin(theta(1,1))-b2*theta(2,1));
=======
dtheta(1) = theta(2);
%dtheta(2) = -b2/(m2*c2^2)*theta(2)-g/(c2)*sin(theta(1));
dtheta(2) = 1/I2*(-m2*g*c2*sin(theta(1))-b2*theta(2));
>>>>>>> 9bbc1c24e48a68199dede056b431c367f2cfdfe8

y = theta(1);
end
