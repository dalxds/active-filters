function HP_Fourier(ws, wp, ButterworthHighPass)

global reporting;
global plotting;

Fs = 50000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 23000;            % Length of signal
t = (0:L-1)*T;        % Time vector

%%% fourier frequncies
f(1) = 0.5*ws;
f(2) = 0.8*ws;
f(3) = 1.2*wp;
f(4) = 2.4*wp;
f(5) = 3.5*wp;

X = cos(f(1)*t) + 0.6*cos(f(2)*t) + cos(f(3)*t) + 0.8*cos(f(4)*t) + 0.4*cos(f(5)*t);
Y = fft(X);
OnlySources = abs(Y/L);
InputFourierHighPass = OnlySources(1:L/2+1);
InputFourierHighPass(2:end-1) = 2*InputFourierHighPass(2:end-1);

if(reporting)
    fprintf('>>> Frequencies\n');
    for i = 1:length(f)
        fprintf('f%i = %f Hz\n', i, f(i));
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

