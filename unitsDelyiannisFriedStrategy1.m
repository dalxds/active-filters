function [numerator, denumerator, gain] = unitsDelyiannisFriedStrategy1(w0 , Q, specsC)

global reporting;

%% Ideal Elements
C = 1/(2*Q);
C1 = C;
C2 = C; 
R1 = 1;
R2 = 4*Q^2;
gain = 2*(Q^2);

if(reporting)
    fprintf('-Ideal Elements\n');
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
    fprintf('-Gain\n');
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
R1 = R1*km;
R2 = R2*km;
C1 = C1*(1/(km*kf));
C2 = C2*(1/(km*kf));

if(reporting)    
    fprintf('-Real Elements\n');
    fprintf('C1 = %f μF\n', C1*10^6);
    fprintf('C2 = %f μF\n', C2*10^6);
    fprintf('R1 = %f\n', R1);
    fprintf('R2 = %f\n', R2);
end

%% Transfer function
numerator = [0 -2*Q 0];
denumerator = [1 (1/Q) 1];

end