Beta = 0.5;

[Asol_analytical, symSol] = Analytical(Beta);
disp("Analytical solution");
disp(symSol);

N=0;
N_arr = [];
err_arr=[];
percent_err = 10;
while(percent_err>0.1)
	N=N+10;
	N_arr = [N_arr;N];
	delta = 1/(N-1);
	y = [1;zeros(N-1,1)];
	b = (1/delta^2)*ones(N-2, 1);
	a = [0;b];
	d = [1; -1*(2/(delta)^2 + Beta^2)*ones(N-2, 1)];
	Asol_numerical = Numerical_A(a, b, d, y, N);
	Bsol_numerical = Numerical_B(a, b, d, y, Biot, N);
	err = abs(Asol_numerical(N) - Asol_analytical(1));
	err_arr = [err_arr; err];
	percent_err = err*100/Asol_analytical(1);
end

fprintf("Percentage error in analytical and numerical solution for N = %d", N)
disp(percent_err);
ln_N = log(1./(N_arr-1));
ln_err = log(err_arr);
plot(ln_N, ln_err);
xlabel = "log delta(x)";
ylabel = "log Error";

%slope by taking any 2 points
p = (ln_err(8) - ln_err(2))/(ln_N(8) - ln_N(2));
fprintf("Order of accuracy is %f", p);
