function [error,y0] = error_th1_rms(vec,theta_0,input,par,data)
theta(1,:) = theta_0;

for i = 1:length(data)-1
    ddtheta = 1/vec(1)*(-vec(2)*par.g*vec(3)*sin(theta(i,1))-vec(4)*theta(i,2)+vec(5)*input(i,:));
    theta_gradient = [theta(i,2);ddtheta]';

    theta(i+1,:) = theta(i,:)+theta_gradient*par.Ts;
end
y0 = theta(:,1);
error = rms(data - y0);
end
