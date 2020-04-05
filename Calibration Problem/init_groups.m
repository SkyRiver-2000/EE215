% Matrices for best records
best = zeros(max_iter + 1, 1);
best_ind = false(max_iter + 1, num_features);

% Form a stochastic population
groups = rand(num_ind, num_features) >= 0.5;

% Initiate the dynamic adjust parameters of fitness
c = 0.1;
ceta = 0.995;
f = zeros(num_ind, 1);

% Fix those individuals with vital errors
for i = 1 : num_ind
    while sum(groups(i, :)) < 4
        groups(i, :) = rand(1, num_features) >= 0.5;
    end
    [mean_cost(i, 1), f(i)] = fitness(groups(i, :), train_set);
end

% Record the best individual and compute individual fitness
[best(1, 1), idx] = max(f);
best_ind(1, :) = groups(idx, :);
f = (f - min(f)) / (max(f) - min(f)) + c;
c = ceta * c;
