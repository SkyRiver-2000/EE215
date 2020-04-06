function cost = single_cost(T1, T2)
    if abs(T1 - T2) <= 0.5
        cost = 0;
    elseif abs(T1 - T2) <= 1
        cost = 1;
    elseif abs(T1 - T2) <= 1.5
        cost = 5;
    elseif abs(T1 - T2) <= 2
        cost = 10;
    else
        cost = 10000;
    end
end
