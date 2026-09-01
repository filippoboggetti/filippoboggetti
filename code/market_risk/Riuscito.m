xx=Returns(:,3)
%Initial guess
 v_0=2
 l_0=0.009
 u_0=0.0001
for z=1:1000
    E_n_i=zeros(length(xx),1)
    for i=1:length(xx)
         E_n_i(i,1)=(v_0+1)/(v_0+l_0*(xx(i,1)-u_0)^2);
    end

    E_log=zeros(length(xx),1);
    for i=1:length(xx)
     val=(v_0+1)/2;
        E_log(i)=psi(val)-log((v_0+l_0*(xx(i,1)-u_0)^2)/2);
    end

    u_0=(sum(xx.*E_n_i))/sum(E_n_i)
    l_0=(1/length(xx)*(sum(((xx-u_0).^2).*E_n_i)))^-1
    syms x
    f=@(x) psi(x/2)-log(x/2)-1-1/length(xx)*sum(E_log)+1/length(xx)*sum(E_n_i)
    c=bisection_method(f,1,3.5,10^-100)
    v_0=c
end
l_0=1/sqrt(l_0)

x=[-0.16:0.01:0.16]
hist=histogram(Returns(:,3),100,'Normalization','pdf')
hold on
plotta=makedist('tLocationScale','mu',u_0,'sigma',l_0,'nu',v_0)

pdf_manuale=pdf(plotta,x)
plot(x,pdf_manuale,'LineWidth',3)

plotta1=makedist('tLocationScale','mu',T1.mu,'sigma',T1.sigma,'nu',T1.nu)

pdf_manuale1=pdf(plotta1,x)
plot(x,pdf_manuale1,'LineWidth',3)
hold off
