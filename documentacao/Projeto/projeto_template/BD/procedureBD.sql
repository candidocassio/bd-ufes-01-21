-- PROCEDURE 

--Procedure 
DELIMITER //
CREATE PROCEDURE SP_INSERE_ESTOQUE (IN quantidade INT, IN validade DATE, IN tipo INT, IN id INT)
BEGIN
    IF (tipo = 1) THEN
		INSERT INTO Estoque(quantidade,data_validade,id_ingrediente,id_produto) VALUES(quantidade,validade,null,id);
	ELSE  INSERT INTO Estoque(quantidade,data_validade,id_ingrediente,id_produto) VALUES(quantidade,validade,id,null);
END IF;
END //
DELIMITER ;


--Procedure 
DELIMITER $
-- STORED PROCEDURES
CREATE PROCEDURE insere_produto_pedido(
	IN id_produto INT,
    IN id_pedido INT)
BEGIN 
	DECLARE fim INT DEFAULT FALSE;
	DECLARE quant FLOAT;    
    DECLARE ingr INT;    	
    DECLARE validade_mais_proxima DATE;
    DECLARE cursorQuant CURSOR FOR
		SELECT 
			id_ingrediente,
			quantidade
		FROM Produto_Ingrediente pi
		WHERE id_produto = pi.id_produto;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;
	IF ((id_produto IN (SELECT id_produto FROM produto)) AND (id_pedido IN (SELECT id_pedido FROM pedido))) THEN    
	INSERT INTO Item_Pedido VALUES (id_produto,id_pedido);
    IF (id_produto IN (SELECT pi.id_produto FROM Produto_Ingrediente pi)) THEN		
			OPEN cursorQuant;
            loopQuant: LOOP	
			FETCH cursorQuant INTO ingr,quant;
			IF fim THEN
				LEAVE loopQuant; 
			END IF;           
            IF (quant <= (SELECT quant_em_estoque FROM quant_ingredientes_estoque qie WHERE qie.id_ingrediente = ingr)) THEN
				SET validade_mais_proxima = (SELECT MIN(data_validade) FROM Estoque e WHERE (e.id_ingrediente = ingr AND data_validade > curdate()));
				UPDATE Estoque es
					SET es.quantidade = es.quantidade - quant
				WHERE	
					es.data_validade = validade_mais_proxima AND es.id_ingrediente = ingr;                    
			END IF; 
            END LOOP;		
	ELSE
		IF ((SELECT quant_em_estoque FROM quant_produtos_estoque qpe WHERE id_produto = qpe.id_produto) > 0) THEN
			SET validade_mais_proxima = (SELECT MIN(data_validade) FROM Estoque e WHERE e.id_produto = id_produto AND data_validade > curdate());
			UPDATE Estoque es 
				SET es.quantidade = es.quantidade - 1
			WHERE 
				es.data_validade = validade_mais_proxima AND id_produto = es.id_produto;		
		END IF;
	END	IF;
    END IF;
END $