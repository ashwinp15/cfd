list = num2cell([0.1, 1, 1, 5, 5, 0, 1]);
[delta_x, Alpha, k, h0, hf, T0, Tf] = deal(list{:});
delta_t = 0.001;
t_lim_arr = [0.1,0.5,1.0];
N = 1/delta_x + 1;
Gamma = Alpha*delta_t/(delta_x^2);

%===============BTCS Scheme===============%

a = [-k/delta_x; -Gamma*ones(N-2, 1)];
b = [-Gamma*ones(N-2, 1); -k/delta_x];
d = [k/delta_x + h0; (2*Gamma+1)*ones(N-2, 1); k/delta_x + hf];
r = [h0*T0; zeros(N-2, 1); hf*Tf];

t=delta_t;
BTCS_Soln = zeros(N, 1);
figure;
for i = 1:length(t_lim_arr)
	t_lim = t_lim_arr(i);
	while(t<=t_lim)
		BTCS_Soln = tridiag(a,b,d,r,N);
		r = [h0*T0; BTCS_Soln(2:N-1); hf*Tf];
		t = t+delta_t;
	end
	plot(linspace(0,1,N), BTCS_Soln)
	hold on;
end
legend("t max = 0.1", "t max = 0.5", "t max = 1.0");
title("BTCS for \deltat = 0.001")
xlabel = "x 0 to 1";
ylabel = "Temperature";

%===============FTCS Scheme=================%

t = delta_t;
T_init = zeros(N, 1);
FTCS_Soln = zeros(N, 1);
figure;
for j = 1:length(t_lim_arr)
	t_lim = t_lim_arr(j);
	while(t<=t_lim)
		for i = 2:N-1
			FTCS_Soln(i) = (1-2*Gamma)*T_init(i) + Gamma*T_init(i-1) + Gamma*T_init(i+1);
		end
		FTCS_Soln(1) = (FTCS_Soln(2)*k/delta_x + h0*T0)/(h0 + k/delta_x);
		FTCS_Soln(N) = (FTCS_Soln(N-1)*k/delta_x + hf*Tf)/(hf + k/delta_x);
	
		T_init = FTCS_Soln;
		t = t+delta_t;
	end
	plot(linspace(0,1,N), FTCS_Soln)
	hold on;
end
legend("t max = 0.1", "t max = 0.5", "t max = 1.0");
title("FTCS for \deltat = 0.001")
xlabel = "x (0 to 1)";
ylabel = "Temperature";
