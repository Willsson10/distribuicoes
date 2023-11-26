% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função de Massa de Probabilidade (PMF) da distribuição Erlang
function pmf = calcularErlangPMF(parametroN, parametroLambda, resultado)
    pmf = ((parametroLambda^parametroN) / factorial(parametroN)) .* (resultado.^(parametroN - 1)) .* exp(-parametroLambda * resultado);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) da distribuição Erlang
function cdf = calcularErlangCDF(parametroN, parametroLambda, resultado)
    cdf = 1 - gammainc(resultado * parametroLambda, parametroN, 'upper');
end

% Função para calcular a probabilidade de bloco Erlang
function pb = calcularErlangB(rho, c)
    pn = exp(-rho) * poisspdf(0:c, rho);
    pb = pn(c + 1) / sum(pn);
end

% Função para gerar variáveis aleatórias seguindo a distribuição Erlang
function resultados = gerarVariaveisErlang(parametroN, parametroLambda, numAmostras)
    % Gera variáveis exponenciais
    y = gerarVariaveisExponenciais(parametroLambda, numAmostras * parametroN);
    % Remodela os resultados em uma matriz
    y_reshaped = reshape(y, numAmostras, parametroN);
    % Soma as variáveis exponenciais para obter variáveis Erlang
    resultados = sum(y_reshaped, 2);
end

% Função para gerar variáveis aleatórias exponenciais
function resultados = gerarVariaveisExponenciais(parametroLambda, numAmostras)
    resultados = -(1/parametroLambda) * log(1 - rand(numAmostras, 1));
end

% Entrada: solicita os parâmetros n e lambda ao usuário
parametroN = input('Informe o parâmetro n (inteiro positivo): ');
parametroLambda = input('Informe lambda (entre 0 e 1): ');

% Lê os valores do arquivo 'entrada.txt'
fileID = fopen('entrada.txt', 'r');
resultados = fscanf(fileID, '%d');
fclose(fileID);

% Obtém a contagem de ocorrências de cada valor único
contagem_resultados = hist(resultados, unique(resultados));

% Gera a PMF e a CDF para a distribuição Erlang
pmfResultados = calcularErlangPMF(parametroN, parametroLambda, unique(resultados));
cdfResultados = calcularErlangCDF(parametroN, parametroLambda, unique(resultados));

% Gera variáveis aleatórias Erlang
amostrasErlang = gerarVariaveisErlang(parametroN, parametroLambda, 1000);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de barras da PMF
bar(unique(resultados), pmfResultados, 'b', 'LineWidth', 1.5);
title('Distribuição Erlang - Função de Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(unique(resultados), cdfResultados, 'r', 'LineWidth', 1.5);
title('Distribuição Erlang - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1]);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

