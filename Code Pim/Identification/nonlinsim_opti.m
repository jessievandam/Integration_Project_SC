function J = nonlinsim_opti(par,u,y,u2,y2)
tic
%% First simulation
%Time 
tspan = [0 u.u_t.Time(end)];

%Initial values for states
X0 = [y.y_t.Data(1,1:2),0,0];

%Input sequence
u = u.u_t;

%ODE solver for simulation - nonlinsim_back for model without motor
%dynamics - nonlinsim for full model
[t,x] = ode45(@(t,x) nonlinsim_back(t,x,u,par),tspan,X0);

%Interpolate result to compare
y_sim = interp1(t,x,y.y_t.Time);

%% Second simulation
%Time
tspan2 = [0 u2.Time(end)];

%Initial values for states
X02 = [y2.Data(1,1:2),0,0];

%ODE solver for simulation
[t2,x2] = ode45(@(t2,x2) nonlinsim_back(t2,x2,u2,par),tspan2,X02);

%Interpolate result to compare
y_sim2 = interp1(t2,x2,y2.Time);

%Cost function
J = norm(y2.Data-y_sim2(:,1:2),2)+norm(y.y_t.Data-y_sim(:,1:2),2)

%Plot if desired
plot(y.y_t)
hold on
plot(t,x(:,1:2))
figure 
plot(y2)
hold on
plot(t2,x2(:,1:2))

par
toc

end
