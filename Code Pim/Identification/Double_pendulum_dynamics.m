close all
clear all
clc

%Symbolic variables
syms g L1 L2 m1 m2 I1 I2 c1 c2 Tau b1 b2  M Bc1 Bc2 Kv Kt L R real   % model parameters: 
syms u                         % absolute displacements: u = [u11; u21; u12; u22]
syms theta theta1 theta2 ii    real  % degrees of freedom (dof): theta = [ theta1; theta2 ]
syms t                       real  % time

syms ud                        real  % absolute velocities
syms thetad theta1d theta2d id real  % time derivitaves of dofs
syms thetadd theta1dd theta2dd real  % second time derivatives of dofs 

theta   = [theta1  ; theta2  ];
thetad  = [theta1d ; theta2d ];
thetadd = [theta1dd; theta2dd];

%XY coordinates
u  = [ c1 * cos(theta1);      
       -c1 * sin(theta1);           
       L1 * cos(theta1) + c2 * cos(theta2);
       -L1 * sin(theta1)      - c2 * sin(theta2)];
%XY velocities
ud = jacobian(u,theta)*thetad ;

%Compute energies
T =  1/2*(m2*(ud(3:4)'*ud(3:4)))+1/2*(I1*theta1d^2+I2*theta2d^2);
T = simplify(T);

V =  m1*g*u(1)+ m2*g*u(3) ;

% Lagrange Equations

% Compute dT/dqd
dT_dqd     = simplify(jacobian(T,thetad))'; 

% Compute D(dT/dqd)/Dt
DdT_Dtdqd =  simplify(jacobian(dT_dqd,t)) ...
            + simplify(jacobian(dT_dqd,theta))  * thetad ...
            + simplify(jacobian(dT_dqd,thetad)) * thetadd;

% Compute dT/dq
dT_dq      = simplify(jacobian(T,theta))' ;    
    
% Compute dV/dq
dV_dq      = simplify(jacobian(V,theta ))' ; 
  
% Compute forces
Q = [Kt*ii - b1*theta1d  - b2*(theta1d-theta2d) - Bc2*atan(500*(theta1d-theta2d))/1.5- Bc1*atan(500*theta1d)/1.5;
      -b2*(theta2d-theta1d)-Bc2*atan(500*(theta2d-theta1d))/1.5];

%Motor dynamics
Mot = [L*id+Kv*theta1d+R*ii-M*Tau];
       
% Set up equations
Equations = vertcat(DdT_Dtdqd - dT_dq + dV_dq -Q,Mot);

%Create nonlinear differential equation
sol = solve(Equations,[theta1dd;theta2dd]);
Eq  = [sol.theta1dd; sol.theta2dd; sol.id];
 
%%
%Substitute values found in optimization
nonls = subs(Eq,[g L1 m1 m2 I1 I2 c1 c2 b1 b2 Bc1 Bc2 L Kt R Kv M],[9.81  0.107001615392530   0.165343973632010   0.040783104942133   0.046364080778153   0.000051655820835   0.048856187724916   0.049137116812930   1.636038234993470   0.000031810472615   1.827977549139487   0.000008590269497   0.006045619229031   3.032790298604742   0.098524631245120   1.049678153165582 -7]);

%Perform linearization
A = jacobian(nonls,[theta;thetad;ii]);
A_ang = subs(A,[theta;thetad],[0;0;0;0]);
sol_ii = solve(A_ang(1:2,:),ii)
B = jacobian(nonls,Tau);

A_eq1 = [0 0 1 0 0; 
         0 0 0 1 0;
         double(subs(A,[theta;thetad;ii],[0;0;0;0;0]))]
B_eq1 = [0;0;double(subs(B,Tau,0))]

 C = [1 0 0 0 0;
      0 1 0 0 0];
 D = [0;0];

 sys = ss(A_eq1,B_eq1,C,D);
 
 %Discretize
 h = 0.002;
 sysd = c2d(sys,h);
 