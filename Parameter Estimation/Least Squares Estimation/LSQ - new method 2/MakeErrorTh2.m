function [error,y0] = MakeErrorTh2(vec,par,data)
    I = vec(1);
    m = vec(2);
    c2 = vec(3);
    b2 = vec(4);

    t0 = 0:.01:((length(data)/100)-0.01); 
    nonlinmodel = @(t,theta) nonlinmod(t,theta,0,I,m,par.g,c2,b2);
    
    [t,y] = ode45(nonlinmodel,[0 round(length(data)/100)],[-pi/2;0]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    
    error = data - y0;
end