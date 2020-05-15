function BP_Fourier(w0, w1, w3, w4, InverseChebyshevBandPass)

global reporting;
global plotting;

%% fourier parameters
Fs = 12000;          % Sampling frequency                    
T = 1/Fs;            % Sampling period       
L = 5800;            % Length of signal
t = (0:L-1)*T;       % Time vector

%% fourier input
%%% frequencies
w(1) = w0 - ((w0 - w1)/3);
w(2) = w0 + ((w0 + w1)/4);
w(3) = 0.5*w3;
w(4) = 2.4*w4;
w(5) = 3*w4;

%%% amplitudes
a(1) = 1;
a(2) = 0.6;
a(3) = 0.7;
a(4) = 0.8;
a(5) = 0.6;

%%% signal
X = sum(a.*cos(w*t));
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierBandPass = OnlySources(1:L/2+1);
InputFourierBandPass(2:end-1) = 2*InputFourierBandPass(2:end-1);

f = Fs*(0:(L/2))/L;

if(reporting)
    fprintf('Fs = %f\n', Fs);
    fprintf('T = %f\n', T);
    fprintf('L = %f\n', L);
    fprintf('>>> Frequencies & Amplitudes\n');
    for i = 1:length(a)
        fprintf('a%i = %f - w%i = %f', i, a(i), w(i));
    end
end

if(plotting)
    figure;
    plot(f,InputFourierBandPass); 
    title('Band Pass Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

%% fourier output
Z = lsim(InverseChebyshevBandPass,X, t);
W = fft(Z);
OnlySources = abs(W/L);
OutputFourierBandPass = OnlySources(1:L/2+1);
OutputFourierBandPass(2:end-1) = 2*OutputFourierBandPass(2:end-1);

if(plotting)
    figure;
    plot(f,OutputFourierBandPass); 
    title('Band Pass Output Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

end

