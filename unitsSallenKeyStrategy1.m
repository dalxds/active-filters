function [numerator, denumerator, gain, R] = unitsSallenKeyStrategy1(w0, Q, specsC)

global reporting;

if(reporting)
    fprintf('--Input:\n');
    fprintf('ω0 = %f\n', w0);
    fprintf('Q = %f\n', Q);
    fprintf('--Calculations\n');
end

%% Ideal Elements
R = 1;
R1 = R;
R2 = R;
r1 = 1; 
r2 = 2 - (1/Q);
C  = 1;
C1 = C;
C2 = C;
gain = 3 - (1/Q);

if(reporting)
    fprintf('-Ideal Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('r1 = %f\n', r1);
    fprintf('r2 = %f\n', r2);
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
    fprintf('gain = %f\n', gain);
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
R  = R*km;
R1 = R;
R2 = R;
r1 = r1*km;
r2 = r2*km;
C  = C*(1/(km*kf));
C1 = C;
C2 = C;

if(reporting)
    fprintf('-Real Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('r1 = %f\n', r1);
    fprintf('r2 = %f\n', r2);
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
end

%Transfer function
numerator = gain*w0^2;
denumerator = [1 (w0/Q) w0^2];

end