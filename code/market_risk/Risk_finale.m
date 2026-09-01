%Importing data
dati=xlsread('Data.xlsx',...
    'Parametric','B:D');

%Parametric Approach (Assunte correlazioni stabili, ricky controlla Sironi)
Returns=zeros(1796,3);
EW_sd=zeros(3,1);
for s=1:3
    
    Stock=dati(:,s);
    Stock=flip(Stock);
    returns=zeros(length(Stock)-1,1);
    for i=1:length(returns)
     returns(i,1)=log(Stock(i+1,1)/Stock(i,1));
    end
    returns=flip(returns);
    Returns(:,s)=returns;
%'maxi' for the whole dataset, cut=1 to cut the first day
    vol=EWMASTD(returns,0.94,'maxi',1);
    EW_sd(s,1)=vol;
end
Corr_matrix=corrcoef(Returns);
VAR_d=zeros(3,0);
for i=1:3
    VAR_d(i,1)=100*(1-exp(EW_sd(i,1)*norminv(0.05)));
end
Final_var_d=(VAR_d'*Corr_matrix*VAR_d)^0.5

VAR_10d=zeros(3,0);
for i=1:3
    VAR_10d(i,1)=100*(1-exp(EW_sd(i,1)*sqrt(10)*norminv(0.05)));
end
Final_var_10d=(VAR_10d'*Corr_matrix*VAR_10d)^0.5

%Check normality assumptions
% Create plots
t = tiledlayout(3,1);
nexttile
one=histfit(Returns(:,1),100)
nexttile
histfit(Returns(:,1),100)
nexttile
histfit(Returns(:,1),100)

%Fitting has been done with the Distribution fitter, results reported

v=2.81
u=0.01
s=0.01
xx=Returns(:,1)
for f=1:1000
    w_i=zeros(length(xx),1);
    for z=1:length(xx)
        w_i(z,1)=((v+1)*s)/(v*s+(xx(z,1)-u)^2);
    end
    u=sum(w_i.*xx)/sum(w_i);
    s=sum(w_i.*((xx-u).^2))/length(xx);
    tau=zeros(length(w_i),1)
    for z=1:length(w_i)
        tau(z,1)=log(w_i(z,1))-w_i(z,1);
    end
  % Setting x as symbolic variable
syms x;

% Input Section
y = -psi(x/2)+log(x/2)+1/length(w_i)*tt+1==0
a = v_0
b = v_0+2
e = 0.0000001

% Finding Functional Value
fa = eval(subs(y,x,a));
fb = eval(subs(y,x,b));

% Implementing Bisection Method
if fa*fb > 0 
    disp('Given initial values do not bracket the root.');
else
    c = (a+b)/2;
    fc = eval(subs(y,x,c));
    fprintf('\n\na\t\t\tb\t\t\tc\t\t\tf(c)\n');
    while abs(fc)>e
        fprintf('%f\t%f\t%f\t%f\n',a,b,c,fc);
        if fa*fc< 0
            b =c;
        else
            a =c;
        end
        c = (a+b)/2;
        fc = eval(subs(y,x,c));
    end
    fprintf('\nRoot is: %f\n', c);
    v=c
end
    
end



x=[-0.16:0.01:0.16]
hist=histogram(Returns(:,3),100,'Normalization','pdf')
hold on
plotta=makedist('tLocationScale','mu',u,'sigma',sqrt(s),'nu',v)

pdf_manuale=pdf(plotta,x)
plot(x,pdf_manuale,'LineWidth',3)

plotta1=makedist('tLocationScale','mu',T_1.mu,'sigma',T_1.sigma,'nu',T_1.nu)

pdf_manuale1=pdf(plotta1,x)
plot(x,pdf_manuale1,'LineWidth',3)










