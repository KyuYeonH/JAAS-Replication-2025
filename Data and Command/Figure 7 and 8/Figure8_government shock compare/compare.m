% compare exp model with log-linear model
clc;
close all;

% Run first model
dynare eg_eta01.mod noclearall;
Y(:,1)=oo_.irfs.Y_e_g;
c(:,1)=oo_.irfs.c_e_g;
cp(:,1)=oo_.irfs.cp_e_g;
cip(:,1)=oo_.irfs.cip_e_g;
h(:,1)=oo_.irfs.h_e_g;
hp(:,1)=oo_.irfs.hp_e_g;
hip(:,1)=oo_.irfs.hip_e_g;
pi(:,1)=oo_.irfs.pi_e_g;
w(:,1)=oo_.irfs.w_e_g;
tran(:,1)=oo_.irfs.tran_e_g;
tau(:,1)=oo_.irfs.tau_e_g;
i(:,1)=oo_.irfs.i_e_g;
k(:,1)=oo_.irfs.k_e_g;
qk(:,1)=oo_.irfs.qk_e_g;
g(:,1)=oo_.irfs.g_e_g;

% Run second model
dynare withtax_eg_eta01.mod noclearall;
Y(:,2)=oo_.irfs.Y_e_g;
c(:,2)=oo_.irfs.c_e_g;
cp(:,2)=oo_.irfs.cp_e_g;
cip(:,2)=oo_.irfs.cip_e_g;
h(:,2)=oo_.irfs.h_e_g;
hp(:,2)=oo_.irfs.hp_e_g;
hip(:,2)=oo_.irfs.hip_e_g;
pi(:,2)=oo_.irfs.pi_e_g;
w(:,2)=oo_.irfs.w_e_g;
tran(:,2)=oo_.irfs.tran_e_g;
tau(:,2)=oo_.irfs.tau_e_g;
i(:,2)=oo_.irfs.i_e_g;
k(:,2)=oo_.irfs.k_e_g;
qk(:,2)=oo_.irfs.qk_e_g;
g(:,2)=oo_.irfs.g_e_g;


% Plot the results
figure('Position', [100, 100, 1200, 800]);
time = 1:25;
zeroline = zeros(1, 25);

subplot(4,4,1)
plot(time, Y(:,1), '--r', time, Y(:,2), '-g', 'Linewidth', 1.5)
legend('base', 'tax on capital');
xlabel('GDP');
box on;
grid off;

subplot(4,4,2)
plot(time, c(:,1), '--r', time, c(:,2), '-g', 'Linewidth', 1.5)
xlabel('Aggregation Consumption');
box on;
grid off;

subplot(4,4,3)
plot(time, cp(:,1), '--r', time, cp(:,2), '-g', 'Linewidth', 1.5)
xlabel('Ricardian consumption');
box on;
grid off;

subplot(4,4,4)
plot(time, cip(:,1), '--r', time, cip(:,2), '-g', 'Linewidth', 1.5)
xlabel('ROT consumption');
box on;
grid off;

subplot(4,4,5)
plot(time, h(:,1), '--r', time, h(:,2), '-g', 'Linewidth', 1.5)
xlabel('Aggregation Labor');
box on;
grid off;

subplot(4,4,6)
plot(time, hp(:,1), '--r', time, hp(:,2), '-g', 'Linewidth', 1.5)
xlabel('Ricardian labor');
box on;
grid off;

subplot(4,4,7)
plot(time, hip(:,1), '--r', time, hip(:,2), '-g', 'Linewidth', 1.5)
xlabel('ROT labor');
box on;
grid off;

subplot(4,4,8)
plot(time, pi(:,1), '--r', time, pi(:,2), '-g', 'Linewidth', 1.5)
xlabel('Inflation');
box on;
grid off;

subplot(4,4,9)
plot(time, w(:,1), '--r', time, w(:,2), '-g', 'Linewidth', 1.5)
xlabel('Wage');
box on;
grid off;

subplot(4,4,10)
plot(time, tran(:,1), '--r', time, tran(:,2), '-g', 'Linewidth', 1.5)
xlabel('Transfer payment');
box on;
grid off;

subplot(4,4,11)
plot(time, tau(:,1), '--r', time, tau(:,2), '-g', 'Linewidth', 1.5)
xlabel('Tax');
box on;
grid off;

subplot(4,4,12)
plot(time, i(:,1), '--r', time, i(:,2), '-g', 'Linewidth', 1.5)
xlabel('Aggregation Investment');
box on;
grid off;

subplot(4,4,13)
plot(time, k(:,1), '--r', time, k(:,2), '-g', 'Linewidth', 1.5)
xlabel('Capital');
box on;
grid off;

subplot(4,4,14)
plot(time, qk(:,1), '--r', time, qk(:,2), '-g', 'Linewidth', 1.5)
xlabel('Capital quality');
box on;
grid off;

subplot(4,4,15)
plot(time, g(:,1), '--r', time, g(:,2), '-g', 'Linewidth', 1.5)
xlabel('Government spending');
box on;
grid off;

set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 8]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

% Add a title to the entire figure
sgtitle('Effect of a Government Spending Shock with tax', 'FontSize', 14, 'FontWeight', 'bold');