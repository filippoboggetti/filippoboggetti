function Y=EWMASTD(X,d,n_lags,cut)
if cut==1;
    X=X(2:end,1);
else
    X=X;
end 

if n_lags=='maxi';
    t=length(X);
else
    t=n_lags;
end

X_1=X.^2;
weighted=0;
Sum_weights=0;
for i=1:t
    weight=d^(i-1);
    Sum_weights=d^(i-1)+Sum_weights;
    weighted=weight*X_1(i)+weighted;
end

Y=sqrt(weighted/Sum_weights);
    
    