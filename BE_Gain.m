function totalGain = BE_Gain(w, wz, gain, specsGain)

global reporting;

%% convert from db
specsGain = 10^(specsGain/20);

%% calculate gain for high frequncies
totalHighGain = prod(gain);

%% calculate gain for low frequencies
unitsLowGain = zeros(length(gain),1);

for k = 1:length(gain)
    unitsLowGain(k) = abs(gain(k)*((wz(k)/w(k))^2));
end

totalLowGain = prod(unitsLowGain);

%% invert wiring
% attenuation ratio
a = specsGain / totalLowGain;

% calculation elements
R1 = 10000;
R2 = a * R1;

% final Gain
totalGain = - (R2/R1);

%% reporting
if(reporting)
   fprintf('>> Gain for %i db\n', mag2db(specsGain));
   fprintf('totalHighGain = %f\n', totalHighGain);
   fprintf('totalLowGain = %f\n', totalLowGain);
   fprintf('a = %f\n', a);
   fprintf('R1 = %f\n', R1);
   fprintf('R2 = %f\n', R2);
   fprintf('totalGain = %f = %f db\n', totalGain, db2mag(totalGain));
end

end