function [error,y0] = MakeError_singlepend(vec,par,data)
    I1 = vec(1);
    m1 = vec(2);
    %g = vec(3);
    c1 = vec(3);
    b1 = vec(4);

    t0 = 0:.01:33.71; 
    nonlinmodel = @(t,theta) nonlinmod(t,theta,0,I1,m1,par.g,c1,b1);
    
    [t,y] = ode45(nonlinmodel,[0 34],[data(1,1);(data(5,1)-data(1,1))/0.04]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end