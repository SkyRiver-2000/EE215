clear;
% Load the provided Datasets
train_set = load('dataform_train.csv');
test_set = load('dataform_testA.csv');

% Define max rounds of iteration and the number of individuals
max_iter = 500;
num_features = 90;
num_ind = 100;
mean_cost = zeros(num_ind, max_iter + 1);
 
tic;
init_groups; % Implement group initiation
for k = 2 : max_iter + 1
	% Resort the group
    [f, I] = sort(f, 'descend');
    groups = groups(I, :);
    p = cumsum(f) / sum(f);
    groups = select(p, groups);
    % Implement cross between pairs
    for m = 1 : num_ind / 2
        [groups(2 * m - 1, :), groups(2 * m, :)] = match(groups(2 * m - 1, :), groups(2 * m, :), max(f(2 * m - 1), f(2 * m)), f);
    end
    % Implement single mutation
groups = mutate(groups);
% Implement point transverse shifting
    groups = mutate_pro(groups);
    % Compute the fitness and cost
    for i = 1 : num_ind
        [mean_cost(i, k), f(i)] = fitness(groups(i, :), train_set);
End
% Record the best individual in current generation
    [best(k, 1), idx] = max(f);
best_ind(k, :) = groups(idx, :);
% Dynamically adjust the fitness of individuals
    f = (f - min(f)) / (max(f) - min(f)) + c; 
    c = ceta * c;
end
% Find the historically best individual and get the best solution
[~, idx] = max(best);
sample_points = find(best_ind(idx, :));
 
fprintf('The best sampling points are:');
for k = 1 : length(sample_points)
    fprintf(' %d', sample_points(k));
end

% Preparation for data analysis
main_cost = mode(mean_cost, 1);
least_cost = min(mean_cost, [ ], 1);
T_error = compute_error(best_ind(idx, :), train_set);
mean_error = mean(T_error, 1);
var_error = var(T_error, [ ], 1);

% Print some related information
fprintf('\nThe best solution is found in Generation %d.', idx);
fprintf('\nThe execution time is: %.1f s.\n', toc);
fprintf('The least average cost on training set is: %.2f\n', min(least_cost));

% Examine the best solution on the test set
temp = false(1, num_features);
temp(1, sample_points) = 1;
[real_cost, ~] = fitness(temp, test_set);
fprintf('The average cost on testing set is: %.2f\n', real_cost);

% Plot the evolving picture
hold on;
plot(1 : max_iter + 1, least_cost, 'LineWidth', 2);
plot(1 : max_iter + 1, main_cost, 'LineWidth', 2);
legend('Least Cost', 'Mode Cost', 'Location', 'northeast');
xlim([1, max_iter + 1]);
set(gca, 'Fontsize', 16);
xlabel('Round of Evolving', 'Fontsize', 20);
ylabel('Average Cost', 'Fontsize', 20);
title('Trend of Least Average Cost During Group Evolving', 'Fontsize', 28);
grid on; box on;
hold off;

% Conduct error analysis
figure();
error_analysis;
