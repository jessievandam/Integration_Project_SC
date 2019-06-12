function Uref = refinput(Xref,par,dim)

Uref = zeros(size(Xref,1),1);

theta1 = Xref(:,1);
theta2 = Xref(:,2);
dtheta1 = Xref(:,3);
dtheta2 = Xref(:,4);
ddtheta1 = zeros(size(Xref,1),1);
ddtheta2 = zeros(size(Xref,1),1);

for i = 1:size(Xref,1)
    u = 1/par.km_est*(ddtheta1(i)*(par.m1*par.c1^2+par.m2*par.l1^2+par.I1...
        +par.m2*par.c2^2+par.I2+2*par.m2*par.l1*par.c2*cos(theta2(i)))...
        +ddtheta2(i)*(par.m2*par.c2^2+par.I2+par.m2*par.l1*par.c2*cos(theta2(i)))...
        + dtheta1(i)*dtheta2(i)*(-2*par.m2*par.l1*par.c2*sin(theta2(i)))...
        + par.b1_est*dtheta1(i)+dtheta2(i)^2*(-par.m2*par.l1*par.c2*sin(theta2(i)))...
        - (par.m1*par.g*par.c1*sin(theta1(i))+par.m2*par.g*par.l1*sin(theta1(i))...
        +par.m2*par.c2*par.g*sin(theta1(i)+theta2(i))));
    Uref(i,:) = u;
end
