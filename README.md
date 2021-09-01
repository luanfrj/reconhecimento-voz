# Reconhecimento de Voz

O reconhecimento é feito baseado nos coeficientes cepstrais.

## extrai_caracteristicas.m

A extração de caracteristicas é feita utilizando a função `extrai_caracteristicas`.

Essa função recebe um vetor de entrada (X), o número de janelas (F) e o fator de sbreposição das janelas (S).

## captura_voz.m

Programa que captura 10 amostras de voz contendo uma palavra.

## carrega_arquivos.m

Programa que lê as amostras e gera a base de dados rotulada para ser usada na geração do modelo KNN.

## reconhece_figura.m

Programa que usa a base rotulada para gerar o modelo e classificar uma amostra de audio contendo uma nova palavra.

