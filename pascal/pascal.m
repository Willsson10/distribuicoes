% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função Massa de Probabilidade (PMF) para a distribuição Pascal
function pmf = calcularPascalPMF(k, p, x)
    x = x(:);
    n = max(x);
    i = (k:n-1)';
    ip = [1; (1 - p) * (i ./ (i + 1 - k))];
    pb = (p^k) * cumprod(ip);
    okx = (x == floor(x)) & (x >= k);
    x = (okx .* x) + k * (1 - okx);
    pmf = okx .* pb(x - k + 1);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) para a distribuição Pascal
function cdf = calcularPascalCDF(k, p, x)
    x = floor(x(:));
    allx = k:max(x);

    % Adiciona a verificação se allx está vazio
    if isempty(allx)
        cdf = zeros(size(x));
        return;
    end

    allcdf = cumsum(calcularPascalPMF(k, p, allx));
    okx = (x >= k);
    x = (okx .* x) + ((1 - okx) * k);

    % Interpolação linear para suavizar a CDF
    cdf = interp1(allx, allcdf, x, 'linear', 'extrap');
    cdf = okx .* cdf;
end

% Função para gerar variáveis aleatórias seguindo a distribuição Pascal
function x = gerarPascalRV(k, p, m)
    r = rand(m, 1);
    rmax = max(r);
    xmin = k;
    xmax = ceil(2 * (k / p));
    sx = xmin:xmax;
    cdf = calcularPascalCDF(k, p, sx);

    while cdf(end) <= rmax
        xmax = 2 * xmax;
        sx = xmin:xmax;
        cdf = calcularPascalCDF(k, p, sx);
    end

    x = xmin + sum(cdf <= r, 2);
end

% Entrada: solicita o parâmetro k (inteiro positivo) e a probabilidade p (entre 0 e 1)
k = input('Informe o parâmetro k (inteiro positivo): ');
p = input('Informe a probabilidade p (entre 0 e 1): ');

% Lê os valores do arquivo 'entrada.txt'
fid = fopen('entrada.txt', 'r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcula os valores da PMF e CDF para a distribuição Pascal
valores_pmf = calcularPascalPMF(k, p, x);
valores_cdf = calcularPascalCDF(k, p, x);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);

% Gráfico de barras da PMF usando a função stem
stem(x, valores_pmf, 'b', 'LineWidth', 1.5);
title('Distribuição Pascal - Função Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico suave da CDF usando a função plot
plot(x, valores_cdf, 'r', 'LineWidth', 1.5);
title('Distribuição Pascal - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
xticks(x);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

