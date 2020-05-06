function [w, Q, n, w0] = HP_Poles(amin, amax, wp, ws)

global reporting;

%% Butterworth Low Pass
Wp = 1;
Ws = wp / ws;

if(reporting)
    fprintf('\n>> Butterworth Low Pass\n');
    fprintf('Ωp = %f\n', Wp);
    fprintf('Ωs = %f\n', Ws);
end

%% Filter Class
n_float = (log((10^(amin/10)-1)/(10^(amax/10)-1))) / (2*log((Ws/Wp)));
n = ceil(n_float);

if(reporting)
    fprintf('\n>> Filter Class\n');
    fprintf('(no ceil)     n = %f\n', n_float);
    fprintf('(with ceil)   n = %i\n', n);
end

%% Parameters e & w0
e = 1 / (sqrt(10^(amax/10)-1));

%%% low pass frequency
W0 = Wp/((10^(amax/10)-1)^(1/(2*n)));

%%% high pass w0
w0 = wp/W0;

if(reporting)
    fprintf('\n>> Parameters e & a\n');
    fprintf('e = %f\n', e);
    fprintf('w0 = %f\n', w0);
end

%% Half Power Frequency
Whp = 1 / cosh((1/n) * (acosh(1/e)));

%%% FIXME: high pass whp (?)
% whp = wp / Whp;

if(reporting)
    fprintf('\n>> Half Power Frequency\n');
    fprintf('ωhp = %f\n',Whp);
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

%%% Low Pass Butterworth Poles
for k = 1:kappa
    sigma(k) = cos(deg2rad(y(k)));
    omega(k) = sin(deg2rad(y(k)));
    
    W(k) = sqrt(sigma(k)^2 + omega(k)^2);
    Q(k) = W(k)/(2*sigma(k));
end

if(reporting)
    fprintf('>>> Low Pass Butterworth\n');
    helpersReportingPoles(W, Q, sigma, omega);
end

%%% Convert p(k) to high pass
for k = 1:kappa
    sigma(k) = w0 * sigma(k);
    omega(k) = w0 * omega(k);
    
    w(k) = w0;
end

if(reporting)
    fprintf('\n>>> Convert to High Pass\n');
    helpersReportingPoles(w, Q, sigma, omega);
end

end