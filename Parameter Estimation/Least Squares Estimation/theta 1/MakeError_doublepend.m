function [error,y0] = MakeError_doublepend(vec,par,par_min_single,data,input)
    l1 = vec(1);
    l2 = vec(2);
    I1 = vec(3);
    m1 = vec(4);
    c1 = vec(5);
    b1 = vec(6);
    km = vec(7);
    
    I2 = par_min_single(1);
    m2 = par_min_single(2);
    c2 = par_min_single(3);
    b2 = par_min_single(4);
    
    t0 = 0:.01:(length(data)-1)/100; 
    for i=1:length(t0)
        input_actual = input(i,1);
        nonlinmodel = @(t,theta) NonlinearModel_v2(t,theta,[input_actual;0],par,l1,l2,I1,I2,m1,m2,c1,c2,b1,b2,km);
        [t,y] = ode45(nonlinmodel,[0 30],[data(1,1);data(2,1);(data(1,5)-data(1,1))/0.04;(data(2,5)-data(2,1))/0.04]);
        y0 = interp1(t,y,t0);
        y0 = y0(i,1);
        Y(i,:) = y0;
    end
%     nonlinmodel = @(t,theta) NonlinearModel_v2(t,theta,[input';zeros(size(input'))],par,l1,l2,I1,I2,m1,m2,c1,c2,b1,b2,km);
%     
%     [t,y] = ode45(nonlinmodel,[0 35],[data(1,1);data(2,1);(data(1,5)-data(1,1))/0.04;(data(2,5)-data(2,1))/0.04]);
%     y0 = interp1(t,y,t0);
%     y0 = y0(:,1);
    error = data(1,:) - Y';
end