Beta = 1.0;
N = 120;
delta = 1/(N-1);
y = [1;zeros(N-1,1)];
b = (1/delta^2)*ones(N-2, 1);
a = [0;b];
d = [1; -1*(2/(delta)^2 + Beta^2)*ones(N-2, 1)];

Biot_arr = [0.1, 0.5, 1.0];
Asol_numerical = Numerical_A(a, b, d, y, N);

disp("First 3 Plots for different Biot values and Beta = 1.0")
for i = 1:3	
	Biot = Biot_arr(i);
	Bsol_numerical = Numerical_B(a, b, d, y, Biot, N);
	figure;
	xlabel = "x";
	ylabel = "theta";
	plot(linspace(0, 1, N), Asol_numerical);
	hold on;
	plot(linspace(0, 1, N), Bsol_numerical);
	legend('Solution A', 'Solution B');
	str = "Biot = " + string(Biot);
	title(str);
	hold off;
end

Biot = 1.0;
Beta_arr = [0.25, 1.0, 2.0];

disp("Last 3 Plots for different Beta values and Biot = 1.0")
for j = 1:3
	Beta = Beta_arr(j);
	d = [1; -1*(2/(delta)^2 + Beta^2)*ones(N-2, 1)];
	Asol_numerical = Numerical_A(a, b, d, y, N);
	Bsol_numerical = Numerical_B(a, b, d, y, Biot, N);
	figure;
	xlabel = "x";
	ylabel = "theta";
	plot(linspace(0, 1, N), Asol_numerical);
	hold on;
	plot(linspace(0, 1, N), Bsol_numerical);
	legend('Solution A', 'Solution B');
	str = "Beta = " + string(Beta);
	title(str);
	hold off;
end