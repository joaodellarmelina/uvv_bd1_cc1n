DROP USER IF EXISTS 'joaodellarmelina'@'%'; 
CREATE USER 'joaodellarmelina'@'%' IDENTIFIED BY '12345678';
GRANT ALL PRIVILEGES ON *.* to 'joaodellarmelina'@'%';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS uvv;
CREATE DATABASE uvv;

\u uvv 'joaodellarmelina'@'%' password '12345678'

CREATE TABLE produtos (
                produto_id NUMERIC(38)       NOT NULL,
                nome VARCHAR(255)  NOT NULL,
                preco_unitario  NUMERIC(10,2),
                detalhes LONGBLOB,
                imagem LONGBLOB,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizao DATE,
                PRIMARY KEY (produto_id)
);

ALTER TABLE produtos COMMENT 'Todos os produtos disponiveis.';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Identificação do produto.';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT 'Descrição do nome do produto.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço da unidade de cada produto.';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT 'Detalhes do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT 'Imagem do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT 'Extensão do arquivo.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT 'Tipo arquivo imagem.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT 'Parâmetro de codificação de caracteres.';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizao DATE COMMENT 'Data da ultima atualização da imagem do produto.';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude DECIMAL(8,6),
                longitude DECIMAL(9,6),
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas COMMENT 'Tabela conterá todos os dados das lojas.';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Identificação da loja.';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT 'Coluna descreverá o Nome da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT 'URL do site da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT 'Endereço de localização da loja.';

ALTER TABLE lojas MODIFY COLUMN latitude DECIMAL(8, 6) COMMENT 'Latitude para localização da loja.';

ALTER TABLE lojas MODIFY COLUMN longitude DECIMAL(9, 6) COMMENT 'Longitude para localização da loja.';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT 'Logo da loja.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT 'Extensão no qual a logo está inserida.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT 'Tipo de arquivo no qual a logo está inserida.';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT 'Parâmetro de codificação caracteres.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT 'Data da última atualização da logo.';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques COMMENT 'Constará a quantidade de produtos disponiveis nas lojas.';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT 'Identificação do estoque.';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Identificação da loja.';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Identificação do produto.';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade de produtos em estoque.';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT 'Tabela destinada a armazenar todos os dados dos clientes.';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Coluna para fazer a identificação dos clientes.';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT 'Coluna para Email de contato dos clientes.';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT 'Coluna para descrever o nome dos clientes.';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT 'Armazenará o telefone de contato numéro 1 dos clientes.';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT 'Armazenará o telefone de contato numéro 2 dos clientes.';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT 'Armazenará o telefone de contato numéro 3 dos clientes.';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios COMMENT 'Entidade fraca com todos os envios de pedidos feitos.';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Identificação de envio.';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Identificação da loja.';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Coluna para fazer a identificação dos clientes.';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT 'Endereço para qual o envio está sendo feito.';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT 'Status do envio.';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora DATETIME NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos COMMENT 'Tabela que irá conter todos os pedidos feitos por clientes';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Identificação dos pedidos.';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT 'Armazenará a data e hora que o pedido foi efetuado.';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT 'Coluna para fazer a identificação dos clientes.';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT 'Status do pedido efetuado.';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT 'Identificação da loja.';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens COMMENT 'Tabela Criar para constar todos os itens pedidos pelos clientes.';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT 'Identificação do pedido efetuado.';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT 'Identificação do produto.';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT 'Número do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT 'Preço unitario do produto do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT 'Quantidade de itens do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT 'Identificação de envio.';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques__fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques__fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;