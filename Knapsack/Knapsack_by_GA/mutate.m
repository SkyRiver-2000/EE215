function new_groups = mutate(num_ind, num_features, groups)
% 染色体定概率单点变异
    p_mut = 0.05; %变异概率
    new_groups = zeros(size(groups));
    for m = 1 : num_ind
        % 随机数超过(1-p_mut)即发生变异
        temp = rand(1, num_features);
        temp(temp >= 1 - p_mut) = 1;
        temp(temp < 1 - p_mut) = 0;
        new_groups(m, temp == 0) = groups(m, temp == 0);
        new_groups(m, temp == 1) = 1 - groups(m, temp == 1);
    end
end