function predmod = predmodel(A,B,dim)

%% Prediction matrices generation

%prediction matrix from input (model varying along prediction horizon)
% S_bar=zeros(dim.nx*(dim.N+1),dim.nu*dim.N,dim.t);
% for k=1:dim.t
%     mem=zeros(dim.nx,dim.nu*dim.N);
%     for i=1:dim.N
%         S_bar(i*dim.nx+1:(i+1)*dim.nx,:,k)=Ad(:,:,k+i-1)*mem;
%         S_bar(i*dim.nx+1:(i+1)*dim.nx,(i-1)*dim.nu+1:i*dim.nu,k)=Bd(:,:,k+i-1);
%         mem=S_bar(i*dim.nx+1:(i+1)*dim.nx,:,k);
%     end
% end
% 
% %prediction matrix from initial state (model varying along prediction horizon)
T_bar=zeros(dim.nx*dim.N,dim.nx,dim.t);
for k=1:dim.t
    mem=eye(dim.nx);
    T_bar(1:dim.nx,:,k)=mem;
    for i=1:dim.N
        T_bar((i-1)*dim.nx+1:i*dim.nx,:,k)=A(:,:,k+i-1)*mem;
        mem=A(:,:,k+i-1)*mem;
    end
end


S_bar=zeros(dim.nx*dim.N,dim.nu*dim.N,dim.t);
for k=1:dim.t
    mem=zeros(dim.nx,dim.nu*dim.N);
    for i=1:dim.N
        S_bar((i-1)*dim.nx+1:i*dim.nx,:,k)=A(:,:,k+i-1)*mem;
        S_bar((i-1)*dim.nx+1:i*dim.nx,(i-1)*dim.nu+1:i*dim.nu,k)=B(:,:,k+i-1);
        mem=S_bar((i-1)*dim.nx+1:i*dim.nx,:,k);
    end
end
predmod.S=S_bar;
predmod.T=T_bar;

end