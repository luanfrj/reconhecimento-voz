% % % % % % % % % % % % % % % % % % % % % %
% Trabalho da Discplina PDS/RP
% Jorge, Leonardo e Luan
% Programa para reconhecer a figura geometrica falada
% % % % % % % % % % % % % % % % % % % % % %
clear all;
close all;

% Carrega o arquivo com as amostras (gerado no programa carrega_arquivos)
load('samples.mat');

% Gera o modelo KNN
KNN = fitcknn(caracteristicas, rotulos, 'NumNeighbors',5);

arquivo = input('Digite o nome do arquivo contendo o audio: ');

[Xn, Fs] = audioread(arquivo);
    
silencios = detecta_silencio(Xn,10);    % Detecta silêncios
output = strfind(silencios', [1 0]);    % Encontra onde o silêncio termina
Xn = Xn(output(1):output(1)+4000);      % Remove o silêncio antes da palavra e pega 4000 amostras (0.5s)

F = 11;
S = 0.75;

% Extrai as características da voz lida
C = extrai_caracteristicas(Xn, F, S)';

rotulo = predict(KNN,C);

switch rotulo
case 'c'
    disp('Circulo');
case 'e'
    disp('Elipse');
case 'q'
    disp('Quadrado');
case 'r'
    disp('Retângulo');
case 't'
    disp('Triângulo');
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