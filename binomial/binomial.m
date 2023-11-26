% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função de Massa de Probabilidade (PMF) da distribuição binomial
function pmf = calcularBinomialPMF(numEnsaios, probabilidadeSucesso, resultado)
    % Calcula os parâmetros relevantes para a PMF binomial
    prob = min(probabilidadeSucesso, 1 - probabilidadeSucesso);
    i = 0:numEnsaios - 1;
    ip = ((numEnsaios - i) ./ (i + 1)) * (prob / (1 - prob));
    pb = ((1 - prob)^numEnsaios) * cumprod([1, ip]);

    % Inverte o vetor pb se prob for menor que probabilidadeSucesso original
    if prob < probabilidadeSucesso
        pb = fliplr(pb);
    end

    % Garante que as variáveis de entrada sejam vetores de coluna
    pb = pb(:);
    resultado = resultado(:);

    % Filtra os resultados válidos (números inteiros não negativos)
    okResultados = (resultado >= 0) .* (resultado <= numEnsaios) .* (resultado == floor(resultado));

    % Aplica as restrições e calcula a PMF
    resultado = okResultados .* resultado;
    pmf = okResultados .* pb(resultado + 1);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) da distribuição binomial
function cdf = calcularBinomialCDF(pmf, resultado)
    % Garante que resultado seja um vetor de inteiros
    resultado = floor(resultado(:));
    % Gera todos os valores possíveis de resultado
    allResultados = 0:max(resultado);
    % Calcula a CDF acumulando a PMF
    allCDF = cumsum(pmf);

    % Garante que allCDF tenha pelo menos o mesmo número de elementos que allResultados + 1
    if numel(allCDF) < numel(allResultados) + 1
        allCDF(numel(allResultados) + 1) = 1;
    end

    % Filtra os resultados válidos (números inteiros não negativos)
    okResultados = (resultado >= 0);

    % Aplica as restrições e calcula a CDF
    resultado = okResultados .* resultado;
    cdf = okResultados .* allCDF(resultado + 1);
end

% Função para contar elementos em uma CDF
function result = contarElementosCDF(cdf, valores)
    result = zeros(size(valores));
    for i = 1:numel(valores)
        result(i) = find(cdf >= valores(i), 1, 'first') - 1;
    end
end

% Função para gerar variáveis aleatórias seguindo a distribuição binomial
function resultados = gerarVariaveisBinomiais(numEnsaios, probabilidadeSucesso, numAmostras)
    % Gera valores aleatórios entre 0 e 1
    r = rand(numAmostras, 1);
    % Calcula a CDF para a distribuição binomial
    cdf = calcularBinomialCDF(calcularBinomialPMF(numEnsaios, probabilidadeSucesso, 0:numEnsaios), 0:numEnsaios);
    % Conta os elementos na CDF
    resultados = contarElementosCDF(cdf, r);
end

% Entrada: solicita a probabilidade de sucesso e o número de ensaios ao usuário
probabilidadeSucesso = input('Digite a probabilidade de sucesso (valores entre 0 e 1): ');
numEnsaios = input('Digite o número de ensaios n: ');

% Lê os valores do arquivo 'entrada.txt'
fileID = fopen('entrada.txt', 'r');
resultados = fscanf(fileID, '%d');
fclose(fileID);

% Gera a PMF e a CDF para a distribuição binomial
pmfResultados = calcularBinomialPMF(numEnsaios, probabilidadeSucesso, resultados);
cdfResultados = calcularBinomialCDF(pmfResultados, resultados);

% Gera variáveis aleatórias binomiais
amostrasBinomiais = gerarVariaveisBinomiais(numEnsaios, probabilidadeSucesso, 1000);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de barras da PMF
bar(resultados, pmfResultados, 'b', 'LineWidth', 1.5);
title('Distribuição Binomial - Função de Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(resultados, cdfResultados, 'r', 'LineWidth', 1.5);
title('Distribuição Binomial - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1]);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

