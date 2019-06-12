function Xref = reftrajectory(par,dim)

Xref=zeros(length(par.tpred),4);

for i=0:length(par.tpred)-1
    t=par.Ts*i;
    Xref(i+1,:)=[
               pi;              %theta1
               0;               %theta2
               0;               %dtheta1
               0]';             %dtheta2

end
