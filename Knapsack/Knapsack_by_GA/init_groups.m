% ���ݳ�ʼ��
volume = [7 4 8 11 20 5 3 9 16 7 8 5 4 4 3 12];
weight = [11 7 9 6 7 8 5 6 18 2 3 6 2 9 5 4];
value = [9 8 7 8 18 7 3 10 19 4 4 11 3 5 4 6];

% ��Ⱥ�и�����Ŀ
num_ind = 50;

% ��Ⱥ�����ʼ��
groups = rand(num_ind, num_features);

groups(groups >= 0.5) = 1;
groups(groups < 0.5) = 0;

% �������������Ӧ��
f = fitness(groups, volume, weight, value);
[best(1, 1), idx] = max(f);
best_ind(1, :) = groups(idx, :);
f = (f - min(f)) / (max(f) - min(f)) + 0.02;