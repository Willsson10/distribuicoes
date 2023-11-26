% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função Massa de Probabilidade (PMF) para a distribuição geométrica
function pmf = calcularGeometricaPMF(p, x)
    x = x(:);
    pmf = p * ((1 - p).^(x - 1));
    pmf = (x > 0) .* (x == floor(x)) .* pmf;
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) para a distribuição geométrica
function cdf = calcularGeometricaCDF(p, x)
    x = (x(:) >= 1) .* floor(x(:));
    cdf = 1 - ((1 - p).^x);
end

% Função para gerar variáveis aleatórias seguindo a distribuição geométrica
function x = gerarGeometricaRV(p, m)
    r = rand(m, 1);
    x = ceil(log(1 - r) / log(1 - p));
end

% Entrada: solicita a probabilidade p (entre 0 e 1)
p = input('Digite a probabilidade p (entre 0 e 1): ');

% Lê os valores do arquivo 'entrada.txt'
fid = fopen('entrada.txt', 'r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcula os valores da PMF e CDF para a distribuição geométrica
valores_pmf = calcularGeometricaPMF(p, x);
valores_cdf = calcularGeometricaCDF(p, x);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de barras da PMF
bar(x, valores_pmf, 'b', 'LineWidth', 1.5);
title('Distribuição Geométrica - Função Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
xticks(x);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(x, valores_cdf, 'r', 'LineWidth', 1.5);
title('Distribuição Geométrica - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
xticks(x);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

