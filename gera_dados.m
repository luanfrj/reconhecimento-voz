clear all
close all

Fs = 8000;
Nb = 16;
voz = audiorecorder(Fs,Nb,1);

palavra = input('Digite a palavra que será gravada ');

carateristicas = [];
labels = []
for (i = 1:10)
    disp('Comece a falar.');
    recordblocking(voz, 2);
    disp('Fim da gravação. Reproduzindo ...');
    X = getaudiodata(quadrado);

    F = 11;
    S = 0.75;

    carateristicas = [carateristicas; extrai_caracteristicas(X, F, S)];
    labels = [labels; palavra];
end
