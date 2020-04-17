tic;
times_sim = 5e6;
mu = 1000;
assembly_life = exprnd(mu, times_sim, 5);

route_1 = min(assembly_life(:, [1 2]), [ ], 2);
route_2 = min(assembly_life(:, [3 4]), [ ], 2);
route_3 = min(assembly_life(:, [1 4 5]), [ ], 2);
route_4 = min(assembly_life(:, [2 3 5]), [ ], 2);

mean_life = mean(max([route_1, route_2, route_3, route_4], [ ], 2));
fprintf('The execution time is: %.2f s\n', toc);
fprintf('The evaluated value of life is: %.1f\n', mean_life);