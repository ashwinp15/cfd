delta_t = 0.2e-4;
t = delta_t;
delta = 0.01;
N = 1/delta + 1;
Biot_vals = [0.1, 0.5, 1.0, 2.0];
FTCS_Soln = zeros(N);
N_red = floor(N/2)+1;
rx = delta_t/delta^2;
ry = rx;
t_lim = 20;
n_plots = floor(t_lim/delta_t);
Soln = zeros(n_plots, 1);
Biot = 2.0;
iter = 1;
T_init = ones(N);

while(t<=t_lim)
	for i = N_red+1:N-1
		for j = N_red+1:N-1
			FTCS_Soln(i,j) = T_init(i,j) + rx*(T_init(i+1,j) - 2*T_init(i,j) + T_init(i-1,j)) + ry*(T_init(i, j+1) - 2*T_init(i,j) + T_init(i-1,j-1));
		end
	end
	for j = N_red:N
		FTCS_Soln(N, j) = FTCS_Soln(N-1, j)/(1 + Biot*delta);
		FTCS_Soln(N_red, j) = FTCS_Soln(N_red+1, j);
	end
	for i = N_red:N
		FTCS_Soln(i, N) = FTCS_Soln(i, N-1)/(1 + Biot*delta);
		FTCS_Soln(i, N_red) = FTCS_Soln(i, N_red+1);
	end
	Soln(iter) = FTCS_Soln(N_red, N_red);
	iter = iter+1;
	T_init = FTCS_Soln;
	t = t+delta_t;
end

figure;
plot(linspace(0,1,n_plots+1), Soln)
hold on;
title("Biot = 2.0")
xlabel = "Time";
ylabel = "Temperature";