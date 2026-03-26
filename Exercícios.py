# Usando Python faça: 
# 1. Ler o arquivo CSV
# 2. Criar coluna faturamento = quantidade * preco_unitario
# 3. Agrupar faturamento por produto
# 4. Agrupar faturamento por categoria
# 5. Agrupar faturamento por cliente
# 6. Criar gráfico de faturamento por categoria
# 7. Exportar arquivo resumo_vendas.csv 

#%% 
# Ações em Python:

# 1. Ler o arquivo CSV
import pandas as pd
vendas = pd.read_csv('vendas.csv')
print(vendas.head())

# 2. Criar coluna faturamento = quantidade * preco_unitario
vendas['faturamento'] = vendas['quantidade'] * vendas['preco_unitario']
print(vendas.head())

# 3. Agrupar faturamento por produto
faturamento_produto = vendas.groupby('produto')['faturamento'].sum()
print(faturamento_produto)

# 4. Agrupar faturamento por categoria
faturamento_categoria = vendas.groupby('categoria')['faturamento'].sum()
print(faturamento_categoria)

# 5. Agrupar faturamento por cliente
faturamento_cliente = vendas.groupby('cliente')['faturamento'].sum()
print(faturamento_cliente)

# 6. Criar gráfico de faturamento por categoria
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

faturamento_categoria.plot(kind='bar')
plt.title('Faturamento por Categoria')
plt.xlabel('Categoria')
plt.ylabel('Faturamento')

plt.gca().yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, pos: f'R$ {x/1000000:.1f}M'))

plt.show()

# 7. Exportar arquivo resumo_vendas.csv (adicionei as colunas de vendedor e data para facilitar análises futuras)
resumo_vendas = vendas.groupby(['produto', 'categoria', 'cliente', 'vendedor', 'data_venda'])['faturamento'].sum().reset_index()
resumo_vendas.to_csv('resumo_vendas.csv', index=False)
print("Arquivo resumo_vendas.csv exportado com sucesso!")


