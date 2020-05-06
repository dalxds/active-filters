function [w, Q, wz, n] = BE_PolesAndZeros(amin, amax, w0, w1, w2, w3, w4)

global reporting;

%% Inverse Chebyshev Low Pass
Wp = 1;
Ws = (w2 - w1) / (w4 - w3);
bw = w2 - w1;
Wp = Wp / Ws;

if(reporting)
    fprintf('\n>> Chebyshev Low Pass\n');
    fprintf('Ωp = 1\n');
    fprintf('Ωs = %f\n', Ws);
    fprintf('bw = %f\n', bw);
    
    fprintf('\n>> Inverse Chebyshev Low Pass\n');
    fprintf('Ωp = %f\n', Wp);
    fprintf('Ωs = 1\n');
end

%% Filter Class
n_float = acosh(sqrt(((10^(amin/10) - 1))/ (10^(amax/10) - 1))) / acosh(1/Wp);
n = ceil(n_float);

if(reporting)
    fprintf('\n>> Filter Class\n');
    fprintf('(no ceil)     n = %f\n', n_float);
    fprintf('(with ceil)   n = %i\n', n);
end

%% Parameters e & a
e = 1 / (sqrt(10^(amin/10)-1));
a = (1/n) * (asinh(1/e));

if(reporting)
    fprintf('\n>> Parameters e & a\n');
    fprintf('e = %f\n', e);
    fprintf('a = %f\n', a);
end

%% Half Power Frequency
Whp = 1 / cosh((1/n) * (acosh(1/e)));

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

%%% Inverse Chebyshev Poles
for k = 1:kappa
    W(k) = 1/W(k);
end

if(reporting)
    fprintf('\n>>> Inverse Chebyshev Poles\n')
    helpersReportingPoles(W, Q);
end

%%% Frequency Scaling
for k = 1:kappa
    W(k) = Ws * W(k);
end

if(reporting)
    fprintf('\n>>> Frequency Scaling\n');
    helpersReportingPoles(W, Q);
end

%%% Convert to High Pass
for k = 1:kappa
    W(k) = 1/W(k);
end

if(reporting)
    fprintf('\n>>> Convert to High Pass - Revert ICH Poles\n');
    helpersReportingPoles(W, Q);
end

%%% Calculate new p(k)
for k = 1:kappa
    sigma(k) = W(k)/(2*Q(k));
    omega(k) = sqrt(W(k)^2 - sigma(k)^2);
end

if(reporting)
    fprintf('\n>>> Convert to High Pass - New p(k)\n');
    helpersReportingPoles(W, Q, sigma, omega);
end

%% Zeros
reporting && fprintf('\n>> Zeros\n');

%%% Chebyshev Zeros
index = 1;
for k = 1:2:n
    Wz(index) = sec(k*pi/(2*n));
    index = index + 1;
end

if(reporting)
    fprintf('>>> Inverse Chebyshev Zeros\n');
    helpersReportingZeros(Wz);
end

%%% Frequency Scaling
for index = 1:length(Wz)
    Wz(index) = Ws * Wz(index);
end

if(reporting)
    fprintf('\n>>> Frequency Scaling\n');
    helpersReportingZeros(Wz);
end

%%% Inverse Chebyshev Zeros
for index = 1:length(Wz)
    Wz(index) = 1 / Wz(index);
end

if(reporting)
    fprintf('\n>>> Convert to High Pass - Revert ICH Zeros\n');
    helpersReportingZeros(Wz);
end

%% Convert
reporting && fprintf('\n>> Conversions\n');

%%% Convert Poles
reporting && fprintf('>>> Poles Conversion\n');

index = 1;
for k = 1:kappa
    if omega(k) == 0
        [w(index), Q(index)] = convertRealPole(sigma(k), w0, bw);
        index = index + 1;
    else
        [w(index), Q(index), w(index + 1), Q(index + 1)] = convertComplexPoleGeffe(sigma(k), omega(k), w0, bw);
        index = index +2;
    end 
end

%%% Convert Zeros
reporting && fprintf('\n>>> Zeros Conversion\n');

index = 1;
for k = 1:length(Wz)
    [wz(index), wz(index + 1)] = convertZero(Wz(k), w0, bw);
    if wz(index) == wz(index+1)
        wz = [wz(index), wz];
        wz = wz(1:end-2);
    end
    index = index + 2;
end

%% Report Output
if(reporting)
    fprintf('\n>> Outputs\n');
    
    fprintf('\n>>> Omegas\n');
    for k=1:length(w)
        fprintf('Ω%i = %f \n', k, w(k));
    end
    
    fprintf('\n>>> Qs\n');
    for k=1:length(Q)
        fprintf('Q%i = %f \n', k, Q(k));
    end
    
    fprintf('\n>>> OmegaZeros\n');
    for k=1:length(wz)
        fprintf('Ωz%i = %f \n', k, wz(k));
    end
    
%     fprintf('\n>> Units\n');
%     for k = 1:n
%         fprintf('\n>>>Unit %i\n', k);
%         fprintf('ωo%i = %f\n', k, w(k));
%         fprintf('ωz%i = %f\n', k, wz(k));
%         fprintf('Q%i = %f\n', k, Q(k));
%         if (w(k) > wz(k))
%             fprintf('type: HPN\n');
%         elseif (w(k) < wz(k))
%             fprintf('type: LPN\n');
%         else
%             fprintf('type: Notch\n');
%         end
end

end
