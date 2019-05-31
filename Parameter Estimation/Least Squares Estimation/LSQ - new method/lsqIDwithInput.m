%% Parameter estimation (Kp) with input
clear all; close all; clc;
load('D:\mphbecker\Desktop\helicopter\Data\DynamicsNoMotor\SysIDnoInput.mat')

%% 
s = tf('s');
wn=parameters(1);
zeta=parameters(2);
offset=parameters(3);
beta10=1;
beta20=3;
tstart = 30;

load('D:\mphbecker\Desktop\helicopter\Data\DynamicsNoMotor\SysIDwithRandomInput.mat')

y_real = y1.Data((tstart:end),1);

alpha = y1.Data((tstart:end),1);
% alphdot2 = (l*s)/(s+l)*alpha;
alphadot = smooth(gradient(y1.Data((tstart:end),1))./gradient(y1.Time(tstart:end)));
alphaddot= smooth(gradient(alphadot)./gradient(y1.Time(tstart:end)));

omega = y1.Data((tstart:end),2);
omegadot = smooth(gradient(omega)./gradient(y1.Time(tstart:end)));
%% Parameter estimation (Wn, zeta, offset) without input
par0=[beta10]; 
lb = [];
ub = [];

% y_sim = -alphaddot/(par(1)^2)+2*par(2)/par(1)*alphadot;

fun=@(par)-alphaddot/(wn^2)-2*zeta/wn*alphadot+par(1)*omega.^2/(wn^2)-offset-y_real;

betas = lsqnonlin(fun,par0,lb,ub);


%%
plot(y1.Time(tstart:end),y_real,'r-',y1.Time(tstart:end),fun(betas)+y_real,'b-')
xlabel('t')
legend('Normal density','Fitted function')

%% VAF
% alpha_est = -alphaddot/(wn^2)-2*zeta/wn*alphadot+betas(1)*omega/(wn^2)+betas(2)*omega.^3/(wn^2)-offset;
alpha_est = fun(betas)+y_real;
VAF = (1-var(alpha-alpha_est)/var(alpha))*100;


