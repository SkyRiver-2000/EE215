function [mean_cost, f] = fitness(ind, dataset)
%   Conduct calibration with the solution related to the individual
%   Use the reciprocal of squared total cost as the fitness
    num_points = sum(ind); % The number of sampling points
    num_samples = size(dataset, 1) / 2; % The number of samples
    cost = zeros(num_samples, 1);
T_inter = zeros(num_samples, size(dataset, 2));

% Real statistics
    T_all = dataset(1, :);
V_all = dataset(2 : 2 : num_samples * 2, :);

% Take out the sampling points of the individual
    V_taken = V_all(:, ind);
    T_taken = T_all(:, ind);
for i = 1 : size(V_all, 1)
	% Implement interpolation, the last parameter can be replaced by others to test different methods
        T_inter(i, :) = interp1(V_taken(i, :), T_taken, V_all(i, :), 'spline');
		% Compute the cost for a single sample
        cost(i) = total_cost(T_inter(i, :), T_all, num_points);
end
% Compute the average cost and fitness of the individual
    mean_cost = mean(cost);
    f = 1 / mean_cost^2;
end
