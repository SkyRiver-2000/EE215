clear;

train_set = load('dataform_train.csv');
% train_set = train_set(1 : 20, :);
test_set = load('dataform_testA.csv');

max_iter = 500;
num_features = 90;
num_ind = 100;
mean_cost = zeros(num_ind, max_iter + 1);

tic;
init_groups;
for k = 2 : max_iter + 1
%     fprintf('Current Generation: %d\n', k);
    [f, I] = sort(f, 'descend');
    groups = groups(I, :);
    p = cumsum(f) / sum(f);
    groups = select(p, groups);
    % 交配，染色体交换
    for m = 1 : num_ind / 2
        [groups(2 * m - 1, :), groups(2 * m, :)] = match(groups(2 * m - 1, :), groups(2 * m, :), max(f(2 * m - 1), f(2 * m)), f);
    end
    % 变异，染色体置反
    groups = mutate(groups);
    groups = mutate_pro(groups);
    %     groups = mutate_pro(groups, f);
    % 计算适应度，选取最优个体并记录
    for i = 1 : num_ind
        [mean_cost(i, k), f(i)] = fitness(groups(i, :), train_set);
    end
    [best(k, 1), idx] = max(f);
    best_ind(k, :) = groups(idx, :);
    f = (f - min(f)) / (max(f) - min(f)) + c;
    c = ceta * c;
end

[~, idx] = max(best);

sample_points = find(best_ind(idx, :));

fprintf('The best sampling points are:');
for k = 1 : length(sample_points)
    fprintf(' %d', sample_points(k));
end

mid_cost = median(mean_cost, 1);
least_cost = min(mean_cost, [ ], 1);
T_error = compute_error(best_ind(idx, :), train_set);
mean_error = mean(T_error, 1);
var_error = var(T_error, [ ], 1);

fprintf('\nThe best solution is found in Generation %d.', idx);
fprintf('\nThe execution time is: %.1f s.\n', toc);
fprintf('The least average cost on training set is: %.2f.\n', min(least_cost));

temp = false(1, num_features);
temp(1, sample_points) = 1;
[real_cost, ~] = fitness(temp, test_set);
fprintf('The average cost on testing set is: %.2f.\n', real_cost);

hold on;
plot(1 : max_iter + 1, least_cost, 'LineWidth', 2);
% plot(1 : max_iter + 1, mid_cost, 'LineWidth', 2);
% legend('Least Cost', 'Median Cost', 'Location', 'northeast');
xlim([1 501]);
set(gca, 'Fontsize', 16);
xlabel('Round of Evolving', 'Fontsize', 20);
ylabel('Average Cost', 'Fontsize', 20);
title('Trend of Least Average Cost During Group Evolving', 'Fontsize', 28);
grid on; box on;
hold off;
