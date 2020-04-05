function new_groups = mutate_pro(groups)
% Stochastically shift some calibration points
    p_mut = 0.05; % The probability of shifting
    new_groups = groups;

    % Determine if shifting happens on an individual
    if_mut = rand(size(groups, 1), 1) <= p_mut;

    for m = 1 : size(groups, 1)
        if if_mut(m)
            idx = find(groups(m, :));
            % Get the shifting point
            [~, mut_pos] = max(rand(size(idx)));
            temp = idx;
            temp(mut_pos) = idx(mut_pos) + ceil(6 * rand() - 3.5);
			% If the shift is illegal, try again
            while temp(mut_pos) < 1 || temp(mut_pos) > 90
                temp(mut_pos) = idx(mut_pos) + ceil(6*rand() - 3.5);
            end
            idx = temp;
            new_groups(m, :) = false;
            new_groups(m, idx) = true;
        end
    end
end
