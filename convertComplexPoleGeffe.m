function [w01, Q01, w02, Q02] = convertComplexPoleGeffe(sigma, omega, w0, bw)

global reporting;

qc = w0/bw;

C = sigma^2 + omega^2;
D =(2*sigma)/ qc;
E = 4 + (C/(qc^2));
G = sqrt((E^2) - 4*(D^2));
Q = (1/D)*sqrt((1/2)*(E+G));

Q01 = Q;
Q02 = Q;

k = (sigma*Q)/qc;
W = k + sqrt((k^2) -1);

w02 = W * w0;
w01 = (1/W) * w0;

if (reporting)
    fprintf('\n++ Complex Pole Conversion (Geffe)\n');
    fprintf('input:\n');
    fprintf('p = %f ± %f\n', sigma, omega);
    fprintf('calculations: \n');
    fprintf('qc = %f\n', qc);
    fprintf('C = %f\n', C);
    fprintf('D = %f\n', D);
    fprintf('E = %f\n', E);
    fprintf('G = %f\n', G);
    fprintf('k = %f\n', k);
    fprintf('W = %f\n', W);
    fprintf('output: \n');
    fprintf('Q = %f\n', Q);
    fprintf('ω01 = %f\n', w01);
    fprintf('ω02 = %f\n', w02);
end
    
end

