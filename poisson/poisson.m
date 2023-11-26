% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função Massa de Probabilidade (PMF) para a distribuição de Poisson
function pmf = calcularPoissonPMF(alpha, x)
    x = x(:);
    pmf = exp(-alpha) * (alpha.^x) ./ factorial(x);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) para a distribuição de Poisson
function cdf = calcularPoissonCDF(pmf, x)
    x = floor(x(:));
    cdf = cumsum(pmf);
    cdf = cdf(min(end, x + 1));
end

% Função para gerar variáveis aleatórias seguindo a distribuição de Poisson
function x = gerarPoissonRV(alpha, m)
    r = rand(m, 1);
    x_max = ceil(2 * alpha);
    sx = 0:x_max;
    pmf = calcularPoissonPMF(alpha, sx);
    cdf = calcularPoissonCDF(pmf, sx);

    [~, x] = max(cdf >= r);
end

% Entrada: solicita o parâmetro alpha para a distribuição de Poisson
alpha = input('Informe o parâmetro alpha para a distribuição de Poisson: ');

% Lê os valores do arquivo 'entrada.txt'
fid = fopen('entrada.txt', 'r');
valores_x = fscanf(fid, '%d');
fclose(fid);

% Calcula os valores da PMF e CDF para a distribuição de Poisson
valores_pmf = calcularPoissonPMF(alpha, valores_x);
valores_cdf = calcularPoissonCDF(valores_pmf, valores_x);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de haste (stem) para a PMF
stem(valores_x, valores_pmf, 'b', 'LineWidth', 2, 'Marker', 'o');
title('Distribuição de Poisson - Função Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
xticks(valores_x);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Suaviza a CDF usando a função plot com interpolação linear
plot(valores_x, valores_cdf, 'ro-', 'LineWidth', 2, 'MarkerSize', 5);
hold on;

% Remove valores duplicados
[valores_x_unique, idx_unique] = unique(valores_x);
valores_cdf_unique = valores_cdf(idx_unique);

x_smooth = linspace(min(valores_x_unique), max(valores_x_unique), 1000);
cdf_smooth = interp1(valores_x_unique, valores_cdf_unique, x_smooth, 'linear', 'extrap');
plot(x_smooth, cdf_smooth, 'b-', 'LineWidth', 2);
title('Distribuição de Poisson - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1]);
xticks(valores_x_unique);
grid on;

