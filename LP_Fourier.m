function LP_Fourier(ChebyshevLowPass)

global plotting;

Fs = 40000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 22000;            % Length of signal
t = (0:L-1)*T;        % Time vector
f = 2000;

X = 0.5*square(2*pi*t*f,40);
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierLowPass = OnlySources(1:L/2+1);
InputFourierLowPass(2:end-1) = 2*InputFourierLowPass(2:end-1);

f = Fs*(0:(L/2))/L;

if(plotting)
    figure;
    plot(f,InputFourierLowPass); 
    title('Low Pass Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end
    
Z = lsim(ChebyshevLowPass,X, t);
W = fft(Z);
OnlySources = abs(W/L);
OutputFourierLowPass = OnlySources(1:L/2+1);
OutputFourierLowPass(2:end-1) = 2*OutputFourierLowPass(2:end-1);

if(plotting)
    figure;
    plot(f,OutputFourierLowPass); 
    title('Low Pass Output Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

end