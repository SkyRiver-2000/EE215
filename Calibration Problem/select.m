function next_gen = select(p, groups)
% Select individuals of high fitness
% Improved by adding protection for the best individual
    [num_ind, num_features] = size(groups);
    temp = rand(num_ind, 1); % Stochastic number for roulette
    next_gen = false(num_ind, num_features);
    
    % Preserve the best individual of last generation and copy it
    next_gen(1, :) = groups(1, :);
    next_gen(2, :) = groups(1, :);
    
    % Select individuals according to the rand matrix
    for k = 3 : num_ind
        for m = 1 : num_ind
            if temp(k) <= p(m)
                next_gen(k, :) = groups(m, :);
                break;
            end
        end
    end
end
