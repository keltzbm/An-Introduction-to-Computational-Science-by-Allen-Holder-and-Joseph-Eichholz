function [sA,dA]=RandSspd(n,fill_perc)
    if ~exist('fill_perc','var') || isempty(fill_perc)
        fill_perc=0.1;
    end
    nnz=round(n^2*fill_perc);
    nzi=randperm(n^2,nnz/2); nzi=reshape(nzi,[],1);
    [i,j]=ind2sub([n,n],nzi);
    values=rand(numel(nzi,1),1);
    A=sparse(i,j,values,n,n);
    A=(A+A')/2;
    A=A+diag(rand(n,1)+n+1);
    sA=A;
    
    dA=full(A);
    pert=rand(n,n)*0.001;
    dA=dA+pert*pert';