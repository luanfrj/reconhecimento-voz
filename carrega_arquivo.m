close all
clear all

for j=1:10
    nome = compose("quadrado%02d.wav", j);
    [Xn, Fs]= audioread(nome);

    Emax = max(Xn); %Pega o valor máximo de energia do sinal
    Xnu = []; %Vetor que irá armazenar o sinal sem as amostras de baixa energia
    for k=1:length(Xn)
        if abs(Xn(k)) > (0.10 * Emax)
            Xnu = [Xnu; Xn(k)];
        end
    end
    subplot(10,1,j)
    plot(Xnu);
end