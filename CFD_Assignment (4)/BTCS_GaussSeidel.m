delta = 0.01;		% delta = delta_x = delta_y
delta_t = 0.005;
t = delta_t;
t_max = 20;
n_plot = t_max/delta_t;
epsilon = 1e-6;
Gamma = delta_t/delta^2;
N = 1 + 1/delta;	
N_red = N-floor(N/2);	
Biot_vals = [0,0.1,0.5,1.0,2.0];
Biot = 0;
figure;

for iter = 1:5
	Biot = Biot_vals(iter);
	Soln = [];
	t = delta_t;
	theta_init = ones(N_red);
	theta = theta_init;
	while(t<t_max)
		flag=1;
		while(flag)
			rms = 0;
			for i = 2:N_red-1
				for j = 2:N_red-1
					residual = theta_init(i,j) - (Gamma*(4*theta(i,j) - theta(i,j-1) - theta(i,j+1) - theta(i-1,j) - theta(i+1,j)) + theta(i,j));
					rms = rms+residual^2;
					theta(i,j) = theta(i,j) + residual/(1+4*Gamma);
				end
			end
			
			for j = 1:N_red
				res1 = -1*((theta(N_red,j)-theta(N_red-1,j))/delta + Biot*theta(N_red,j));
				theta(N_red,j) = theta(N_red,j) + res1/(Biot+1/delta);
				res2 = -1*((theta(2,j)-theta(1,j))/delta);
				theta(1,j) = theta(1,j) - res2/(1/delta);
				rms = rms+res1^2+res2^2;
			end
			
			for i = 1:N_red
				res1 = -1*((theta(i,N_red)-theta(i,N_red-1))/delta + Biot*theta(i,N_red));
				theta(i,N_red) = theta(i,N_red) + res1/(Biot+1/delta);
				res2 = -1*((theta(i,2)-theta(i,1))/delta);
				theta(i,1) = theta(i,1) - res2/(1/delta);
				rms = rms+res1^2+res2^2;
			end
			
			rms = (rms^0.5)/N_red;
			%disp(rms);
			if(rms<epsilon)
				flag=0;
				%disp("ho gaya");
				break;
			end
		end
		theta_init = theta;
		t = t+delta_t;
		Soln = [Soln,theta(1,1)];
	end
	plot(linspace(0,1,n_plot-1), Soln);
	hold all;
end

legend('Biot 0', 'Biot 0.1', 'Biot 0.5', 'Biot 1.0', 'Biot 2.0');
xlabel = "Non-dim Time";
ylabel = "Non-dim Temperature";



