function BE_Fourier(w0, w1, w2, w3, tf)

global reporting;
global plotting;

%% fourier parameters
Fs = 20000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector

%% fourier input
%%% frequencies
w(1) = w0 - ((w0 - w3)/3);
w(2) = w0 + ((w0 + w3)/4);
w(3) = 0.5*w1;
w(4) = 2.4*w2;
w(5) = 3*w2;

%%% amplitudes
a(1) = 1;
a(2) = 0.6;
a(3) = 0.7;
a(4) = 0.8;
a(5) = 0.6;

%%% signal
X = 0;
for i = 1:length(a)
   X = X + a(i)*cos(w(i)*t);
end
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierBandElimination = OnlySources(1:L/2+1);
InputFourierBandElimination(2:end-1) = 2*InputFourierBandElimination(2:end-1);

f = Fs*(0:(L/2))/L;

if(reporting)
    fprintf('Fs = %f\n', Fs);
    fprintf('T = %f\n', T);
    fprintf('L = %f\n', L);
    fprintf('>>> Frequencies & Amplitudes\n');
    for i = 1:length(a)
        fprintf('a%i = %f - w%i = %f\n', i, a(i), i, w(i));
    end
end

if (plotting)
    figure;
    plot(f,InputFourierBandElimination); 
    title('Band Elimination Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

%% output fourier
Z = lsim(tf, X, t);
W = fft(Z);
OnlySources = abs(W/L);
OutputFourierBandElimination = OnlySources(1:L/2+1);
OutputFourierBandElimination(2:end-1) = 2*OutputFourierBandElimination(2:end-1);

if(plotting)
    figure;
    plot(f,OutputFourierBandElimination); 
    title('Band Elimination Output Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

end

