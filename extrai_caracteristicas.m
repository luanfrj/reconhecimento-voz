% Extrai características de um sinal de voz baseado nos coeficientes cepstrais
% Parâmetros de entrada:
%   X: sinal de voz
%   F: número de janelas
%   S: Fator de sobreposição das janelas

function vet_car = extrai_caracteristicas(X, F, S)
    % Número de amostras
    N = length(X);

    % Tamanho da janela
    Nj = round(N / (1 + (F - 1)*(1 - S)));

    vet_car = [];

    for i = 1:11
        % define o inicio e fim da janela
        a = round((i - 1) * (1-S) * Nj) + 1;
        b = round((i - 1) * (1-S) * Nj) + Nj - 1;
        % seleciona a janela
        xi = X( a : b);
        yi = rceps(xi);

        vet_car = [vet_car; yi(1:12)];
    end
end