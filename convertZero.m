 function [wz2, wz1] = convertZero (wz, w0, bw)

global reporting;

qc = w0/bw;
K = (2 + ((wz^2)/(qc^2)));
x = (K + sqrt((K^2) - 4))/2;

wz1 = w0 * sqrt(x);
wz2 = w0 / sqrt(x);

if(reporting)
    fprintf('\n++ Imaginary Zero Conversion\n');
    fprintf('input (Zero):\n');
    fprintf('Ωz = %f\n', wz);
    fprintf('calculations:\n');
    fprintf('qc = %f\n', qc);
    fprintf('K = %f\n', K);
    fprintf('x = %f\n', x);
    fprintf('output:\n');
    fprintf('ωz1 = %f\n', wz1);
    fprintf('ωz2 = %f\n', wz2);
end

end

