function next_mark = refresh_mark(cur_mark, x, y, ptr)
%   MARKING 输入参数含义：组的定义，cur_mark，行坐标，列坐标，数项
%   当行、列坐标指定的格子内填写数项 ptr 后，对 mark 表格进行更新
    Order = size(cur_mark, 1);
    next_mark = cur_mark;
    next_mark(x, y, :) = 0; %同一格的各项 mark 清零
    next_mark(x, :, ptr) = 0; %同一列的同项 mark 清零
    next_mark(:, y, ptr) = 0; %同一行的同项 mark 清零
    %同一组的同项 mark 清零
    row = ceil(x / 3);
    line = ceil(y / 3);
    next_mark(row * 3 - 2 : row * 3, line * 3 - 2 : line * 3, ptr) = 0;
    next_mark(x, y, ptr) = 1;
    %唯一数，剪枝
    for row = 1 : Order
        for line = 1 : Order
            idx = find(next_mark(row, line, :) == 1);
            if length(idx) == 1
                next_mark(row, :, idx) = 0;
                next_mark(:, line, idx) = 0;
                %在该简单问题中，该段代码起不到剪枝作用
%                 tempr = ceil(row / 3);
%                 templ = ceil(line / 3);
%                 next_mark(tempr * 3 - 2 : tempr, templ * 3 - 2 : templ, idx) = 0;
                next_mark(row, line, idx) = 1;
            end
        end
    end
    %隐含唯一数，剪枝
    for g = 1 : Order
        for i = 1 : Order
            idx = find(next_mark(i, :, g) == 1);
            if length(idx) == 1
                next_mark(:, idx, g) = 0;
                line = ceil(idx / 3);
                row = ceil(i / 3);
                next_mark(row * 3 - 2 : row * 3, line * 3 - 2 : line * 3, g) = 0;
                next_mark(i, idx, g) = 1;
            end
            idx = find(next_mark(:, i, g) == 1);
            if length(idx) == 1
                next_mark(idx, :, g) = 0;
                row = ceil(idx / 3);
                line = ceil(i / 3);
                next_mark(row * 3 - 2 : row * 3, line * 3 - 2 : line * 3, g) = 0;
                next_mark(idx, i, g) = 1;
            end
        end
        for i = 1 : 3
            for j = 1 : 3
                idx = find(next_mark(i * 3 - 2: i * 3, j * 3 - 2 : j * 3, g) == 1);
                if length(idx) == 1
                    row = mod(idx + 2, 3) + 1;
                    next_mark(i * 3 - 3 + row, :, g) = 0;
                    next_mark(:, j * 3 - 3 + ceil(idx / 3), g) = 0;
                    next_mark(i * 3 - 3 + row, j * 3 - 3 + ceil(idx / 3), g) = 1;
                end
            end
        end
    end
    %数对法，剪枝
    for row = 1 : Order
        for line = 1 : Order
            idx = find(next_mark(row, line, :) == 1);
            if length(idx) == 2
                for k = (line + 1) : Order
                    if next_mark(row, k, :) == next_mark(row, line, :)
                        next_mark(row, :, idx) = 0;
                        next_mark(row, [line k], idx) = 1;
                        break;
                    end
                end
                for k = (row + 1) : Order
                    if next_mark(k, line, :) == next_mark(row, line, :)
                        next_mark(:, line, idx) = 0;
                        next_mark([row k], line, idx) = 1;
                        break;
                    end
                end
                templ = ceil(line / 3);
                tempr = ceil(row / 3);
                for k = (tempr * 3 - 2) : tempr * 3
                    for g = (templ * 3 - 2) : templ * 3
                        if next_mark(k, g, :) == next_mark(row, line, :)
                            if k == row && g == line
                                continue;
                            end
                            next_mark([tempr * 3 - 2 tempr * 3 - 1 tempr * 3], [templ * 3 - 2 templ * 3 - 1 templ * 3], idx) = 0;
                            next_mark(k, g, idx) = 1;
                            next_mark(row, line, idx) = 1;
                            break;
                        end
                    end
                end
            end
        end
    end
    % 隐含数对法剪枝，仅减少3次迭代，但时间增加0.1s，放弃
%     for g = 1 : Order
%         for row = 1 : Order
%             idx = find(next_mark(row, :, g) == 1);
%             if length(idx) == 2
%                 for k = (g + 1) : Order
%                     if next_mark(row, :, k) == next_mark(row, :, g)
%                         next_mark(row, idx, :) = 0;
%                         next_mark(row, idx, [g k]) = 1;
%                         break;
%                     end
%                 end
%             end
%         end
%         for line = 1 : Order
%             idx = find(next_mark(:, line, g) == 1);
%             if length(idx) == 2
%                 for k = (g + 1) : Order
%                     if next_mark(:, line, k) == next_mark(:, line, g)
%                         next_mark(idx, line, :) = 0;
%                         next_mark(idx, line, [g k]) = 1;
%                         break;
%                     end
%                 end
%             end
%         end
%     end
end