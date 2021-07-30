function [T,Tp]=rand_trid(n)

    T=zeros(n);
    T=T+diag(randi(10,n-1,1)+2,1);
    T=T+diag(randi(10,n-1,1)+2,-1);
    T=T+diag(randi(10,n,1)+20);
    
    Tp=T+rand(n,n)*.1;