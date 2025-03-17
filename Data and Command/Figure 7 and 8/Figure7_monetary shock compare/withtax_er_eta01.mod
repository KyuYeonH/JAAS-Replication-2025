clc;close all;
var c h lamda w i k qk y D Y mc pistar pi f1 f2 b rb g tau rk rn A ksi
    cp cip hp hip kp tranip tran ip tauc tauk tauhp tauhip;
varexo  e_A e_r e_g  e_ksi e_tauh e_tauk e_tauc;
parameters  habit alpha beta delta phi epsilon  Bphi gamma  site  kappa_pi kappa_y kappag_y kappat_g kappat_b
           rho_A rho_g rho_t rho_rn rho_ksi eta iota betaip rho_c psi rho_tauh rho_tauk Q Z;
parameters  BoverY c_ss h_ss lamda_ss w_ss i_ss  k_ss qk_ss  y_ss  D_ss Y_ss  mc_ss pistar_ss pi_ss   
            f1_ss f2_ss b_ss  rb_ss g_ss tau_ss rk_ss  rn_ss cp_ss cip_ss hp_ss hip_ss kp_ss tranip_ss tran_ss
            ip_ss tauc_ss tauk_ss tauh_ss tauhp_ss tauhip_ss;
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
rho_c=0.9;
psi=0.35;
rho_tauh=0.9;
rho_tauk=0.9;
h_ss=1/3;
rb_ss=1/beta-1;
%tauk_ss=0.25;
tauk_ss=0.5;
rk_ss=(1/beta-1+delta)*(1-tauk_ss)^(-1);
qk_ss=1;
pi_ss=1;
pistar_ss=1;
D_ss=1;
tauh_ss=0.06;
tauc_ss=0.09;
tauhp_ss=tauh_ss;
tauhip_ss=tauh_ss;
mc_ss=(epsilon-1)/epsilon;
w_ss=(1-alpha)*(((1+rk_ss-1+delta)^alpha)/(mc_ss*(alpha^alpha)))^(1/(alpha-1));
k_ss=h_ss*(alpha/(1-alpha))*w_ss/(1+rk_ss-1+delta);
i_ss=k_ss*delta;
y_ss=(k_ss^alpha)*(h_ss^(1-alpha));
Y_ss=y_ss;
g_ss=0.2*y_ss;
c_ss=Y_ss-g_ss-i_ss;
lamda_ss=(1-habit*beta)/(c_ss*(1-habit)*(1+tauc_ss));
site=lamda_ss*w_ss*(1-tauh_ss)/(h_ss^phi);
f1_ss=(lamda_ss*mc_ss*Y_ss)/(1-beta*Bphi);
f2_ss=(lamda_ss*Y_ss)/(1-beta*Bphi);
b_ss=BoverY*Y_ss;
rn_ss=rb_ss;
hp_ss=(1-eta)*(1-alpha)*(1-iota)*(y_ss/w_ss);
hip_ss=eta*(1-alpha)*(iota)*(y_ss/w_ss);
cp_ss=(1-eta)*(site*(1-habit*beta)/((1-alpha)*(1-iota)*(1-habit)))*((hp_ss)^(1+phi))/y_ss;
cip_ss=eta*(site*(1-habit*betaip)/((1-alpha)*iota*(1-habit)))*((hp_ss)^(1+phi))/y_ss;
tranip_ss=(1+tauc_ss)*c_ss-(1-tauh_ss)*w_ss*hip_ss;
tran_ss=eta*tranip_ss;
tau_ss=g_ss+rb_ss*b_ss+tran_ss-tauc_ss*c_ss-w_ss*hp_ss*tauh_ss-(1-eta)*tauk_ss*rk_ss*k_ss;
kp_ss=k_ss/(1-eta);
ip_ss=i_ss/(1-eta);
Q=b_ss+tau_ss+tauc_ss*c_ss+w_ss*h_ss*tauh_ss+(1-eta)*tauk_ss*rk_ss*k_ss;
Z=g_ss+(1+rb_ss)*b_ss+tran_ss;
model;
   //cousumers' problem
   %optimal household
lamda+(tauc_ss/(1+tauc_ss))*tauc+(1/(1-habit))*(cp-habit*cp(-1))+(1/(1-habit))*(cp(+1)-habit*cp)=(cp(+1)-habit*cp-habit*beta*(cp-habit*cp(-1)))/((1-habit)*(1-habit*beta));
phi*hp=lamda+w+(tauh_ss/1-tauh_ss)*tauhp;
0=lamda(+1)-lamda+(rb_ss/(1+rb_ss))*rb(+1);
0=lamda(+1)-lamda-(tauk_ss*rk_ss/((1-tauk_ss)*rk_ss+1-delta))*tauk+((1-tauk_ss)*rk_ss/((1-tauk_ss)*rk_ss+1-delta))*rk(+1);
   %rule of thumb houeshold
lamda+(tauc_ss/(1+tauc_ss))*tauc+(1/(1-habit))*(cip-habit*cip(-1))+(1/(1-habit))*(cip(+1)-habit*cip)=(cip(+1)-habit*cip-habit*betaip*(cip-habit*cip(-1)))/((1-habit)*(1-habit*betaip));
phi*hip=lamda+w+(tauh_ss/1-tauh_ss)*tauhip;
    //firms' problem
y=A+alpha*(ksi+k(-1))+(1-alpha)*h;
k(-1)-h=w-(rk_ss*rk+(1+rk_ss)*qk(-1)-(1-delta)*qk-(1-delta)*ksi)/(rk_ss+delta);
mc=-A+(1-alpha)*w+(alpha/(rk_ss+delta))*(rk_ss*rk+(1+rk_ss)*qk(-1)-(1+rk_ss)*ksi-(1-delta)*qk);
k=(1-delta)*(ksi+k(-1))+delta*i;
qk=gamma*(i-i(-1))-beta*gamma*(i(+1)-i);  
    //NKPC
pistar=f1-f2;
f1=((lamda_ss*mc_ss*Y_ss)*(lamda+mc+Y)+beta*Bphi*f1_ss*(epsilon*pi(+1)+f1(+1)))/(lamda_ss*mc_ss*Y_ss+beta*Bphi*f1_ss);
f2=((lamda_ss*Y_ss)*(lamda+Y)+beta*Bphi*f2_ss*((epsilon-1)*pi(+1)+f2(+1)))/(lamda_ss*Y_ss+beta*Bphi*f2_ss);
(1-Bphi)*(1-epsilon)*pistar+Bphi*(epsilon-1)*pi=0;
    //inflation process
D=(1-Bphi)*(-epsilon)*pistar+Bphi*(epsilon*pi+D(-1));
Y+D=y;
    //government
    % budget constraint
(b_ss/Q)*b+(tau_ss/Q)*tau+(tauc_ss*c_ss/Q)*(tauc+c)+(1-eta)*(w_ss*h_ss*tauh_ss/Q)*(w+hp+tauhp)+eta*(w_ss*h_ss*tauh_ss/Q)*(w+hip+tauhip)+(1-eta)*(tauk_ss*rk_ss*k_ss/Q)*(tauk+rk+k)=(g_ss/Z)*g+(rb_ss*b_ss/Z)*rb+((1+rb_ss)*b_ss/Z)*b(-1)+(tran_ss/Z)*tran;
    % government spending policy
g=rho_g*g(-1)+(1-rho_g)*(kappag_y*Y(-1))+e_g;%
tau=rho_t*tau(-1)+(1-rho_t)*(kappat_b*b(-1)+kappat_g*g);%
    //monetary policy
rn=rho_rn*rn(-1)+(1-rho_rn)*(kappa_pi*pi+kappa_y*Y)-e_r;
rb=rn-pi(+1);
   //market clearing
Y_ss*Y=c_ss*c+i_ss*i+g_ss*g;
c=(1-eta)*cp+eta*cip;
h=(1-eta)*hp+eta*hip;
i=ip;
k=kp;
tran=tranip;
(tauc_ss/(1+tauc_ss))*tauc+c=((w_ss*h_ss*(1-tauh_ss))/((1-tauh_ss)*w_ss*h_ss+tran_ss))*(w+hip)-((w_ss*h_ss*tauh_ss)/((1-tauh_ss)*w_ss*h_ss+tran_ss))*tauhip+((tran_ss)/((1-tauh_ss)*w_ss*h_ss+tran_ss))*tranip;

   //external shock
A=rho_A*A(-1)+e_A; %30
ksi=rho_ksi*ksi(-1)+e_ksi; %31
tauc=(1-rho_c)*tauc_ss+rho_c*tauc(-1)+e_tauc; %32
tauhp=(1-rho_tauh)*tauh_ss+rho_tauh*tauhp(-1)+e_tauh; %33
tauhip=(1-rho_tauh)*tauh_ss+rho_tauh*tauhip(-1)+e_tauh; %34
tauk=(1-rho_tauk)*tauk_ss+rho_tauk*tauk(-1)+e_tauk; %35
end;

initval;
c=0;
h=0;
lamda=0;
w=0;
i=0;
k=0;
qk=0; 
y=0;
D=0;
Y=0;     
mc=0;
pistar=0;
pi=0;
f1=0;
f2=0;
b=0;
rb=0;
g=0;
tau=0;
rk=0;
rn=0;
A=0;
ksi=0; 
cp=0;
cip=0;
hp=0;
hip=0;
kp=0;
tranip=0;
tran=0;
ip=0;
tauc=0;
tauk=0;
tauhp=0;
tauhip=0;
end;
steady;
check;
shocks;
var  e_A; stderr   0.00;
var  e_r; stderr   0.01;
var  e_g; stderr   0.00;
var  e_ksi; stderr   0.00;
var  e_tauc; stderr   0.00;
var  e_tauk; stderr   0.00;
var  e_tauh; stderr   0.00;
end;
stoch_simul(order=1,irf=25,hp_filter=1600,conditional_variance_decomposition=[1,10,20,40],noprint);