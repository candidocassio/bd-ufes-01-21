DROP DATABASE IF EXISTS `pizzaria`;
CREATE DATABASE `pizzaria`;
USE `pizzaria`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE IF NOT EXISTS Fornecedor (
    id_fornecedor INT AUTO_INCREMENT NOT NULL,
    razao_social VARCHAR(90) NOT NULL,
    nome_fantasia VARCHAR(45) NOT NULL,    
    rua VARCHAR(45) NOT NULL,
    numero INT NOT NULL,
    cep VARCHAR(9) NOT NULL,
    cnpj VARCHAR(18) NOT NULL,
    telefone VARCHAR(14) NOT NULL,
    email VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_fornecedor)
);

CREATE TABLE IF NOT EXISTS Produto (
    id_produto  INT AUTO_INCREMENT NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    preco DECIMAL NOT NULL,
    PRIMARY KEY (id_produto)
);


CREATE TABLE IF NOT EXISTS Funcionario (
    id_funcionario  INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(45) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_admissao DATE NOT NULL,
    conta_salario VARCHAR(13) NOT NULL,
    numero_carteira VARCHAR(7) NOT NULL,
    rua VARCHAR(45) NOT NULL,
    cep VARCHAR(9) NOT NULL,
    numero INT NOT NULL,
    cargo INT NOT NULL,
    PRIMARY KEY (id_funcionario)
);

CREATE TABLE IF NOT EXISTS Pedido (
    id_pedido  INT AUTO_INCREMENT NOT NULL,
    valor_total FLOAT NOT NULL,
    data DATE NOT NULL,
    status INT NOT NULL,
    id_funcionario INT NOT NULL,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario (id_funcionario)
);

CREATE TABLE IF NOT EXISTS Item_Pedido (
    id_produto INT NOT NULL,
    id_pedido INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto (id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido (id_pedido)
);


CREATE TABLE IF NOT EXISTS Ingrediente (
    id_ingrediente  INT AUTO_INCREMENT NOT NULL,
    descricao VARCHAR(45) NOT NULL,
    perecibilidade INT NOT NULL,
    PRIMARY KEY (id_ingrediente)
);

CREATE TABLE IF NOT EXISTS Estoque (
    id_estoque  INT AUTO_INCREMENT NOT NULL,
    quantidade FLOAT NOT NULL,
    data_validade DATE NOT NULL,
    id_ingrediente INT,
    id_produto INT,
    PRIMARY KEY (id_estoque),
    FOREIGN KEY (id_produto) REFERENCES Produto (id_produto),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente (id_ingrediente)
);

CREATE TABLE IF NOT EXISTS Fornecedor_Estoque(
    id_fornecedor INT NOT NULL,
    id_estoque INT NOT NULL,
    data_entrega DATE NOT NULL,
    quantidade_entrega DECIMAL NOT NULL,
    PRIMARY KEY (id_fornecedor, id_estoque),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor (id_fornecedor),
    FOREIGN KEY (id_estoque) REFERENCES Estoque (id_estoque)
);

CREATE TABLE IF NOT EXISTS Produto_Ingrediente (
	id_produto INT NOT NULL,
    id_ingrediente INT NOT NULL,   
    quantidade FLOAT NOT NULL, 
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente (id_ingrediente),
    FOREIGN KEY (id_produto) REFERENCES Produto (id_produto)
);

