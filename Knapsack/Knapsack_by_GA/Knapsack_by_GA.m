% 超参数及最优个体记录初始化
max_iter = 200;
num_features = 16;
best = zeros(max_iter, 1);
best_ind = zeros(max_iter, num_features);

% 种群初始化，计时
tic;
init_groups;

for k = 1 : max_iter
    p = cumsum(f) / sum(f);
    groups = select(p, num_ind, groups);
    % 交配，染色体交换
    for m = 1 : num_ind / 2
        [groups(2 * m - 1, :), groups(2 * m, :)] = match(groups(2 * m - 1, :), groups(2 * m, :));
    end
    % 变异，染色体置反
    groups = mutate(num_ind, num_features, groups);
    % 计算适应度，选取最优个体并记录
    f = fitness(groups, volume, weight, value);
    best(k, 1) = max(f);
    idx = find(f == best(k, 1));
    best_ind(k, :) = groups(idx(1), :);
end

% 找到历史最优个体，输出信息
idx = find(best == max(best));
fprintf('The highest value is: %d.\n', max(best));
fprintf('The best individual is:\n');
for k = 1 : num_features
    fprintf('%d ', best_ind(idx(1), k));
end
fprintf('\n%d units of volume is used.\n', best_ind(idx(1), :) * volume');
fprintf('%d units of weight is used.\n', best_ind(idx(1), :) * weight');
fprintf('The execution time is: %4.3f s.\n', toc);
