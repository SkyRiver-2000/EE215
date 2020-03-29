volume = [7 4 8 11 20 5 3 9 16 7 8 5 4 4 3 12];
weight = [11 7 9 6 7 8 5 6 18 2 3 6 2 9 5 4];
value = [9 8 7 8 18 7 3 10 19 4 4 11 3 5 4 6];

f = -value;
ic = 1 : 16;
A = [volume; weight];
b = [95; 86];
lb = zeros(16, 1);
ub = ones(16, 1);

[x, fval, flag] = intlinprog(f, ic, A, b, [], [], lb, ub);