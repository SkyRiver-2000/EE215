clear;

%������Ϸ����
Order = 9;

%mark����±꺬�壺�����꣬�����꣬����
cur_mark = ones(Order, Order, Order);

%   ��¼ÿһ���� mark ���仯
%%�� 4 ά�±����ڼ��񣨴� 1 �� Order*Order ��Ӧ�����ң��������£�
diff_mark = zeros(Order, Order, Order, Order * Order);

%����ѡ��ָ��
%%�±��ʾ�ڼ�����ֵ������һ�ֽ���Ӧ������
ptrs = ones(1, Order * Order);

%Ԥ�����������
%%��ֵ���壺�����꣬�����꣬����
init_digit = [1 3 7; 1 5 2; 2 4 3; 2 7 4; 3 1 9; 3 5 1; 3 8 2; 4 2 1; 4 6 2; 5 1 7; 5 3 8; 5 7 3; 5 9 9
    6 4 4; 6 8 7; 7 2 5; 7 5 7; 7 9 8; 8 3 3; 8 6 6; 9 5 3; 9 7 1];
% init_digit = [1 3 7; 1 7 2; 2 5 3; 3 1 2; 3 4 6; 3 5 9; 3 6 5; 3 9 7; 4 3 5; 4 7 7; 5 2 9; 5 3 4; 5 5 8; 5 7 5; 5 8 2
%      6 3 8; 6 7 3; 7 1 4; 7 4 9; 7 5 1; 7 6 7; 7 9 6; 8 5 5; 9 3 3; 9 7 1];

%��������ת��Ϊ�������ڱ����ظ����������oneround.m��
pre_fill = zeros(Order, Order);
    
for i = 1 : size(init_digit, 1)
    cur_mark = refresh_mark(cur_mark, init_digit(i, 1), init_digit(i, 2), init_digit(i, 3));
    pre_fill(init_digit(i, 1), init_digit(i, 2)) = init_digit(i, 3);
end

%��¼�������� Ԥ���㹻�����¼��Ԫ
cell_record = zeros(1, 120);
cell_record_ptr = 1;