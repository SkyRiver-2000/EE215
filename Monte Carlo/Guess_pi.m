tic;
times_sim = 1e7;
a = rand(1, times_sim) * 2;
b = rand(1, times_sim) * 2 * pi;
y = a + cos(b);

cross_times = sum(y >= 2 | y <= 0);
pi_guess = times_sim / cross_times;
fprintf('The execution time is: %.2f s\n', toc);
fprintf('The evaluated value of pi is: %.4f\n', pi_guess);
