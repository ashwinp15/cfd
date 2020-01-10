function [Sol, symSol] = Analytical(Beta)

	syms T(x);
	eqn = diff(T, x, 2)==(Beta^2)*T;
    dT = diff(T);
    cond1 = T(0)==1;
    cond2 = dT(1)==0;
	soln = dsolve(eqn, [cond1, cond2]);
	Sol = matlabFunction(soln);
	symSol = soln;
end