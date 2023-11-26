% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função Densidade de Probabilidade (PDF) para a distribuição gaussiana
function pdf = calcularGaussPDF(mu, sigma, x)
    pdf = exp(-(x - mu).^2 / (2 * sigma^2)) / sqrt(2 * pi * sigma^2);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) para a distribuição gaussiana
function cdf = calcularGaussCDF(mu, sigma, x)
    cdf = 0.5 * (1 + erf((x - mu) / (sigma * sqrt(2))));
end

% Função para gerar variáveis aleatórias seguindo a distribuição gaussiana
function x = gerarGaussRV(mu, sigma, m)
    x = mu + sigma * randn(m, 1);
end

% Função para calcular a PDF de um vetor gaussiano
function pdf = calcularGaussVectorPDF(mu, C, a)
    n = length(a);
    z = a(:) - mu(:);
    pdf = exp(-z' * inv(C) * z) / sqrt((2 * pi)^n * det(C));
end

% Entrada: solicita o parâmetro mu (inteiro positivo e dentro dos dados fornecidos)
mu = input('Informe o parâmetro mu (inteiro positivo e dentro dos dados fornecidos): ');

% Entrada: solicita o parâmetro sigma (entre 0 e 1)
sigma = input('Informe o parâmetro sigma (entre 0 e 1): ');

% Lê os valores do arquivo 'entrada.txt'
fid = fopen('entrada.txt', 'r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcula os valores da PDF e CDF para a distribuição gaussiana
valores_pdf = calcularGaussPDF(mu, sigma, x);
valores_cdf = calcularGaussCDF(mu, sigma, x);

% Plotagem:
figure;

% Subplotagem para a PDF
subplot(2, 1, 1);
% Gráfico de barras da PDF
bar(x, valores_pdf, 'b', 'LineWidth', 1.5);
title('Distribuição Gaussiana - Função Densidade de Probabilidade (PDF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
set(gca, 'xtick', x);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(x, valores_cdf, 'r', 'LineWidth', 1.5);
title('Distribuição Gaussiana - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
set(gca, 'xtick', x);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

