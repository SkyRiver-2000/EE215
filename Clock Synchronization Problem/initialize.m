mu_A = 2.72e4;
mu_B = 3.32e5;
n_samples = 1e5;
n_max = 20;
Life = zeros(1, n_samples);
max_life = 9e4;
mean_life = zeros(1, 20);
reliability = zeros(1, 20);
combo = [0, 3, 1; 1, 5, 1; 2, 3, 4; 4, 4, 4];
FB_proportion = zeros(1, 20);