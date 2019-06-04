function F = parameterfun(x,q0,ST,V,y,par)
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
    F = ypar'-y;
end