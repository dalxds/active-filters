function BE_Fourier(w0, w1, w2, w3, tf)

global plotting;

Fs = 20000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 10000;            % Length of signal
t = (0:L-1)*T;        % Time vector

w(1) = w0-((w0-w3)/3);
w(2) = w0+((w0+w3)/4);
w(3) = 0.5*w1;
w(4) = 2.4*w2;
w(5) = 3.5*w2;

X = cos(w(1)*t) + 0.6*cos(w(2)*t) + 0.7*cos(w(3)*t) + 0.8*cos(w(4)*t) + 0.6*cos(w(5)*t);
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierBandElimination = OnlySources(1:L/2+1);
InputFourierBandElimination(2:end-1) = 2*InputFourierBandElimination(2:end-1);

f = Fs*(0:(L/2))/L;

if (plotting)
    figure;
    plot(f,InputFourierBandElimination); 
    title('Band Elimination Input Fourier');
    xlabel('f (Hz)');
    ylabel('Voltage (V)');
end

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

