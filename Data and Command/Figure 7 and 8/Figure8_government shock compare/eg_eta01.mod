clc;close all;
var c h lamda w i k qk y D Y mc pistar pi f1 f2 b rb g tau rk rn A ksi
    cp cip hp hip kp tranip tran ip;
varexo  e_A e_r e_g  e_ksi;
parameters  habit alpha beta delta phi epsilon  Bphi gamma  site  kappa_pi kappa_y    kappag_y kappat_g kappat_b
           rho_A rho_g rho_t rho_rn rho_ksi eta iota betaip;
parameters  BoverY c_ss h_ss lamda_ss w_ss i_ss  k_ss qk_ss  y_ss  D_ss Y_ss  mc_ss pistar_ss pi_ss   
            f1_ss f2_ss b_ss  rb_ss g_ss tau_ss rk_ss  rn_ss cp_ss cip_ss hp_ss hip_ss kp_ss tranip_ss tran_ss
            ip_ss;
habit=0.9;
alpha=0.45;
beta=0.99;
delta=0.025;
phi=0.276;
epsilon=4;   
BoverY=0.4;
Bphi=0.75;        
gamma=2;
kappa_pi=1.5;  
kappa_y=0.125;
kappag_y=0.5;
kappat_g=0.5;
kappat_b=0.1;
rho_A=0.9;
rho_g=0.8;
rho_t=0.8;
rho_rn=0.8;
rho_ksi=0.8;
eta=0.1;
site=2.3337;
iota=0.36;
betaip=0.94;
ParaSet =[habit alpha beta delta phi epsilon BoverY Bphi gamma kappa_pi kappa_y kappag_y kappat_g kappat_b rho_A rho_g rho_t rho_rn rho_ksi eta site iota betaip];
xini = [0.3333]';
[xopt,fval]=broyden(@(x)SolveSteadyState(x,ParaSet),xini)
h_ss=xopt(1);
 [rb_ss rk_ss qk_ss pi_ss pistar_ss D_ss mc_ss w_ss k_ss i_ss y_ss Y_ss g_ss c_ss lamda_ss h_ss f1_ss f2_ss b_ss rn_ss cp_ss cip_ss hp_ss hip_ss tranip_ss tran_ss tau_ss kp_ss ip_ss]=FullSteadyState(xopt,ParaSet);
 [rb_ss rk_ss qk_ss pi_ss pistar_ss D_ss mc_ss w_ss k_ss i_ss y_ss Y_ss g_ss c_ss lamda_ss h_ss f1_ss f2_ss b_ss rn_ss cp_ss cip_ss hp_ss hip_ss tranip_ss tran_ss tau_ss kp_ss ip_ss]
rb_ss=1/beta-1;
rk_ss=1/beta-1+delta;
qk_ss=1;
pi_ss=1;
pistar_ss=1;
D_ss=1;
mc_ss=(epsilon-1)/epsilon;
w_ss=(1-alpha)*(((1+rk_ss-1+delta)^alpha)/(mc_ss*(alpha^alpha)))^(1/(alpha-1));
k_ss=h_ss*(alpha/(1-alpha))*w_ss/(1+rk_ss-1+delta);
i_ss=k_ss*delta;
y_ss=(k_ss^alpha)*(h_ss^(1-alpha));
Y_ss=y_ss;
g_ss=0.2*y_ss;
c_ss=Y_ss-g_ss-i_ss;
lamda_ss=(1-habit*beta)/c_ss/(1-habit);
site=lamda_ss*w_ss/(h_ss^phi);
f1_ss=(lamda_ss*mc_ss*Y_ss)/(1-beta*Bphi);
f2_ss=(lamda_ss*Y_ss)/(1-beta*Bphi);
b_ss=BoverY*Y_ss;
rn_ss=rb_ss;
hp_ss=(1-eta)*(1-alpha)*(1-iota)*(y_ss/w_ss);
hip_ss=eta*(1-alpha)*(iota)*(y_ss/w_ss);
cp_ss=(1-eta)*(site*(1-habit*beta)/((1-alpha)*(1-iota)*(1-habit)))*((hp_ss)^(1+phi))/y_ss;
cip_ss=eta*(site*(1-habit*betaip)/((1-alpha)*iota*(1-habit)))*((hp_ss)^(1+phi))/y_ss;
tranip_ss=c_ss-w_ss*hip_ss;
tran_ss=eta*tranip_ss;
tau_ss=g_ss+rb_ss*b_ss+tran_ss;
kp_ss=k_ss/(1-eta);
ip_ss=i_ss/(1-eta);
model;
   //cousumers' problem
   %optimal household
exp(lamda)=(exp(cp)-habit*exp(cp(-1)))^(-1)-habit*beta*(exp(cp(+1))-habit*exp(cp))^(-1);
site*exp(phi*hp)=exp(lamda+w);
1=beta*exp(lamda(+1)-lamda)*(exp(rk(+1))+1-delta);
1=beta*exp(lamda(+1)-lamda)*(1+exp(rb(+1)));
   %rule of thumb houeshold
exp(lamda)=(exp(cip)-habit*exp(cip(-1)))^(-1)-habit*betaip*(exp(cip(+1))-habit*exp(cip))^(-1);
site*exp(phi*hip)=exp(lamda+w);
    //firms' problem
exp(y)=exp(A+alpha*(ksi+k(-1))+(1-alpha)*h);
exp(k(-1)-h)=(alpha/(1-alpha))*exp(w)/((1+exp(rk))*exp(qk(-1))-exp(qk+ksi)*(1-delta));
exp(mc)=(alpha^(-alpha))*((1-alpha)^(alpha-1))*exp(-A)*exp((1-alpha)*w)*((1+exp(rk))*exp(qk(-1)-ksi)-exp(qk)*(1-delta))^alpha;
exp(k)=(1-delta)*exp(ksi+k(-1))+exp(i)*(1-(gamma/2)*(exp(i-i(-1))-1)^2);
exp(-qk)=1-(gamma/2)*(exp(i-i(-1))-1)^2-gamma*exp(i-i(-1))*(exp(i-i(-1))-1)+beta*exp(lamda(+1)-lamda)*exp(qk(+1)-qk)*exp(2*(i(+1)-i))*gamma*(exp(i(+1)-i)-1);  
    //NKPC
exp(pistar)=(epsilon/(epsilon-1))*exp(f1-f2);
exp(f1)=exp(lamda+mc+Y)+beta*Bphi*exp(epsilon*pi(+1)+f1(+1));
exp(f2)=exp(lamda+Y)  +beta*Bphi*exp((epsilon-1)*pi(+1)+f2(+1));
(1-Bphi)*exp((1-epsilon)*pistar)+Bphi*exp((epsilon-1)*pi)=1;
    //inflation process
exp(D)=(1-Bphi)*exp(-epsilon*pistar)+Bphi*exp(epsilon*pi+D(-1));
exp(Y+D)=exp(y);
    //fiscal policy
exp(b)+exp(tau)=exp(g)+(1+exp(rb))*exp(b(-1))+exp(tran); %문제
g-log(g_ss)=rho_g*(g(-1)-log(g_ss))+(1-rho_g)*(kappag_y*(Y(-1)-log(Y_ss)))+e_g;
tau-log(tau_ss)=rho_t*(tau(-1)-log(tau_ss))+(1-rho_t)*(kappat_b*(b(-1)-log(b_ss)+kappat_g*(g-log(g_ss))));
    //monetary policy
rn-log(rn_ss)=rho_rn*(rn(-1)-log(rn_ss))+(1-rho_rn)*(kappa_pi*(pi-log(1))+kappa_y*(Y-log(Y_ss)))-e_r; %shock의 부호를 -로 바꿈으로 이자율을 낮추는 충격을 구현할 수 있음.
exp(rb)=exp(rn)/exp(pi(+1));
   //market clearing
exp(Y)=exp(c)+exp(i)+exp(g)+((gamma/2)*(exp(i-i(-1))-1)^2)*exp(i);
exp(c)=(1-eta)*exp(cp)+eta*exp(cip);
exp(h)=(1-eta)*exp(hp)+eta*exp(hip);
exp(i)=(1-eta)*exp(ip); %문제
exp(k)=(1-eta)*exp(kp);
exp(tran)=(eta)*exp(tranip); %문제
exp(cip)=exp(w+hip)+exp(tranip); %문제

   //external shock
A=rho_A*A(-1)+e_A;
ksi=rho_ksi*ksi(-1)+e_ksi;
end;

initval;
c=log(c_ss);
h=log(h_ss);
lamda=log(lamda_ss);
w=log(w_ss);
i=log(i_ss);
k=log(k_ss);
qk=log(qk_ss); 
y=log(y_ss);
D=0;
Y=log(Y_ss);     
mc=log(mc_ss);
pistar=0;
pi=0;
f1=log(f1_ss);
f2=log(f2_ss);
b=log(b_ss);
rb=log(rb_ss);
g=log(g_ss);
tau=log(tau_ss);
rk=log(rk_ss);
rn=log(rn_ss);
A=0;
ksi=0; 
cp=log(cp_ss);
cip=log(cip_ss);
hp=log(hp_ss);
hip=log(hip_ss);
kp=log(k_ss/(1-eta));
tranip=log(tranip_ss);
tran=log(tran_ss);
ip=log(ip_ss);
end;
steady;
check;
shocks;
var  e_A;stderr   0.00;
var  e_r ;stderr  0.00;
var  e_g ;stderr   0.01;
var  e_ksi;stderr   0.00;
end;
stoch_simul(order=1,irf=25,hp_filter=1600,conditional_variance_decomposition=[1,10,20,40],noprint)
Y cp cip c hp hip h pi w tran tau i k qk g;