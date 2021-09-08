% % % % % % % % % % % % % % % % % % % % % %
% Trabalho da Discplina PDS/RP
% Jorge, Leonardo e Luan
% Programa para testar a qualidade do classificador
% % % % % % % % % % % % % % % % % % % % % %
clear all
close all
% Carrega o arquivo com as amostras (gerado no programa carrega_arquivos)
load('samples.mat');

% Gera o modelo KNN
KNN = fitcknn(caracteristicas, rotulos, 'NumNeighbors',5);

arquivos = dir('Teste/*.wav');

total = length(arquivos);
acertos = 0;
erros = 0;

figure()
for j=1:length(arquivos)

    nome = compose("Teste/%s", arquivos(j).name);
    [Xn, Fs] = audioread(nome);

    silencios = detecta_silencio(Xn,10);    % Detecta silêncios
    output = strfind(silencios', [1 0]);    % Encontra onde o silêncio termina
    if output(1)+4000 > length(Xn)
        b = length(Xn);
    else
        b = output(1)+4000;
    end
    Xn = Xn(output(1):b);      % Remove o silêncio antes da palavra e pega 4000 amostras (0.5s)

    F = 11;
    S = 0.75;

    % Extrai as características da voz lida
    C = extrai_caracteristicas(Xn, F, S)';

    rotulo_predito = predict(KNN,C);
    rotulo_verdadeiro = arquivos(j).name(1);

    msg = compose("Predito: %s Verdadeiro: %s", rotulo_predito, rotulo_verdadeiro);
    disp(msg) 
    if(rotulo_predito == rotulo_verdadeiro)
        acertos = acertos + 1;
    else
        erros = erros + 1;
    end

    % sound(Xn, Fs)
    % pause(0.5)

    subplot(round(length(arquivos)/2),2,j)
    plot(Xn);
    grid on
end

disp("Percentual de acertos: ")
disp(acertos/total * 100)

disp("Percentual de erros: ")
disp(erros/total * 100)
