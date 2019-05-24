function [error,y0] = MakeError_singlepend(vec,par,data)
    I = vec(1);
    m = vec(2);
    %g = vec(3);
    c2 = vec(3);
    b2 = vec(4);

    t0 = 0:.01:33.71; 
    nonlinmodel = @(t,theta) nonlinmod(t,theta,0,I,m,par.g,c2,b2);
    
    [t,y] = ode45(nonlinmodel,[0 34],[-pi/2;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end