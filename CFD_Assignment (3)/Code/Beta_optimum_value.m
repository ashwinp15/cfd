Beta_arr = [0.25, 0.5, 1.0, 2.0, 3.0, 5.0, 10, 50, 100, 150, 200, 250];
Biot = 1.0;

for i = 1:length(Beta_arr)
Beta = Beta_arr(i);
N=120;
delta = 1/(N-1);
y = [1;zeros(N-1,1)];
b = (1/delta^2)*ones(N-2, 1);
a = [0;b];
d = [1; -1*(2/(delta)^2 + Beta^2)*ones(N-2, 1)];

Asol_numerical = Numerical_A(a, b, d, y, N);
Bsol_numerical = Numerical_B(a, b, d, y, Biot, N);
AB_percent_err = abs(Asol_numerical(N) - Bsol_numerical(N))*100/Asol_numerical(N);
fprintf("Percent error in A and B for Beta = %f\n", Beta);
disp(AB_percent_err);
end