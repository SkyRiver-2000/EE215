function next_gen = select(p, groups)
% 种群个体筛选（轮盘赌），保留每次产生的随机数落入累计概率区间对应的个体
    [num_ind, num_features] = size(groups);
    temp = rand(num_ind, 1);
    next_gen = zeros(num_ind, num_features);
    for k = 1 : num_ind
        for m = 1 : num_ind
            if temp(k) <= p(m)
                next_gen(k, :) = groups(m, :);
                break;
            end
        end
    end
end