function error = MakeError_nonlinmod(vec,matrcomp,data)
    b1 = vec(1);
    b2 = vec(2);

    t0 = 0:.01:33.71; 
    nonlinmodel = @(t,theta) NonlinearModel_v2(t,theta,u,matrcomp.P1,matrcomp.P2,matrcomp.P3,matrcomp.g1,matrcomp.g2,b1,b2);
    
    [t,y] = ode45(nonlinmodel,[0 34],[-pi/2;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end