function totalGain = HP_Gain(gain, specsGain)

global reporting;

%% convert from db
specsGain = 10^(specsGain/20);

%% calculate gain for high frequncies
totalHighGain = prod(gain);

%% calculations
% attenuation ratio
a = specsGain / totalHighGain;

%% new elements
R1 = 10000;
R2 = a*R1;

% final Gain
totalGain = -(R2/R1);

%% reporting
if(reporting)
   fprintf('>> Gain for %i db\n', mag2db(specsGain));
   fprintf('totalHighGain = %f\n', totalHighGain);
   fprintf('a = %f\n', a);
   fprintf('R1 = %f\n', R1);
   fprintf('R2 = %f\n', R2);
   fprintf('totalGain = %f = %f db\n', totalGain, db2mag(totalGain));
end

end

