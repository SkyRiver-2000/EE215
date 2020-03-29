function output = check_mark(mark)
%   输入参数含义：待检查的 mark 表格
%   当发现某一格子的所有数项的 mark 均为零，说明此路行不通，输出返回值零
    output = min(min(sum(mark, 3))); % 某一格 mark 全零，已无可选项，提示此路不通，这里不必分支判断，output若不为0必为1
end