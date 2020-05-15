function [numerator, denumerator, gain] = unitsSallenKeyStrategy2HP(w0, Q, specsC)

global reporting;

if(reporting)
    fprintf('--Input:\n');
    fprintf('ω0 = %f\n', w0);
    fprintf('Q = %f\n', Q);
    fprintf('--Calculations\n');
end

%% Ideal Elements
R1 = 1/(2*Q);
R2 = 2*Q;
C  = 1;
C1 = C;
C2 = C;
gain = 1;

if(reporting)
    fprintf('-Ideal Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
    fprintf('gain = %f μF\n', gain);
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
C  = C*(1/(km*kf));
C1 = C;
C2 = C;

if(reporting)
    fprintf('-Real Elements\n');
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
end

%Transfer function
numerator = [gain 0 0];
denumerator = [1 (w0/Q) w0^2];

end

