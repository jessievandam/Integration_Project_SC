% close all
clear all
clc

%Symbolic variables

syms g L1 L2 m1 m2 I1 I2 c1 c2 Tau b1 b2  M Bc1 Bc2 real   % model parameters: 
syms u                         % absolute displacements: u = [u11; u21; u12; u22]
syms theta theta1 theta2     real  % degrees of freedom (dof): theta = [ theta1; theta2 ]
syms t                       real  % time

syms ud                        real  % absolute velocities
syms thetad theta1d theta2d    real  % time derivitaves of dofs
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

%% Lagrange Equations

% Compute dT/dqd
dT_dqd     = simplify(jacobian(T,thetad))'; 

% - compute D(dT/dqd)/Dt
DdT_Dtdqd =  simplify(jacobian(dT_dqd,t)) ...
            + simplify(jacobian(dT_dqd,theta))  * thetad ...
            + simplify(jacobian(dT_dqd,thetad)) * thetadd;

% - compute dT/dq
dT_dq      = simplify(jacobian(T,theta))' ;    
    
% Compute dV/dq
dV_dq      = simplify(jacobian(V,theta ))' ; 
  
% Compute forces
Q = [Tau*M - b1*theta1d  - b2*(theta1d-theta2d) - Bc2*atan(4*(theta1d-theta2d))- Bc1*atan(4*theta1d);
      -b2*(theta2d-theta1d)-Bc2*atan(4*(theta2d-theta1d))];

% Set up equations
Equations = DdT_Dtdqd - dT_dq + dV_dq -Q;

%Create nonlinear differential equation
sol = solve(Equations,[theta1dd;theta2dd]);
Eq  = [sol.theta1dd; sol.theta2dd];

%%
%Substitute values found in optimization
nonls = subs(Eq,[g L1 m1 m2 I1 I2 c1 c2 b1 b2 M Bc1 Bc2],[9.81 0.100000076766013,0.179999924466894,0.0600000383822383,0.0369998475993046,7.76528013495079e-05,0.0599997734003052,0.0450002885575143,1.38025031473599,-9.48404216749001e-06,-6.90462811414762,9.98062277740736e-05,1.36489750177105e-05]);

%Perform linearization
A = jacobian(nonls,[theta;thetad]);
B = jacobian(nonls,Tau);

A_eq1 = [0 0 1 0; 
         0 0 0 1;
         double(subs(A,[theta;thetad],[0;0;0;0]))]
B_eq1 = [0;0;double(subs(B,[theta;thetad],[0;0;0;0]))]

C = [1 0 0 0;
      0 1 0 0];
D = [0;0];

sys = ss(A_eq1,B_eq1,C,D);
 
%Discretize
h = 0.001;
sysd = c2d(sys,h);

 
 