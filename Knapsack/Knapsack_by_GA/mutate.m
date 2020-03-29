function new_groups = mutate(num_ind, num_features, groups)
% Ⱦɫ�嶨���ʵ������
    p_mut = 0.05; %�������
    new_groups = zeros(size(groups));
    for m = 1 : num_ind
        % ���������(1-p_mut)����������
        temp = rand(1, num_features);
        temp(temp >= 1 - p_mut) = 1;
        temp(temp < 1 - p_mut) = 0;
        new_groups(m, temp == 0) = groups(m, temp == 0);
        new_groups(m, temp == 1) = 1 - groups(m, temp == 1);
    end
end