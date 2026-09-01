%Initialize problem 
clear all
close all

%Set the Parameters
betas=0.9;
alphas=0.35;
deltas=1;
tolerance=0.001;

%Find the steady state
k_ss=((1-betas+betas*deltas)/(alphas*betas))^((1)/(alphas-1));
k_low=0.5*k_ss;
k_high=2*k_ss;

%Discretize the space
n=1001;
k=ones(n,1);
j=k_low;
for i=1:n
    k(i,1)=j;
    j=j+(k_high-k_low)/(n-1);
end

%Initialize the value function
v=zeros(n,n);
for i=1:3000
    v_0=zeros(n,n);
    for z=1:n
        v_0(:,z)=log(k.^alphas-ones(n,1).*k(z)+(1-deltas).*k)+betas.*v(z,i);
    end
    v(:,i+1)=max(v_0,[],2);
    norma=norm(v(:,i+1)-v(:,i));
    i;
    if norma<tolerance
        [val, ind]=max(v_0,[],2)
        break
    end
end

%Construct the plot of the convergence to the fix point
figure;
hold on
for ii = 1:101
 plot(k,v(:,ii))
end
hold off

%Derive the analytical solution (Bellman) Guess and verify with
%V(k)=A+B*ln(k_t)
B=alphas/(1-alphas*betas);
A=1/(1-betas)*((alphas*betas)/(1-alphas*betas)*log(alphas*betas)+log(1-alphas*betas));
v_true=A+B.*log(k);

%plot (tratteggiata la bellman ottenuta con il metodo numerico)
figure;
hold on
plot(k,v_true,'k','LineWidth',1.5)
plot(k,v(:,101),'--k','LineWidth',1.5)
title('V(k)','Fontsize',12)
set(gca,'Fontsize',12)
hold off

%Derive the optimal policy
k_starr=k(ind);

%Optimal policy (analytical)
k_true=alphas.*betas.*k.^alphas

%plot (tratteggiata optimal policy ottenuta con il metodo numerico)
figure;
hold on
plot(k,k_true,'k','LineWidth',1.5)
plot(k,k_starr,'--k','LineWidth',1.5)
title('k*','Fontsize',12)
set(gca,'Fontsize',12)
hold off








    