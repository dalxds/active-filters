function [amin, amax, wp, ws, m, specsC] = HP_Specifications(AEM)

global reporting;

m = 2;

amin = 24 + (AEM(3)*(6/9));
amax = 0.5 + (AEM(4)/36);

fp = (4 + m)*1000;
fs = fp/2.6;

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