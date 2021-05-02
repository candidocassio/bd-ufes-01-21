--TRIGGER

--Trigger para gerar o valor total do pedido, a cada pedido adicionado ao pedido, o preço do pedido é somado ao valor total.

DELIMITER $
CREATE TRIGGER Tgr_Item_Pedido AFTER INSERT
ON Item_Pedido
FOR EACH ROW 
BEGIN
	UPDATE  Pedido pe
		SET valor_total = valor_total + (SELECT p.preco FROM Produto P WHERE NEW.id_produto = p.id_produto)
	WHERE pe.id_pedido = NEW.id_pedido;	
END $
DELIMITER ;


DELIMITER $
CREATE TRIGGER tgr_estoque_negativo
AFTER UPDATE ON Estoque
FOR EACH ROW
BEGIN
	DECLARE validade_mais_proxima DATE;
    IF NEW.quantidade < 0 THEN
		IF NEW.id_produto IS NOT NULL THEN
			SET validade_mais_proxima = (SELECT MIN(data_validade) FROM Estoque e WHERE e.id_produto = NEW.id_produto) AND NEW.quantidade > 0;
			UPDATE Estoque e SET e.quantidade = e.quantidade - NEW.quantidade WHERE e.data_validade = validade_mais_proxima AND e.id_produto = NEW.id_produto;
			UPDATE Estoque e SET e.quantidade = 0 WHERE e.data_validade = NEW.data_validade AND e.id_produto = NEW.id_produto;
		ELSE
			SET validade_mais_proxima = (SELECT MIN(data_validade) FROM Estoque e WHERE e.id_ingrediente = NEW.id_ingrediente) AND NEW.quantidade > 0;
			UPDATE Estoque e SET e.quantidade = e.quantidade - NEW.quantidade WHERE e.data_validade = validade_mais_proxima AND e.id_produto = NEW.id_ingrediente;
            UPDATE Estoque e SET e.quantidade = 0 WHERE e.data_validade = NEW.data_validade AND e.id_produto = NEW.id_ingrediente;
		END IF;
    END IF;
END $