% % % % % % % % % % % % % % % % % % % % % %
% Trabalho da Discplina PDS/RP
% Jorge, Leonardo e Luan
% Programa para extrair as características da base de treinamento
% % % % % % % % % % % % % % % % % % % % % %
close all
clear all 

% Classes
%   c - circulo
%   e - elipse
%   q - quadrado
%   r - retangulo
%   t - triangulo

% inicializa a matriz de caracteristicas e rótulos
caracteristicas = [];
rotulos = [];

% 1 - Lê as amostras de audio quadrado
palavra = 'quadrado';
arquivos = dir('Audios/quadrado/*.wav');
[X, Y] = gera_base(arquivos, palavra);
caracteristicas = [caracteristicas; X];
rotulos = [rotulos; Y];

% 2 - Lê as amostras de audio circulo
palavra = 'circulo';
arquivos = dir('Audios/circulo/*.wav');
[X, Y] = gera_base(arquivos, palavra);
caracteristicas = [caracteristicas; X];
rotulos = [rotulos; Y];

% 3 - Lê as amostras de audio quadrado
palavra = 'elipse';
arquivos = dir('Audios/elipse/*.wav');
[X, Y] = gera_base(arquivos, palavra);
caracteristicas = [caracteristicas; X];
rotulos = [rotulos; Y];

% 4 - Lê as amostras de audio quadrado
palavra = 'retangulo';
arquivos = dir('Audios/retangulo/*.wav');
[X, Y] = gera_base(arquivos, palavra);
caracteristicas = [caracteristicas; X];
rotulos = [rotulos; Y];

% 4 - Lê as amostras de audio quadrado
palavra = 'triangulo';
arquivos = dir('Audios/triangulo/*.wav');
[X, Y] = gera_base(arquivos, palavra);
caracteristicas = [caracteristicas; X];
rotulos = [rotulos; Y];

% Salva as caracteristicas encontradas para serem usadas para gerar o classificador posteriormente
save('samples.mat', 'caracteristicas', 'rotulos');

function [caracteristicas, rotulos] = gera_base(arquivos, palavra)

    caracteristicas = [];
    rotulos = [];

    figure()
    for j=1:length(arquivos)
        nome = compose("Audios/%s/%s", palavra, arquivos(j).name);
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

        caracteristicas = [caracteristicas; extrai_caracteristicas(Xn, F, S)'];
        rotulos = [rotulos; palavra(1)];
        subplot(round(length(arquivos)/2),2,j)
        plot(Xn);
        grid on
    end
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