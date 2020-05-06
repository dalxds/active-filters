function [w , Q] = convertRealPole(sigma, w0, bw)

global reporting;

w = w0;
qc = w/bw;
Q = qc/sigma;

y = rad2deg(acos(1/(2*Q)));
Re = w*cos(y);
Im = w*sin(y);
 
if(reporting)
    fprintf('\n++ Real Pole Conversion\n');
    fprintf('input (Real Pole):\n');
    fprintf('Σ = %f\n', sigma);
    fprintf('calculations:\n');
    fprintf('qc = %f\n', qc);
    fprintf('ψ = %f\n', y);
    fprintf('complex poles:\n');
    fprintf('p = %f ± j%f\n', Re, Im);
    fprintf('output:\n');
    fprintf('ω0 = %f\n', w);
    fprintf('Q = %f\n', Q);
end

end

