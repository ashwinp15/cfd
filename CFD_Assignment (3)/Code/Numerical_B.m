function Sol = Numerical_B(a, b, d, y, Biot, N)

	d = [d; N-1+Biot];
	b = [b; 1-N];

	for i = 1:N-1
		d(i+1) = d(i+1) - b(i)*a(i)/d(i);
		y(i+1) = y(i+1) - b(i)*y(i)/d(i);
	end
	
	Sol = zeros(N,1);
	
	Sol(N) = y(N)/d(N);
	
	for j = 1:N-1
		Sol(N-j) = (y(N-j) - a(N-j)*Sol(N-j+1))/d(N-j);
	end
end

