close all
clear all
clc 

arquivos = dir('Audios/quadrado1/*.wav');

for j=1:length(arquivos)
    nome = compose("Audios/quadrado1/%s", arquivos(j).name);
    [Xn, Fs] = audioread(nome);

    silencios = detecta_silencio(Xn,10);    % Detecta silêncios
    output = strfind(silencios', [1 0]);    % Encontra onde começa a palavra
    Xn = Xn(output(1):output(1)+4000);          % Remove o silêncio antes da palavra e pega 4000 amostras (0.5s)

    sound(Xn, Fs);
    pause(0.5);

    subplot(10,1,j)
    plot(Xn);
    grid on
end

function output = detecta_silencio(x,n)
    output = zeros(length(x),1);
    Emax = max(x);
    for i = n+1:length(x)
        if sum(abs(x(i-n:i)))/n < (0.1 * Emax)
            output(i) = 1;
        end
    end
end