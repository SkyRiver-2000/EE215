function degree = fitness(groups, volume, weight, value)
% 计算种群中个体适应度，并惩罚越界个体
    lambda = 1e3; %惩罚系数
    v = groups * volume'; %占用空间
    w = groups * weight'; %占用重量
    val = groups * value'; %个体的总价值
    penal = lambda * (max(v - 95, 0) + max(w - 86, 0)); %惩罚项
    degree = max(val - penal, 10); %越界个体低概率保留，其余个体以价值作为适应度
end