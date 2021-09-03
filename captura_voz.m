% % % % % % % % % % % % % % % % % % % % % %
% Trabalho da Discplina PDS/RP
% Jorge, Leonardo e Luan
% Programa para salvar os exemplos que serão usados para treinamento
% % % % % % % % % % % % % % % % % % % % % %

clear all
close all

Fs = 8000;
Nb = 16;
quadrado = audiorecorder(Fs,Nb,1);

palavra = input('Digite a palavra (entre aspas) que será gravada: ');

for (i = 1:10)
    str = compose("Palavra %2d. Comece a falar.", i);
    disp(str);
    recordblocking(quadrado, 3);
    disp('Fim da gravação. Reproduzindo ...');
    X = getaudiodata(quadrado);
    % sound(X)
    arquivo = compose("%s%02d.wav", palavra, i);
    audiowrite(arquivo, X, Fs);

    subplot(10,1,i)
    plot(X);
    grid on
end
