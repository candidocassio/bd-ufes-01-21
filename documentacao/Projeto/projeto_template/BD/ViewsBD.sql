-- VIEWS 
USE `pizzaria`;

-- Lista os ingredientes disponiveis em estoque
CREATE OR REPLACE VIEW ingredientesDisponiveis AS (
	SELECT DISTINCT
		descricao, e.id_ingrediente
	FROM 
		Estoque e
	JOIN 
		Ingrediente i
	ON i.id_ingrediente = e.id_ingrediente
	WHERE e.id_estoque IS NOT NULL
);

-- Lista os produtos disponíveis em estoque
CREATE OR REPLACE VIEW produtosDisponiveis AS (
	SELECT DISTINCT 
		descricao, e.id_produto
	FROM 
		Estoque e
	JOIN 
		Produto p
	ON e.id_produto = p.id_produto
	WHERE id_estoque IS NOT NULL
);


-- Mostra a quantidade total dos produtos no estoque
CREATE OR REPLACE VIEW quant_produtos_estoque AS
	SELECT
		p.id_produto,
		COALESCE(SUM(e.quantidade), 0) AS quant_em_estoque
	FROM 
		Estoque e
	RIGHT JOIN produto p
		ON p.id_produto = e.id_produto
	GROUP BY p.id_produto;

-- Mostra a quantidade total de ingredientes no estoque
CREATE OR REPLACE VIEW quant_ingredientes_estoque AS
	SELECT
		i.id_ingrediente,
		COALESCE(SUM(e.quantidade), 0) AS quant_em_estoque
	FROM 
		Estoque e
	RIGHT JOIN ingrediente i
		ON i.id_ingrediente = e.id_ingrediente
	GROUP BY i.id_ingrediente;

-- Pedidos com status a fazer
CREATE OR REPLACE VIEW pedidos_afazer AS
	SELECT*
	FROM 
		Pedido
	WHERE STATUS = 3;

-- Retorna o faturamento do dia até o momento
CREATE OR REPLACE VIEW faturamento_dia AS
	SELECT
		sum(p.valor_total) AS faturamento
	FROM 
		Pedido p
	WHERE p.data = curdate() AND p.status = 1;
