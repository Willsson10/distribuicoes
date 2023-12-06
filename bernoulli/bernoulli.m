clear
clc

% Função para calcular a Função de Massa de Probabilidade (PMF) customizada
function prob_mass = custom_pmf(probability, values)
  prob_mass = (1 - probability) * (values == 0) + probability * (values == 1);
  prob_mass = prob_mass(:);
end

% Função para calcular a Função de Distribuição Cumulativa (CDF) customizada
function cum_dist = custom_cdf(pmf, values)
  cum_dist = cumsum(pmf);
  cum_dist(floor(values) > 1) = 1;
end

% Função para gerar amostras da variável aleatória customizada
function samples = generate_custom_samples(probability, num_samples)
  samples = rand(num_samples, 1) >= (1 - probability);
end

% Entrada de probabilidade
probability = input('Digite a probabilidade p (valores entre 0 e 1): ');

% Leitura do arquivo 'entrada.txt'
file_path = 'entrada.txt';  % Modifique o caminho conforme necessário
fid = fopen(file_path, 'r');

if fid == -1
    error(['Não foi possível abrir o arquivo: ' file_path]);
end

values = fscanf(fid, '%f');
fclose(fid);

% Cálculos
unique_values = unique(values);
pmf = custom_pmf(probability, unique_values);
cdf = custom_cdf(pmf, unique_values);

% Plotagem
figure;

% Subplotagem para a PMF
subplot(2,1,1);
bar(unique_values, pmf, 'FaceColor', 'b', 'EdgeColor', 'b');
title('Função de Massa de Probabilidade Customizada');
xlabel('X');
ylabel('Probabilidade');
ylim([0, 1]);
grid on;

% Subplotagem para a CDF
subplot(2,1,2);
stairs(unique_values, cdf, 'LineWidth', 2, 'Color', 'r');
title('Função de Distribuição Cumulativa Customizada');
xlabel('X');
ylabel('Probabilidade Acumulada');
ylim([0, 1.1]);
grid on;

% Adiciona um título geral
annotation('textbox', [0 0.9 1 0.1], 'String', ['Análise da Distribuição Customizada (p = ' num2str(probability) ')'], 'EdgeColor', 'none', 'HorizontalAlignment', 'center');

