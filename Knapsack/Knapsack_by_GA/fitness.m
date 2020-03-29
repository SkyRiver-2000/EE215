function degree = fitness(groups, volume, weight, value)
% ������Ⱥ�и�����Ӧ�ȣ����ͷ�Խ�����
    lambda = 1e3; %�ͷ�ϵ��
    v = groups * volume'; %ռ�ÿռ�
    w = groups * weight'; %ռ������
    val = groups * value'; %������ܼ�ֵ
    penal = lambda * (max(v - 95, 0) + max(w - 86, 0)); %�ͷ���
    degree = max(val - penal, 10); %Խ�����͸��ʱ�������������Լ�ֵ��Ϊ��Ӧ��
end