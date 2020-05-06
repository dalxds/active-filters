function [numerator, denumerator, gain] = unitsHighPassNotch(w0, Q, wz, specsC)

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

%% Gain
k1 = (W0^2/Wz^2)-1;
k2 = ((2+k1)*Q^2)/((2+k1)*Q^2+1);
gain = k2*(W0^2/Wz^2);

if(reporting)
    fprintf('-Gain\n');
    fprintf('k1 = %f\n', k1);
    fprintf('k2 = %f\n', k2);
    fprintf('gain = %f\n', gain);
end

%% Ideal Elements
R1 = 1;
R2 = (Q^2)*((k1 + 2)^2);
R3 = 1;
R4 = (Q^2)*(k1 + 2);
C = 1/(Q*(2+k1));
C1 = k1*C;

if(reporting)    
    fprintf('-Ideal Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('R3 = %f\n', R3);
    fprintf('R4 = %f\n', R4);
    fprintf('C = %f μF\n', C*10^6);
    fprintf('C1 = %f μF\n', C1*10^6);
end

%% Scaling
%%% frequency scaling
kf = w0;

%%% amplitude scaling
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
C = C*(1/(km*kf));
C1 = C1*(1/(km*kf));

if(reporting)    
    fprintf('-Real Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('R3 = %f\n', R3);
    fprintf('R4 = %f\n', R4);
    fprintf('C = %f μF\n', C*10^6);
    fprintf('C1 = %f μF\n', C1*10^6);     
end

%% Transfer function 
numerator = [gain 0 gain*wz^2];
denumerator = [1 (w0/Q) w0^2];

end