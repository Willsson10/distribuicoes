% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função de Distribuição Cumulativa (CDF) da distribuição exponencial
function cdf = calcularExponencialCDF(parametroLambda, resultado)
    cdf = 1.0 - exp(-parametroLambda * resultado);
end

% Função para calcular a Função de Densidade de Probabilidade (PDF) da distribuição exponencial
function pdf = calcularExponencialPDF(parametroLambda, resultado)
    pdf = parametroLambda * exp(-parametroLambda * resultado) .* (resultado >= 0);
end

% Função para gerar variáveis aleatórias seguindo a distribuição exponencial
function resultados = gerarVariaveisExponenciais(parametroLambda, numAmostras)
    resultados = -(1/parametroLambda) * log(1 - rand(numAmostras, 1));
end

% Entrada: solicita a taxa de chegada lambda ao usuário
parametroLambda = input('Digite a taxa de chegada lambda (entre 0 e 1): ');

% Lê os valores do arquivo 'entrada.txt'
fileID = fopen('entrada.txt', 'r');
resultados = fscanf(fileID, '%d');
fclose(fileID);

% Gera a PDF e a CDF para a distribuição exponencial
pdfResultados = calcularExponencialPDF(parametroLambda, resultados);
cdfResultados = calcularExponencialCDF(parametroLambda, resultados);

% Gera variáveis aleatórias exponenciais
amostrasExponenciais = gerarVariaveisExponenciais(parametroLambda, 1000);

% Plotagem:
figure;

% Subplotagem para a PDF
subplot(2, 1, 1);
% Gráfico de barras da PDF
bar(resultados, pdfResultados, 'b', 'LineWidth', 1.5);
title('Distribuição Exponencial - Função de Densidade de Probabilidade (PDF)');
xlabel('X');
ylabel('Densidade de Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(resultados, cdfResultados, 'r', 'LineWidth', 1.5);
title('Distribuição Exponencial - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1]);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

