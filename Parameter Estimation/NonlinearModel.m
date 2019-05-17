function ddtheta = NonlinearModel(t,x,u,matrcomp,par)

M = [matrcomp.P1+matrcomp.P2+2*matrcomp.P3*cos(x(2)) matrcomp.P1+matrcomp.P3*cos(x(2));
    matrcomp.P1+matrcomp.P3*cos(x(2)) matrcomp.P2];
C = [-matrcomp.P3*x(4)*sin(x(2)) -matrcomp.P3*(x(3)+x(4))*sin(x(2));
    matrcomp.P3*x(3)*sin(x(2)) 0];
G = [-matrcomp.g1*sin(x(1))-matrcomp.g2*sin(x(1)+x(2));
    -matrcomp.g2*sin(x(1)+x(2))];


ddtheta = pinv(M)*(-C*[x(3);x(4)]-G+u);

end