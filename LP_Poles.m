function [w, Q, n, whp] = LP_Poles(amin, amax, wp, ws)

global reporting;

%% Chebyshev Low Pass
Wp = 1;
Ws = ws / wp;

if(reporting)
    fprintf('\n>> Chebyshev Low Pass\n');
    fprintf('Ωp = %f\n', Wp);
    fprintf('Ωs = %f\n', Ws);
end

%% Filter Class
n_float = acosh(sqrt(((10^(amin/10) - 1)) / (10^(amax/10) - 1))) / acosh(Ws);
n = ceil(n_float);

if(reporting)
    fprintf('\n>> Filter Class\n');
    fprintf('(no ceil)     n = %f\n', n_float);
    fprintf('(with ceil)   n = %i\n', n);
end

%% Parameters e & a
e = sqrt(10^(amax/10)-1);
a = (1/n) * (asinh(1/e));

if(reporting)
    fprintf('\n>> Parameters e & a\n');
    fprintf('e = %f\n', e);
    fprintf('a = %f\n', a);
end

%% Half Power Frequency
whp = cosh((1/n) * (acosh(1/e)));

if(reporting)
    fprintf('\n>> Half Power Frequency\n');
    fprintf('ωhp = %f\n',whp);
end

%% Butterworth Angles
for k = 1:n
    y(k) = rad2deg((pi/2) - ((2*k-1)*pi/(2*n)));
end

%%% keep only the unique values
y = unique(abs(y));
    
%%% kappa constant
kappa = length(y);

if(reporting)
    fprintf('\n>> Butterworth Angles for n = %i\n', n);
    for k = 1:length(y)
        fprintf('ψ%i = %i\n',k,y(k));
    end
end

%% Poles
reporting && fprintf('\n>> Poles\n');

%%% Chebyshev Poles
for k = 1:kappa
    sigma(k) = sinh(a)*cos(deg2rad(y(k)));
    omega(k) = cosh(a)*sin(deg2rad(y(k)));
    
    W(k) = sqrt(sigma(k)^2 + omega(k)^2);
    Q(k) = W(k)/(2*sigma(k));
end

if(reporting)
    fprintf('>>> Chebyshev Poles\n');
    helpersReportingPoles(W, Q, sigma, omega);
end

%%% Frequency Scaling
for k = 1:kappa
    w(k) = wp * W(k);
end

if(reporting)
    fprintf('\n>>> Frequency Scaling\n');
    helpersReportingPoles(w, Q);
end

end

