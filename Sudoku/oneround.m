% fprintf('cell=%d\n', cell); 这个打印时间开销巨大
xcell = ceil(cell / Order); ycell = mod(cell - 1, Order) + 1;
goto_nextcell = 0;
cell_record(cell_record_ptr) = cell;
cell_record_ptr = cell_record_ptr + 1;
while((goto_nextcell == 0) && (ptrs(cell) <= Order))
    if cur_mark(xcell, ycell, ptrs(cell)) == 0
        ptrs(cell) = ptrs(cell) + 1;
    else
        next_mark = refresh_mark(cur_mark, xcell, ycell, ptrs(cell));
        if check_mark(next_mark) == 1
            diff_mark(:, :, :, cell) = next_mark - cur_mark;
            cur_mark = next_mark;
            cell = cell + 1;
            goto_nextcell = 1;
        else
            ptrs(cell) = ptrs(cell) + 1;
        end
    end
end
if goto_nextcell == 0
    ptrs(cell) = 1;
    cell = cell - 1;
    if cell ~= 0
        cur_mark = cur_mark - diff_mark(:, :, :, cell);
        %退到已预填数字的方格，则不重复搜索，继续后退
        while pre_fill(ceil(cell / Order), mod(cell - 1, Order) + 1) ~= 0
            cell = cell - 1;
            cur_mark = cur_mark - diff_mark(:, :, :, cell);
        end
    end
    ptrs(cell) = ptrs(cell) + 1;
end