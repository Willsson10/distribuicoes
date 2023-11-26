% Limpa a tela e o workspace
clc
clear

% Lê os valores do arquivo 'entrada.txt'
fileID = fopen('entrada.txt', 'r');
resultados = fscanf(fileID, '%f');
fclose(fileID);

% Obtém a contagem de ocorrências de cada resultado
contagem_resultados = hist(resultados, unique(resultados));

% Gera a PMF e a CDF para a distribuição Bernoulli
probabilidadeSucesso = input('Digite a probabilidade de sucesso (valores entre 0 e 1): ');
pmfResultados = calcularBernoulliPMF(probabilidadeSucesso, unique(resultados));
cdfResultados = calcularBernoulliCDF(pmfResultados, unique(resultados));

% Gera variáveis aleatórias Bernoulli
numEnsaios = input('Digite o número de ensaios: ');
amostrasAleatorias = gerarVariaveisBernoulli(probabilidadeSucesso, numEnsaios);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de barras da PMF
bar(unique(resultados), pmfResultados, 'b', 'LineWidth', 1.5);
title('Distribuição Bernoulli - Função de Massa de Probabilidade (PMF)');
xlabel('Resultado');
ylabel('Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(unique(resultados), cdfResultados, 'r', 'LineWidth', 1.5);
title('Distribuição Bernoulli - Função de Distribuição Cumulativa (CDF)');
xlabel('Resultado');
ylabel('Probabilidade acumulada');
ylim([0, 1]);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

