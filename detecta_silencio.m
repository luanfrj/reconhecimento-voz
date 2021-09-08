% funcção para detectar onde existe siencio no sinal.

function output = detecta_silencio(x,n)
    output = zeros(length(x),1);
    Emax = max(x);
    for i = n+1:length(x)
        if sum(abs(x(i-n:i)))/n < (0.1 * Emax)
            output(i) = 1;
        end
    end
end