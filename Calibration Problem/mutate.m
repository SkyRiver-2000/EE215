function new_groups = mutate(groups)
% Stochastic mutation on single points
    p_mut = 0.005; % The probability of mutation
new_groups = groups;

% Determine if the mutation happens and implement mutation
if_mut = rand(size(groups)) <= p_mut;
new_groups(if_mut) = 1 - new_groups(if_mut);

% 3-order polynomial interpolation needs at least 4 points
% Re-mutate those individuals with vital errors
    for m = 1 : size(groups, 1)
        while sum(new_groups(m, :)) < 4
            new_groups(m, :) = groups(m, :);
            temp = rand(1, size(groups, 2)) <= p_mut;
            new_groups(m, temp) = 1 - new_groups(m, temp);
        end
    end
end
