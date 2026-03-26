// Usando SQL:
1. Qual o faturamento total por produto?
2. Qual o faturamento total por categoria?
3. Qual o ticket médio por cliente?
4. Qual o faturamento total por vendedor?
5. Qual o faturamento por mês?
6. Quais são os 5 produtos mais vendidos?
7. Qual cidade possui maior faturamento?
8. Qual cliente mais comprou em valor? //

CREATE TABLE IF NOT EXISTS vendas (
    id_venda INTEGER PRIMARY KEY,
    data_venda TEXT,
    cliente TEXT,
    produto TEXT,
    categoria TEXT,
    quantidade INTEGER,
    preco_unitario REAL,
    vendedor TEXT,
    cidade TEXT,
    estado TEXT
);  

SELECT * FROM vendas LIMIT 10;

// 1. Qual é o faturamento total por produto? 

SELECT produto, SUM(quantidade * preco_unitario) as faturamento

FROM vendas

GROUP BY produto;

// 2. Qual o faturamento por categoria

SELECT categoria, SUM(quantidade * preco_unitario) as faturamento 
FROM vendas
GROUP BY categoria;

//3. Qual o ticket médio por cliente?

SELECT cliente, AVG(quantidade * preco_unitario) as ticket_medio
FROM vendas
GROUP BY cliente;

//4. Qual o faturamento total por vendedor?

SELECT vendedor, SUM(quantidade * preco_unitario) as faturamento
FROM vendas
GROUP BY vendedor;

//5. Qual o faturamento por mês?

SELECT strftime('%Y-%m', data_venda) as mes, SUM(quantidade * preco_unitario) as faturamento
FROM vendas
GROUP BY mes
ORDER BY mes;

//6. Quais são os 5 produtos mais vendidos?

SELECT produto, SUM(quantidade) as total_vendido
FROM vendas
GROUP BY produto
ORDER BY total_vendido DESC
LIMIT 5;

//7. Qual cidade possui maior faturamento?

SELECT cidade, SUM(quantidade * preco_unitario) as faturamento
FROM vendas
GROUP BY cidade
ORDER BY faturamento DESC
LIMIT 1;

//8. Qual cliente mais comprou em valor?

SELECT cliente, SUM(quantidade * preco_unitario) as total_comprado
FROM vendas
GROUP BY cliente
ORDER BY total_comprado DESC
LIMIT 1;


// Crie uma tabela chamada resumo_vendas com - produto - categoria - quantidade_total - faturamento_total (adicionei as colunas de vendedor e data para facilitar análises futuras)

CREATE TABLE IF NOT EXISTS resumo_vendas AS
SELECT produto, categoria, vendedor, data_venda, SUM(quantidade) as quantidade_total, SUM(quantidade * preco_unitario) as faturamento_total
FROM vendas
GROUP BY produto, categoria, vendedor, data_venda;
