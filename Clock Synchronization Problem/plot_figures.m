hold on; set(gca, 'fontsize', 16);
yyaxis left; ylabel('Average Life of System (Hours)', 'fontsize', 20);
plot(5 : n_max, mean_life(5 : n_max), '.-', 'markersize', 20, 'Linewidth', 2);
yyaxis right; ylabel('Reliability', 'fontsize', 20);
plot(5 : n_max, reliability(5 : n_max), 'x-', 'markersize', 12, 'Linewidth', 2);
hold off; grid on; box on;
legend('System Life', 'Reliability', 'location', 'southeast');
xlabel('The Number of Nodes', 'fontsize', 20);
title('Reliability and System Life Analysis', 'fontsize', 28);
figure(); hold on;
plot(5 : n_max, reliability(5 : n_max), '-', 'markersize', 12, 'Linewidth', 2);
plot(5 : n_max, available(5 : n_max), '--', 'markersize', 12, 'Linewidth', 2);
hold off; grid on; box on;
legend('Reliability', 'Availability', 'location', 'southeast');
set(gca, 'fontsize', 16); ylim([0 1.005]);
xlabel('The Number of Nodes', 'fontsize', 20);
ylabel('Reliability/Availability', 'fontsize', 20);
title('Reliability and Availability Analysis at 25,000 Hours', 'fontsize', 28);