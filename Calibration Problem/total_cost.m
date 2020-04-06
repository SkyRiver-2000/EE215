function cost = total_cost(T_inter, T_real, num_points)
    cost = 0;
    for i = 1 : size(T_real, 2)
        cost = cost + single_cost(T_inter(i), T_real(i));
    end
    cost = cost + 50 * num_points;
end
