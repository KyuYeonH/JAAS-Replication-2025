% compare exp model with log-linear model
clc;
close all;

% Run first model
dynare test_er_eta01.mod noclearall;
Y(:,1)=oo_.irfs.Y_e_r;
c(:,1)=oo_.irfs.c_e_r;
cp(:,1)=oo_.irfs.cp_e_r;
cip(:,1)=oo_.irfs.cip_e_r;
h(:,1)=oo_.irfs.h_e_r;
pi(:,1)=oo_.irfs.pi_e_r;
w(:,1)=oo_.irfs.w_e_r;
tran(:,1)=oo_.irfs.tran_e_r;
tau(:,1)=oo_.irfs.tau_e_r;
i(:,1)=oo_.irfs.i_e_r;
k(:,1)=oo_.irfs.k_e_r;
qk(:,1)=oo_.irfs.qk_e_r;

% Run second model
dynare test_er_eta04.mod noclearall;
Y(:,2)=oo_.irfs.Y_e_r;
c(:,2)=oo_.irfs.c_e_r;
cp(:,2)=oo_.irfs.cp_e_r;
cip(:,2)=oo_.irfs.cip_e_r;
h(:,2)=oo_.irfs.h_e_r;
pi(:,2)=oo_.irfs.pi_e_r;
w(:,2)=oo_.irfs.w_e_r;
tran(:,2)=oo_.irfs.tran_e_r;
tau(:,2)=oo_.irfs.tau_e_r;
i(:,2)=oo_.irfs.i_e_r;
k(:,2)=oo_.irfs.k_e_r;
qk(:,2)=oo_.irfs.qk_e_r;

% Run third model
dynare test_er_eta06.mod noclearall;
Y(:,3)=oo_.irfs.Y_e_r;
c(:,3)=oo_.irfs.c_e_r;
cp(:,3)=oo_.irfs.cp_e_r;
cip(:,3)=oo_.irfs.cip_e_r;
h(:,3)=oo_.irfs.h_e_r;
pi(:,3)=oo_.irfs.pi_e_r;
w(:,3)=oo_.irfs.w_e_r;
tran(:,3)=oo_.irfs.tran_e_r;
tau(:,3)=oo_.irfs.tau_e_r;
i(:,3)=oo_.irfs.i_e_r;
k(:,3)=oo_.irfs.k_e_r;
qk(:,3)=oo_.irfs.qk_e_r;

% Plot the results
figure('Position', [100, 100, 1200, 800]);
time = 1:25;
zeroline = zeros(1, 25);

subplot(4,3,1)
plot(time, Y(:,1), '--r', time, Y(:,2), '-g', time, Y(:,3), ':b', 'Linewidth', 1.5)
legend('eta=0.1', 'eta=0.4', 'eta=0.6');
xlabel('GDP');
box on;
grid off;

subplot(4,3,2)
plot(time, c(:,1), '--r', time, c(:,2), '-g', time, c(:,3), ':b', 'Linewidth', 1.5)
xlabel('Aggregation Consumption');
box on;
grid off;

subplot(4,3,3)
plot(time, cp(:,1), '--r', time, cp(:,2), '-g', time, cp(:,3), ':b', 'Linewidth', 1.5)
xlabel('Ricardian consumption');
box on;
grid off;

subplot(4,3,4)
plot(time, cip(:,1), '--r', time, cip(:,2), '-g', time, cip(:,3), ':b', 'Linewidth', 1.5)
xlabel('ROT consumption');
box on;
grid off;

subplot(4,3,5)
plot(time, h(:,1), '--r', time, h(:,2), '-g', time, h(:,3), ':b', 'Linewidth', 1.5)
xlabel('Aggregation Labor');
box on;
grid off;

subplot(4,3,6)
plot(time, pi(:,1), '--r', time, pi(:,2), '-g', time, pi(:,3), ':b', 'Linewidth', 1.5)
xlabel('Inflation');
box on;
grid off;

subplot(4,3,7)
plot(time, w(:,1), '--r', time, w(:,2), '-g', time, w(:,3), ':b', 'Linewidth', 1.5)
xlabel('Wage');
box on;
grid off;

subplot(4,3,8)
plot(time, tran(:,1), '--r', time, tran(:,2), '-g', time, tran(:,3), ':b', 'Linewidth', 1.5)
xlabel('Transfer payment');
box on;
grid off;

subplot(4,3,9)
plot(time, tau(:,1), '--r', time, tau(:,2), '-g', time, tau(:,3), ':b', 'Linewidth', 1.5)
xlabel('Tax');
box on;
grid off;

subplot(4,3,10)
plot(time, i(:,1), '--r', time, i(:,2), '-g', time, i(:,3), ':b', 'Linewidth', 1.5)
xlabel('Aggregation Investment');
box on;
grid off;

subplot(4,3,11)
plot(time, k(:,1), '--r', time, k(:,2), '-g', time, k(:,3), ':b', 'Linewidth', 1.5)
xlabel('Capital');
box on;
grid off;

subplot(4,3,12)
plot(time, qk(:,1), '--r', time, qk(:,2), '-g', time, qk(:,3), ':b', 'Linewidth', 1.5)
xlabel('Capital quality');
box on;
grid off;

set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 12 8]);
set(gca, 'LooseInset', get(gca, 'TightInset'));

% Add a title to the entire figure
sgtitle('Effect of a Monetary Policy Shock', 'FontSize', 14, 'FontWeight', 'bold');

%print(gcf, 'Monetary_Policy_Shock_Comparison_HighRes.png', '-dpng', '-r300'); % 300 DPI로 저장