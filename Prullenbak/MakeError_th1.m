function [error,y0] = MakeError_th1(vec,par,data,input)
    I1 = vec(1);
    m1 = vec(2);
    c1 = vec(3);
    b1 = vec(4);
    km = vec(5);

    t0 = 0:.01:(size(data)-1)/100; 
    for i=1:length(t0)
        input_actual = input(i,1);
        nonlinmodel = @(t,theta) nonlinmod_th1(t,theta,input_actual,I1,m1,par.g,c1,b1,km);
%         fun = @(t,x) 1/x^n_actual;
        [t,y] = ode45(nonlinmodel,[0 20],[data(1,1);(data(5,1)-data(1,1))/0.04]);
        %[t,x] = ode15s(fun,tspan,x0);
        y0 = interp1(t,y,t0);
        y0 = y0(i,1);
        Y(i,:) = y0;
    end
%     input_timedependent = @(t) interp1(input_time, input,t);
%     nonlinmodel = @(t,theta) nonlinmod_th1(t,theta,input,I1,m1,par.g,c1,b1,km,input_time);
%     [t,y] = ode45(nonlinmodel,[0 20],[data(1,1);(data(5,1)-data(1,1))/0.04]);

    error = data - Y;
end