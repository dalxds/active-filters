function helpersReportingPoles(W, Q, sigma, omega)

p = true;

if ~exist('sigma','var') || isempty(sigma) || ~exist('omega','var') || isempty(omega)
  p = false;
end

if(p)
    fprintf('k    |Ω0k          |Qk           |σk ± jωk (pk)          |\n');
    fprintf('-----|-------------|-------------|-----------------------|\n');
else
    fprintf('k    |Ω0k          |Qk           |\n');
    fprintf('-----|-------------|-------------|\n');
end

for k = 1:length(W)
    if (p)
        fprintf('%i    |%f     |%f     |%f ± j%f   |\n', k, W(k), Q(k), sigma(k), omega(k));
    else
        fprintf('%i    |%f     |%f     |\n', k, W(k), Q(k));
    end
end

end

