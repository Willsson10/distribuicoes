% Limpa a tela e o workspace
clc
clear

% Função para calcular a Função de Distribuição Cumulativa (CDF) para uma distribuição finita
function cdf = calcularCDF(s, p, x)
    cdf = zeros(size(x));
    for i = 1:length(x)
        cdf(i) = sum(p(s <= x(i)));
    end
end

% Função para calcular o coeficiente de correlação (rho) para uma distribuição finita
function rho = calcularCoeficienteCorrelacao(SX, SY, PXY)
    ex = sum(SX .* PXY);
    vx = sum((SX - ex).^2 .* PXY);
    ey = sum(SY .* PXY);
    vy = sum((SY - ey).^2 .* PXY);
    R = sum(SX .* SY .* PXY);
    rho = (R - ex * ey) / sqrt(vx * vy);
end

% Função para calcular a covariância para uma distribuição finita
function covxy = calcularCovariancia(SX, SY, PXY)
    ex = sum(SX .* PXY);
    ey = sum(SY .* PXY);
    R = sum(SX .* SY .* PXY);
    covxy = R - ex * ey;
end

% Função para calcular a esperança (média) para uma distribuição finita
function ex = calcularEsperanca(sx, px)
    ex = sum(sx .* px);
end

% Função para calcular a Função Massa de Probabilidade (PMF) para uma distribuição finita
function pmf = calcularPMF(sx, px, x)
    pmf = zeros(size(x(:)));
    for i = 1:length(x)
        pmf(i) = sum(px(sx == x(i)));
    end
end

% Função para gerar variáveis aleatórias para uma distribuição finita
function x_values = gerarVariaveisAleatorias(s, p, m)
    r = rand(m, 1);
    x_values = zeros(m, 1);
    for i = 1:m
        for j = 1:length(s)
            if r(i) <= sum(p(1:j))
                x_values(i) = s(j);
                break;
            end
        end
    end
end

% Função para calcular a variância para uma distribuição finita
function v = calcularVariancia(sx, px)
    ex2 = sum(sx.^2 .* px);
    ex = sum(sx .* px);
    v = ex2 - (ex^2);
end

% Entrada: solicita o número de amostras ao usuário
m = input('Digite o numero de amostras: ');

% Lê os valores do arquivo 'entrada.txt'
fileID = fopen('entrada.txt', 'r');
sx = fscanf(fileID, '%d');
fclose(fileID);

% Lê os valores do arquivo 'probabilidade.txt'
fileID = fopen('probabilidade.txt', 'r');
px = fscanf(fileID, '%f');
fclose(fileID);

% Gera variáveis aleatórias seguindo a distribuição finita
x_values = gerarVariaveisAleatorias(sx, px, m);
pmf = calcularPMF(sx, px, sx);
cdf = calcularCDF(sx, px, sx);

% Plotagem:
figure;

% Subplotagem para a PMF
subplot(2, 1, 1);
% Gráfico de barras da PMF
bar(sx, pmf, 'b', 'LineWidth', 1.5);
title('Distribuição Finita - Função Massa de Probabilidade (PMF)');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
set(gca, 'xtick', sx);
grid on;

% Subplotagem para a CDF
subplot(2, 1, 2);
% Gráfico de degrau (stairs) para a CDF
stairs(sx, cdf, 'r', 'LineWidth', 1.5);
title('Distribuição Finita - Função de Distribuição Cumulativa (CDF)');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
set(gca, 'xtick', sx);
grid on;

% Adiciona uma legenda para a CDF
legend('CDF');

