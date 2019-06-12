function quadcost = quadprob(prediction,weights,dim)

Q_bar=blkdiag(kron(eye(dim.N-1),weights.Q),weights.P);
R_bar=kron(eye(dim.N),weights.R);

H=zeros(dim.N*dim.nu,dim.N*dim.nu,dim.t);
h=zeros(dim.N*dim.nu,dim.nx,dim.t);

for k=1:dim.t
    H(:,:,k)=((R_bar+prediction.S(:,:,k)'*Q_bar*prediction.S(:,:,k))+(R_bar+prediction.S(:,:,k)'*Q_bar*prediction.S(:,:,k))')/2;
    h(:,:,k)=prediction.S(:,:,k)'*Q_bar*prediction.T(:,:,k); 
end

quadcost.H=H;
quadcost.h=h;

end