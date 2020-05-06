function [amin, amax, wp, ws, m, specsC] = LP_Specifications(AEM)

global reporting;

m = 3;

amin = 21.5 + ((max(1,AEM(3)) - 5) * 0.5);
amax = 0.55 + ((max(1,AEM(4)) - 5) / 10);

fp = (3 + m)*1100;
fs = 1.6*fp;

wp = 2*pi*fp;
ws = 2*pi*fs;

specsC = 0.01 * 10^(-6);

if(reporting)
    fprintf('m = %i\n', m);
    fprintf('amin = %f dB\n', amin);
    fprintf('amax = %f dB\n', amax);
    fprintf('fp = %f\n', fp);
    fprintf('fs = %f\n', fs);
    fprintf('wp = %f\n', wp);
    fprintf('ws = %f\n', ws);
    fprintf('C = %i\n', specsC);
end

end