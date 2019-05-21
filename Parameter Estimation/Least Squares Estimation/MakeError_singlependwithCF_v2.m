function error = MakeError_singlependwithCF(vec,par,data)
    I = vec(1);
    m = vec(2);
    c2 = vec(3);
    mu = vec(4);
    r = vec(5);

    t0 = 0:.01:33.71; 
    nonlinmodel = @(t,theta) nonlinmod_withCF_v2(t,theta,0,I,m,par.g,c2,mu,r);
    
    [t,y] = ode45(nonlinmodel,[0 34],[-pi/2;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end