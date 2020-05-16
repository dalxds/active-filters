function HP_Fourier(ws, wp, ButterworthHighPass)

global reporting;
global plotting;

%% fourier parameters
Fs = 50000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 23000;            % Length of signal
t = (0:L-1)*T;        % Time vector

%% fourier input
%%% frequencies
w(1) = 0.5*ws;
w(2) = 0.8*ws;
w(3) = 1.2*wp;
w(4) = 2.4*wp;
w(5) = 3.5*wp;

%%% amplitudes
a(1) = 1;
a(2) = 0.6;
a(3) = 1;
a(4) = 0.8;
a(5) = 0.4;

%%% signal
X = 0;
for i = 1:length(a)
   X = X + a(i)*cos(w(i)*t);
end
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierHighPass = OnlySources(1:L/2+1);
InputFourierHighPass(2:end-1) = 2*InputFourierHighPass(2:end-1);

if(reporting)
    fprintf('Fs = %f\n', Fs);
    fprintf('T = %f\n', T);
    fprintf('L = %f\n', L);
    fprintf('>>> Frequencies & Amplitudes\n');
    for i = 1:length(a)
        fprintf('a%i = %f - w%i = %f\n', i, a(i), i, w(i));
    end
end

if(plotting)
    f = Fs*(0:(L/2))/L;
    figure;
    plot(f,InputFourierHighPass); 
    title('High Pass Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

Z = lsim(ButterworthHighPass, X, t);
W = fft(Z);
OnlySources = abs(W/L);
OutputFourierHighPass = OnlySources(1:L/2+1);
OutputFourierHighPass(2:end-1) = 2*OutputFourierHighPass(2:end-1);

if(plotting)
    figure;
    plot(f,OutputFourierHighPass); 
    title('High Pass Output Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

end

