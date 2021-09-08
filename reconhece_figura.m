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

disp('Escolha a opção:')
disp('1 - Ler do arquivo.')
disp('2 - Gravar voz.')

opcao = input('-> ');

switch opcao
case 1
    arquivo = input('Digite o nome do arquivo (entre aspas) contendo o audio: ');
    [Xn, Fs] = audioread(arquivo);

case 2
    Fs = 8000;
    Nb = 16;
    gravador = audiorecorder(Fs,Nb,1);
    pause(0.5);
    disp('Comece a falar.');
    recordblocking(gravador, 3);
    disp('Fim da gravação.');
    Xn = getaudiodata(gravador);
end

    
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

