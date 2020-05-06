function BP_Fourier(w0, w1, w3, w4, InverseChebyshevBandPass)

global plotting;

Fs = 12000;          % Sampling frequency                    
T = 1/Fs;            % Sampling period       
L = 5800;            % Length of signal
t = (0:L-1)*T;       % Time vector

X = cos((w0 - ((w0 - w1)/2))*t) + 0.6*cos((w0 + ((w0 + w1)/2))*t) + cos((0.5 * w3)*t) + 0.8*cos((2.4 * w4)*t) + 0.4*cos((3.5*w4)*t);
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierBandPass = OnlySources(1:L/2+1);
InputFourierBandPass(2:end-1) = 2*InputFourierBandPass(2:end-1);

f = Fs*(0:(L/2))/L;

if(plotting)
    figure;
    plot(f,InputFourierBandPass); 
    title('Band Pass Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

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

