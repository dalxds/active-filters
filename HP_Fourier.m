function HP_Fourier(ws, wp, ButterworthHighPass)

global plotting;

Fs = 50000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 23000;            % Length of signal
t = (0:L-1)*T;        % Time vector

X =cos(0.4*ws*t) + 0.5*cos(0.9*ws*t) + cos(1.4* wp*t) + 0.7*cos(2.4*wp*t) + 0.5*cos(4.5*wp*t);
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierHighPass = OnlySources(1:L/2+1);
InputFourierHighPass(2:end-1) = 2*InputFourierHighPass(2:end-1);

if(plotting)
    f = Fs*(0:(L/2))/L;
    figure;
    plot(f,InputFourierHighPass); 
    title('High Pass Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

Z = lsim(ButterworthHighPass,X, t);
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

