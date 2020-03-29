function next_gen = select(p, groups)
% ��Ⱥ����ɸѡ�����̶ģ�������ÿ�β���������������ۼƸ��������Ӧ�ĸ���
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