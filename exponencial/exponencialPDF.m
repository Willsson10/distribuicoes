clear
clc

% Função para calcular a PDF da distribuição exponencial
function f = pdfExponencial(taxa, x)
  f = taxa * exp(-taxa * x);
  f = f .* (x >= 0); % Garante que a PDF seja zero para valores negativos de x
end

% Função para calcular a CDF da distribuição exponencial
function F = cdfExponencial(taxa, x)
  F = 1.0 - exp(-taxa * x);
end

% Função para gerar amostras da distribuição exponencial
function amostras = amostraExponencial(taxa, m)
  amostras = -(1/taxa) * log(1 - rand(m, 1));
end

% Entrada de dados:
limiteInferior = input('Digite o limite inferior: '); % Limite inferior da distribuição
limiteSuperior = input('Digite o limite superior: '); % Limite superior da distribuição
taxaChegada = input('Digite a taxa de chegada lambda (entre 0 e 1): ');
%numeroAmostras = input('Digite o numero de amostras: ');
%x = amostraExponencial(taxaChegada, numeroAmostras);
x = limiteInferior : 0.1 : limiteSuperior;

% Leitura de dados de um arquivo
fid = fopen('entrada.txt','r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcular PDF e CDF
pdfExponencial = pdfExponencial(taxaChegada, x);
cdfExponencial = cdfExponencial(taxaChegada, x);

% Saída:
% Gráfico da PDF Exponencial
subplot(2,1,1);
plot(x, pdfExponencial, 'LineWidth', 2);
title('Exponencial PDF');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
%xticks(x);
grid on;

% Gráfico da CDF Exponencial
subplot(2,1,2);
plot(x, cdfExponencial, 'LineWidth', 2);
title('Exponencial CDF');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
%xticks(x);
grid on;

