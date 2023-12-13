clear
clc

% Função para calcular a PDF da distribuição Erlang
function f = pdfErlang(n, lambda, x)
    f = ((lambda^n) / factorial(n)) .* (x.^(n-1)) .* exp(-lambda*x);
end

% Função para calcular a CDF da distribuição Erlang
function F = cdfErlang(n, lambda, x)
    F = 1 - gammainc(x * lambda, n, 'upper');
end

% Função para gerar amostras da distribuição Erlang
function x = amostraErlang(n, lambda, m)
    y = amostraExponencial(lambda, m*n);
    x = sum(reshape(y, m, n), 2);
end

% Entrada de dados:
limiteInferior = input('Digite o limite inferior: '); % Limite inferior da distribuição
limiteSuperior = input('Digite o limite superior: '); % Limite superior da distribuição
parametroN = input('Informe o parâmetro n (inteiro positivo): ');
parametroLambda = input('Informe lambda (entre 0 e 1): ');
%numeroAmostras = input('Informe o número de amostras (m): ');
%x = amostraErlang(parametroN, parametroLambda, numeroAmostras);
x = limiteInferior : 0.1 : limiteSuperior;

% Leitura de dados de um arquivo
fid = fopen('entrada.txt','r');
x = fscanf(fid, '%d');
fclose(fid);

% Calcular PDF e CDF
valores_pdf = pdfErlang(parametroN, parametroLambda, x);
valores_cdf = cdfErlang(parametroN, parametroLambda, x);

% Saída:
% Gráfico da PDF da Erlang
subplot(2, 1, 1);
plot(x, valores_pdf, 'LineWidth', 2);
title('PDF da Erlang');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
%xticks(x);
grid on;

% Gráfico da CDF da Erlang
subplot(2, 1, 2);
plot(x, valores_cdf, 'LineWidth', 2);
title('CDF da Erlang');
xlabel('X');
ylabel('Probabilidade acumulada');
ylim([0, 1.5]);
%xticks(x);
grid on;

