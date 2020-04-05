function error = compute_error(ind, dataset)
    num_samples = size(dataset, 1) / 2;
    T_inter = zeros(num_samples, size(dataset, 2));
    T_all = dataset(1, :);
    V_all = dataset(2 : 2 : num_samples * 2, :);
    V_taken = V_all(:, ind);
    T_taken = T_all(:, ind);
    for i = 1 : size(V_all, 1)
        T_inter(i, :) = interp1(V_taken(i, :), T_taken, V_all(i, :), 'spline');
    end
    error = T_inter - T_all;
end
