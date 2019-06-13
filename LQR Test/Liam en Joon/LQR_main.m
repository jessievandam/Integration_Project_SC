clear all
%% 
h = 0.005;

% [theta1, theta1_d, theta_2, theta2_d]
x_op_observer = [0; 0; 0; 0];
x_op_linearise = [pi; 0; pi; 0];
u_op = [0];

%% Linear model generated from simulink model
[A, B, C, D] = dlinmod('sl_model_function_2016', h, x_op_linearise, u_op);

sys = ss(A,B,C,D,h);

%% Tune LQ parameters
% Q = [2 0 4 0];   %DownDown Q 
% R = 1;             %DownDown R

Q = [20 0.04 20 0.02];    %Down up stable
R = 0.1;              %

% Q = [5 0 2 0];    %Down up stable
% R = 1;              %

Q = diag(Q);

Q_k = [0.1 4 0.1 4]; Q_k = diag(Q_k);
R_k = diag([1 1]);

[K_lq,~,~] = dlqr(A, B, Q, R, 0);
A_lq     = A - B * K_lq;
eig(A_lq)

% Observer gain
P = eig(A_lq)'/3;
L = place(A', C', P)';

%% Sine tracking

Amp = 0.5;
Freq = 1;

%%

K(2,:) = K_lq;

%% Linearized by hand
% States are defined as [th1, th2, thd1, thd2]
%[A, B, C, D] = Linearized_model();


%% Simulation
% LQSS = ss(A_lq, G_lq1*B, C, D); 
% 
% %[theta1, theta1_d, theta_2, theta2_d]
% x_0 = [0; 0; 0; 0];
% 
% Tfinal = 0.5;
% t = 0:h:Tfinal;
% T = (1/20);
% r = -0.1*ones(size(t));
% [y,t,x] = lsim(LQSS,r,t, x_0); 
% 
% figure(1)
% stairs(t,y);
% hold on
% 
% legend('Theta_1','Theta_2');
% title('Step response with LQ controller');
% xlabel('Time (seconds)');
% ylabel('Amplitude');
% 
% 
% % %%
% 
% for i = 1:size(x)
%    u(i) = -K_lq*x(i,:)' + G_lq1*r(i); 
% end

%% Animate
% clear x1 x2 y1 y2
% 
% x1(:,1) = sin(y(:,1))*0.1;
% y1(:,1) = cos(y(:,1))*0.1;
% x2(:,1) = x1(:,1) + sin(y(:,2)+y(:,1))*0.1;
% y2(:,1) = y1(:,1) + cos(y(:,2)+y(:,1))*0.1;
% 
% figure(1)
% for i = 1:length(x1)
% plot(0,0,'k-o');
% hold on
% plot(x1(i,1),y1(i,1),'k-o', 'MarkerSize', 8);
% plot(x2(i,1),y2(i,1),'k-o', 'MarkerSize', 8);
% hold off
% axis([-0.5 0.5 -0.5 0.5]);
% pause(1);
% end
