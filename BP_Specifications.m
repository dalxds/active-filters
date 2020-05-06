function [amin, amax, w0, w1, w2, w3, w4, specsC] = BP_Specifications(AEM)

global reporting;

amin = 35 - AEM(3);
amax = 0.4 + AEM(4)/36; 

f0 = 1000;
f1 = 650 + 25 * AEM(4);
f2 = f0^2 / f1;
D = 2.1 * (f0^2 - f1^2) / f1;
f3 = (-D + sqrt(D^2 + 4 * f0^2)) / 2;
f4 = f0^2 / f3;

w0 = 2*pi*f0;
w1 = 2*pi*f1;
w2 = 2*pi*f2;
w3 = 2*pi*f3;
w4 = 2*pi*f4;

specsC = 0.1 * 10^(-6);

if(reporting)
    fprintf('amin = %f dB\n', amin);
    fprintf('amax = %f dB\n', amax);
    fprintf('f0 = %f\n', f0);
    fprintf('f1 = %f\n', f1);
    fprintf('f2 = %f\n', f2);
    fprintf('D = %f\n', D);
    fprintf('f3 = %f\n', f3);
    fprintf('f4 = %f\n', f4);
    fprintf('w0 = %f\n', w0);
    fprintf('w1 = %f\n', w1);
    fprintf('w2 = %f\n', w2);
    fprintf('w3 = %f\n', w3);
    fprintf('w4 = %f\n', w4);
    fprintf('C = %i\n', specsC);
end

end
