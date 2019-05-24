function [error,y0] = MakeError_th1(vec,par,data,input)
    I1 = vec(1);
    m1 = vec(2);
    c1 = vec(3);
    b1 = vec(4);
    km = vec(5);

    t0 = 0:.01:(size(data)-1)/100; 
    nonlinmodel = @(t,theta) nonlinmod_th1(t,theta,input,I1,m1,par.g,c1,b1,km);
    
    [t,y] = ode45(nonlinmodel,[0 20],[data(1,1);(data(5,1)-data(1,1))/0.04]);
    y0 = interp1(t,y,t0);
    y0 = y0(:,1);
    error = data - y0;
end