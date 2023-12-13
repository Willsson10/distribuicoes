clear
clc

% Função para calcular a PDF da distribuição gaussiana
function f = pdfGaussiano(media, desvioPadrao, x)
  f = exp(-(x - media).^2 / (2 * desvioPadrao^2)) / sqrt(2 * pi * desvioPadrao^2);
end

% Função para calcular a CDF da distribuição gaussiana
function F = cdfGaussiano(media, desvioPadrao, x)
  F = 0.5 * (1 + erf((x - media) / (desvioPadrao * sqrt(2))));
end

% Função para gerar amostras da distribuição gaussiana
function amostras = amostraGaussiano(media, desvioPadrao, m)
  amostras = media + (desvioPadrao * randn(m, 1));
end

% Entrada de dados:
limiteInferior = input('Digite o limite inferior: '); % Limite inferior da distribuição
limiteSuperior = input('Digite o limite superior: '); % Limite superior da distribuição
media = input('Informe o parâmetro mu (inteiro positivo): ');
desvioPadrao = input('Informe a probabilidade sigma (entre 0 e 1): ');
%x = amostraGaussiano(media, desvioPadrao, m);
x = limiteInferior : 0.1 : limiteSuperior;

% Leitura de dados de um arquivo
fid = fopen('entrada.txt','r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcular PDF e CDF
valores_pdf = pdfGaussiano(media, desvioPadrao, x);
valores_cdf = cdfGaussiano(media, desvioPadrao, x);

% Saída:
% Gráfico da PDF Gaussiana
subplot(2,1,1);
plot(x, valores_pdf, 'LineWidth', 2);
title('Gauss PDF');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
%xticks(x);
grid on;

% Gráfico da CDF Gaussiana
subplot(2,1,2);
plot(x, valores_cdf, 'LineWidth', 2);
title('Gauss CDF');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
%xticks(x);
grid on;

