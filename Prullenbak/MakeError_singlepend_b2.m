function [error,y0] = MakeError_singlepend_b2(vec,par,data)
    b2 = vec;

    t0 = 0:.01:33.71; 
    nonlinmodel = @(t,theta) nonlinmod(t,theta,0,par.I2,par.m2,par.g,par.c2,b2);
    
    [t,y] = ode45(nonlinmodel,[0 34],[-pi/2;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end