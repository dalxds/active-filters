function helpersReportingZeros(Wz)

fprintf('k    |Ω0k          |\n');
fprintf('-----|-------------|\n');

index = 1;
for k = 1:2:2*length(Wz)
    fprintf('%i    |%f     |\n', k, Wz(index));
    index = index + 1;
end

end

