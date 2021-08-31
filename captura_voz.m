clear all
close all

Fs = 8000;
Nb = 16;
quadrado = audiorecorder(Fs,Nb,1);

palavra = input('Digite a palavra que será gravada ');

for (i = 1:10)
    disp('Comece a falar.');
    recordblocking(quadrado, 3);
    disp('Fim da gravação. Reproduzindo ...');
    X = getaudiodata(quadrado);
    % sound(X)
    arquivo = compose("%s%02d.wav", palavra, i);
    audiowrite(arquivo, X, Fs);
end
