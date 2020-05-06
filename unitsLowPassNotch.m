function [numerator, denumerator, gain] = unitsLowPassNotch(w0, Q, wz, specsC)

global reporting;

if(reporting)
    fprintf('--Input:\n');
    fprintf('ω0 = %f\n', w0);
    fprintf('Q = %f\n', Q);
    fprintf('ωz = %f\n', wz);     
    fprintf('--Calculations\n');
end

%% Normalization
W0 = 1;
Wz = wz/w0;

%% Ideal Elements
R1 = 1;
R2 = 4*Q^2;
R3 = (Wz^2)/(2*Q^2);
R4 = 1;
R5 = (4*Q^2)/(Wz^2-1);
C = 1/(2*Q);

if(reporting)    
    fprintf('-Ideal Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('R3 = %f\n', R3);
    fprintf('R4 = %f\n', R4);
    fprintf('R5 = %f\n', R5);
    fprintf('C = %f μF\n', C*10^6);
end

%% Gain
gain = 1 / (1 + R3);

if(reporting)    
    fprintf('-Gain\n');
    fprintf('gain = %f\n', gain);
end

%% Scaling
% Frequency scaling 
kf = w0;

% Amplitude scaling 
km = C/(specsC * kf);

if(reporting)    
    fprintf('-Scaling\n');
    fprintf('kf = %f\n', kf);
    fprintf('km = %f\n', km);   
end

%% Real Elements 
R1 = R1*km;
R2 = R2*km;
R3 = R3*km;
R4 = R4*km;
R5 = R5*km;
C = C*(1/(km*kf));

if(reporting)    
    fprintf('-Real Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('R3 = %f\n', R3);
    fprintf('R4 = %f\n', R4);
    fprintf('R5 = %f\n', R5);
    fprintf('C = %f μF\n', C*10^6);
end

%% Transfer function
numerator = [gain 0 gain*wz^2];
denumerator = [1 (w0/Q) w0^2];

end

