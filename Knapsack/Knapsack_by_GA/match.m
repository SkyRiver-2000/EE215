function [new_1, new_2] = match(ind_1, ind_2, fm, f)
% 个体交配，染色体定概率交换
    f_avg = mean(f);
    f_max = max(f);
    if fm < f_avg
        p_match = 1;
    else
        p_match = (f_max - fm) / (f_max - f_avg);
    end
    if rand() <= p_match
        temp = rand(2, 1);
        num_features = size(ind_1, 2);
        front = ceil(min(temp) * num_features);
        back = ceil(max(temp) * num_features);
        new_1 = ind_1;
        new_2 = ind_2;
        new_1(1, front : back) = ind_2(1, front : back);
        new_2(1, front : back) = ind_1(1, front : back);
    else
        new_1 = ind_1;
        new_2 = ind_2;
    end
end