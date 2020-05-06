function totalGain = BP_Gain(w, Q, wz, gain, specsGain, w0)

global reporting;

%% convert from db
specsGain = 10^(specsGain/20);

%% calculate gain in w0
unitsBandGain = zeros(length(gain), 1);

for k = 1:length(w)
    if w(k) == wz(k)
        unitsBandGain(k) = abs(gain(k));
    else
        unitsBandGain(k) = abs(gain(k)*((wz(k)^2 - w0^2) / (sqrt((w(k)^2 - w0^2)^2 + ((w(k) * w0) / Q(k))^2) ) ) );
    end
end

totalBandGain = prod(unitsBandGain);

%% invert wiring
% attenuation ratio
a = specsGain / totalBandGain;

% calculation elements
R1 = 10000;
R2 = a * R1;

% final Gain
totalGain = - (R2/R1);

%% reporting
if(reporting)
   fprintf('>> Gain for %i db in ω0 = %f\n', mag2db(specsGain), w0);
   fprintf('totalBandGain = %f = %f db\n', totalBandGain, db2mag(totalBandGain));
   fprintf('a = %f\n', a);
   fprintf('R1 = %f\n', R1);
   fprintf('R2 = %f\n', R2);
   fprintf('totalGain = %f = %f db\n', totalGain, db2mag(totalGain));
end


end

