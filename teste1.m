% PDS/RP

clear all
close all

Fs = 8000;
Nb = 16;
voz = audiorecorder(Fs,Nb,1);

disp('Start speaking.');
recordblocking(voz, 2);
disp('End of recording. Playing back ...');

X = getaudiodata(voz);

Emax = max(X); %Pega o valor máximo de energia do sinal
Xnu = []; %Vetor que irá armazenar o sinal sem as amostras de baixa energia
for k=1:length(X)
    if abs(X(k)) > (0.05 * Emax)
        Xnu = [Xnu; X(k)];
    end
end

figure(1)
plot(X);
figure(2)
plot(Xnu);

F = 11;     % Numero de frames
S = 0.75;   % Fator de sobreposição

carac = extrai_caracteristicas(X, F, S);

% % Número de amostras
% N = length(X);

% % Tamanho da janela
% Nj = round(N / (1 + (F - 1)*(1 - S)));

% for i = 1:11
%     subplot(11,1,i)
%     % define o inicio e fim da janela
%     a = round((i - 1) * (1-S) * Nj) + 1;
%     b = round((i - 1) * (1-S) * Nj) + Nj - 1;
%     % seleciona a janela
%     xi = X( a : b);
%     plot(xi)  
% end