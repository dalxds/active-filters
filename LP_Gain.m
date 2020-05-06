function totalGain = LP_Gain(gain, specsGain, R)

global reporting;

%% convert from db
specsGain = 10^(specsGain/20);

%% calculate gain for high frequncies
totalLowGain = prod(gain);

%% calculations
% attenuation ratio
a = specsGain / totalLowGain;

%% new elements
Z1 = R(1)/a;
Z2 = R(1)/(1-a);

% final Gain
totalGain = a;

%% reporting
if(reporting)
   fprintf('>> Gain for %i db\n', mag2db(specsGain));
   fprintf('totalLowGain = %f\n', totalLowGain);
   fprintf('a = %f\n', a);
   fprintf('Z1 = %f\n', Z1);
   fprintf('Z2 = %f\n', Z2);
   fprintf('totalGain = %f = %f db\n', totalGain, db2mag(totalGain));
end

end