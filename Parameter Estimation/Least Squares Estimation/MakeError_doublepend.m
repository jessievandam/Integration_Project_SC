function [error,y0] = MakeError_doublepend(vec,par,par_min_single,data)
    l1 = vec(1);
    l2 = vec(2);
    I1 = vec(3);
    m1 = vec(4);
    c1 = vec(5);
    b1 = vec(6);
    
    I2 = par_min_single(1);
    m2 = par_min_single(2);
    c2 = par_min_single(3);
    b2 = par_min_single(4);
    
    t0 = 0:.01:2.81; 
    nonlinmodel = @(t,theta) NonlinearModel_v2(t,theta,[0;0],par,l1,l2,I1,I2,m1,m2,c1,c2,b1,b2);
    
    [t,y] = ode45(nonlinmodel,[0 3],[-pi;0;-0.5175;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end