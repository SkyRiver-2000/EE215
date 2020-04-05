% Plot the stem figure of calibration error
figure();
stem(1: 90, mean_error, 'o');
xlim([0 91]); ylim([-1.5 1.5]);

% Plot the 2 times standard error range
hold on; plot(1: 90, 2 * sqrt(var_error), '--');
plot(1: 90, 2 * sqrt(var_error), '--', 'linewidth', 1.5);
plot(1: 90, -2 * sqrt(var_error), '--', 'linewidth', 1.5);
legend('Average error', '2 times of standard error', '-2 times of standard error');
set(gca, 'fontsize', 16);
xlabel('Comparison temperature points','fontsize', 20); ylabel('Calibration Error','fontsize', 20);
title('Error Analysis of spline interpolation','fontsize', 28);
grid on; box on;
