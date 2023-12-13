clear
clc

% Função para calcular a PDF da distribuição uniforme
function f = distribuicaoUniformePDF(inferior, superior, valores)
  % Uso: f = distribuicaoUniformePDF(inferior, superior, valores)
  % Retorna a PDF de uma variável aleatória uniforme contínua avaliada em valores
  f = ((valores >= inferior) & (valores < superior)) / (superior - inferior);
end

% Função para calcular a CDF da distribuição uniforme
function F = distribuicaoUniformeCDF(inferior, superior, valores)
  % Uso: F = distribuicaoUniformeCDF(inferior, superior, valores)
  % Retorna a CDF de uma variável aleatória uniforme contínua avaliada em valores
  F = valores .* ((valores >= inferior) & (valores < superior)) / (superior - inferior);
  F = F + 1.0 * (valores >= superior);
  F(F > 1) = 1; % Garante que a CDF não ultrapasse 1
end

% Função para gerar amostras da distribuição uniforme
function amostras = amostrasDistribuicaoUniforme(inferior, superior, quantidade)
  % Uso: amostras = amostrasDistribuicaoUniforme(inferior, superior, quantidade)
  % Retorna uma quantidade de amostras de uma variável aleatória uniforme no intervalo (inferior, superior)
  amostras = inferior + (superior - inferior) * rand(quantidade, 1);
end

% Entrada de dados:
limiteInferior = input('Digite o limite inferior: '); % Limite inferior da distribuição
limiteSuperior = input('Digite o limite superior: '); % Limite superior da distribuição
%quantidadeAmostras = input('Digite o numero de amostras: ');
%x = amostrasDistribuicaoUniforme(limiteInferior, limiteSuperior, quantidadeAmostras);
x = limiteInferior : 0.1 : limiteSuperior;

fid = fopen('entrada.txt','r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcular PDF e CDF
valoresPDF = distribuicaoUniformePDF(limiteInferior, limiteSuperior, x);
valoresCDF = distribuicaoUniformeCDF(limiteInferior, limiteSuperior, x);

% Saída:
% Gráfico da PDF Uniforme
subplot(2, 1, 1);
plot(x, valoresPDF, 'LineWidth', 2);
title('Uniforme PDF');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
%xticks(x);
grid on;

% Gráfico da CDF Uniforme
subplot(2, 1, 2);
plot(x, valoresCDF, 'LineWidth', 2);
title('Uniforme CDF');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
%xticks(x);
grid on;

