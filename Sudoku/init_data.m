clear;

%数独游戏阶数
Order = 9;

%mark表格，下标含义：行坐标，列坐标，数项
cur_mark = ones(Order, Order, Order);

%   记录每一步的 mark 表格变化
%%第 4 维下标代表第几格（从 1 到 Order*Order 对应从左到右，逐行向下）
diff_mark = zeros(Order, Order, Order, Order * Order);

%数项选择指针
%%下标表示第几格，数值代表下一轮将对应的数项
ptrs = ones(1, Order * Order);

%预先已填的数字
%%数值含义：行坐标，列坐标，数项
init_digit = [1 3 7; 1 5 2; 2 4 3; 2 7 4; 3 1 9; 3 5 1; 3 8 2; 4 2 1; 4 6 2; 5 1 7; 5 3 8; 5 7 3; 5 9 9
    6 4 4; 6 8 7; 7 2 5; 7 5 7; 7 9 8; 8 3 3; 8 6 6; 9 5 3; 9 7 1];
% init_digit = [1 3 7; 1 7 2; 2 5 3; 3 1 2; 3 4 6; 3 5 9; 3 6 5; 3 9 7; 4 3 5; 4 7 7; 5 2 9; 5 3 4; 5 5 8; 5 7 5; 5 8 2
%      6 3 8; 6 7 3; 7 1 4; 7 4 9; 7 5 1; 7 6 7; 7 9 6; 8 5 5; 9 3 3; 9 7 1];

%已填数字转化为矩阵，用于避免重复搜索（详见oneround.m）
pre_fill = zeros(Order, Order);
    
for i = 1 : size(init_digit, 1)
    cur_mark = refresh_mark(cur_mark, init_digit(i, 1), init_digit(i, 2), init_digit(i, 3));
    pre_fill(init_digit(i, 1), init_digit(i, 2)) = init_digit(i, 3);
end

%记录搜索过程 预开足够多个记录单元
cell_record = zeros(1, 120);
cell_record_ptr = 1;