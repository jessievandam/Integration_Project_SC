clear all

run('parameters.m')
load('u_v.mat')
load('y_rad.mat')
%load('x_par.mat')

% % remove mean from data
y_rad(:,1) = y_rad(:,1)-mean(y_rad(:,1));
y_rad(:,2) = y_rad(:,2)-mean(y_rad(:,2));

% add pi to represent the downwards eq point
y_rad(:,2) = y_rad(:,2)+pi;

% Switch sign of input
u_v = -1*u_v;

V = u_v(1:500,:);
y = y_rad(1:500,:);

ST = 0.01;
%q0 = [y(1,1);y(1,2);(y(2,1)-y(1,1))/ST;(y(2,2)-y(1,2))/ST];
q0 = [0;pi;0;0];
%q0 = [y(1,1);y(1,2);0;0];
f = @(x)parameterfun(x,q0,ST,V,y,par);

x0 = [par.Jp;par.Bp;par.Jr;par.Br;(par.kt*par.km)/par.Rm;par.kt/par.Rm;0.001];
                 
%x0 = x;

opt = optimoptions('lsqnonlin');
opt.Display = 'iter';
opt.MaxFunctionEvaluations = 10^5;
opt.MaxIterations = 10^5;
opt.FunctionTolerance = 1*10^-12;
opt.StepTolerance  = 1*10^-12;

x = lsqnonlin(f,x0,zeros(7,1),[],opt);

q(:,1) = q0;
for k = 1:length(V)
    A = [par.mp*par.Lr^2+(1/4)*par.mp*par.Lp^2*sin(q(2,k))^2+x(3), -((1/2)*par.mp*par.Lp*par.Lr*cos(q(2,k)));
            -(1/2)*par.mp*par.Lp*par.Lr*cos(q(2,k)), x(1)+(1/4)*par.mp*par.Lp^2];
    B  = [-((1/2)*par.mp*par.Lp^2*sin(q(2,k))*cos(q(2,k)))*q(3,k)*q(4,k)-((1/2)*par.mp*par.Lp*par.Lr*sin(q(2,k)))*q(4,k)^2-x(4)*q(3,k)+(x(6))*V(k,:)-x(5)*q(3,k)-x(7)*q(1,k);
        (1/4)*par.mp*par.Lp^2*cos(q(2,k))*sin(q(2,k))*q(3,k)^2+(1/2)*par.mp*par.Lp*par.g*sin(q(2,k))-x(2)*q(4,k)];
    acc_vec = A^-1*B;

    dq = [q(3,k);q(4,k);acc_vec];
    q(:,k+1) = q(:,k)+dq*ST;
    ypar(:,k) = [q(1,k);q(2,k)];
end

data = iddata(y,V,ST);
dataest = iddata(ypar',V,ST);

compare(data,dataest)

parest.mpLp2 = par.mp*par.Lp^2;
parest.mpLr2 = par.mp*par.Lr^2;
parest.mpLpLr = par.mp*par.Lp*par.Lr;
parest.mpLpg = par.mp*par.Lp*par.g;
parest.Jp = x(1);
parest.Bp = x(2);
parest.Jr = x(3);
parest.Br = x(4);
parest.KtKm1Rm = x(5);
parest.Kt1Rm = x(6);
parest.Kw = x(7);
    
save('parest.mat','parest')

% figure,
% plot(ypar(1,:))
% hold on 
% plot(y(:,1))
% 
% figure,
% plot(ypar(2,:))
% hold on 
% plot(y(:,2))
%     