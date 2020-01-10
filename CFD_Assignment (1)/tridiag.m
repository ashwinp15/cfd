function [Soln] = tridiag(a, b, d, r, N)

Soln = zeros(N,1);
for i = 1:N-1
		d(i+1) = d(i+1) - b(i)*a(i)/d(i);
		r(i+1) = r(i+1) - b(i)*r(i)/d(i);
	end

	Soln(N) = r(N)/d(N);
	
	for j = 1:N-1
		Soln(N-j) = (r(N-j) - a(N-j)*Soln(N-j+1))/d(N-j);
	end

end 