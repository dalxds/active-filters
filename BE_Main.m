%% set enviroment
clear all;
clc;
close all;

global reporting;
global plotting;

reporting   =   true;
plotting    =   true;

reporting && fprintf('*** Band Elimination Inverse Chebyshev ***\n');

%% specifications
reporting && fprintf('\n> Specifications\n');

AEM = [8 6 0 7];

[amin, amax, w0, w1, w2, w3, w4, specsC] = BE_Specifications(AEM);

%% filter design
reporting && fprintf('\n> Poles & Zeros\n');

[w, Q, wz, n] = BE_PolesAndZeros (amin, amax, w0, w1, w2, w3, w4);

%% units
reporting && fprintf('\n> Units\n');

%%% initialize structures
num     =   cell(n,1);
denum   =   cell(n,1);
gain    =   zeros(n,1);

%%% calculate units
for k = 1:n
    reporting && fprintf('\n>> Unit %i\n', k);
    if (w(k) > wz(k))
        reporting && fprintf('++ High Pass Notch\n');
        [num{k}, denum{k}, gain(k)] = unitsHighPassNotch(w(k), Q(k), wz(k), specsC);
    elseif (w(k) < wz(k))
        reporting && fprintf('++ Low Pass Notch\n');
        [num{k}, denum{k}, gain(k)] = unitsLowPassNotch(w(k), Q(k), wz(k), specsC);
    else
        reporting && fprintf('++ Notch\n');
        [num{k}, denum{k}, gain(k)] = unitsHighPassNotch(w(k), Q(k), wz(k), specsC);
    end
end

%% transfer function
reporting && fprintf('\n> Transfer Function\n');

%%% initialize structures
tfn = cell(n,1);

%%% units transfer functions
for k = 1:n
    tfn{k} = tf(num{k}, denum{k});
    if(plotting)
        plot_transfer_function(tfn{k}, [w1/(2*pi) w3/(2*pi) w0/(2*pi) w4/(2*pi) w2/(2*pi)]);
    end
    if(reporting)
       fprintf('>> Unit %i\n', k);
       fprintf('%s\n', evalc('tfn{k}'));
    end
end

%%% total transfer function
totalTf = 1;
for k = 1:n
   totalTf = series(totalTf, tfn{k});
end

if(plotting)
    plot_transfer_function(totalTf, [w1/(2*pi) w3/(2*pi) w0/(2*pi) w4/(2*pi) w2/(2*pi)]);
end
if(reporting)
    fprintf('\n>> Total Transfer Function with no Gain Adjustment\n');
    fprintf('%s\n', evalc('totalTf'));
end

%% gain
reporting && fprintf('\n> Gain\n');

%%% zero gain
reporting && fprintf('\n>> Zero Gain\n');

specsGain = 0;
totalGain = BE_Gain(w, wz, gain, specsGain);

zeroGainTf = series(totalTf, totalGain);
if(plotting)
    plot_transfer_function(zeroGainTf, [w3/(2*pi) w1/(2*pi) w0/(2*pi) w2/(2*pi) w4/(2*pi)]);
end
if(reporting)
    fprintf('>>> Transfer Function\n');
    fprintf('%s\n', evalc('zeroGainTf'));
end

inverseZeroGainTf = inv(zeroGainTf);
if(plotting)
    plot_transfer_function(inverseZeroGainTf, [w1/(2*pi) w3/(2*pi) w0/(2*pi) w4/(2*pi) w2/(2*pi)]);
end
if(reporting)
    fprintf('\n>>> Inverse Transfer Function\n');
    fprintf('%s\n', evalc('inverseZeroGainTf'));
end

%% fourier
reporting && fprintf('\n> Fourier\n');

BE_Fourier(w0, w1, w2, w3, zeroGainTf);