/* 
   ##############################################################
   ####        PROJETO PARA SOLUÇÃO DO PROBLEM SET 1         ####
   ####                                                      ####
   ####               JOAO VITOR DELLARMELINA                ####
   ##############################################################
*/
/* 
    ##############################################################
    #                   ABRAÇOS, ABRANTES!                       #
    ##############################################################
*/

-- Caso já exista um Banco de dados chamado 'uvv' irá exclui-ló;
DROP DATABASE IF EXISTS uvv;

-- Caso já exista um usuário chamado 'joaodellarmelina' irá exclui-ló;
DROP ROLE IF EXISTS joaodellarmelina;

-- Criação de um usuário chamado 'joaodellarmelina' com permissões e uma senha encriptografada;
CREATE ROLE joaodellarmelina WITH CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'computacao@raiz';

-- Criação de um Banco de Dados chamado 'uvv';
CREATE DATABASE uvv WITH OWNER joaodellarmelina;

-- Comentario do Banco de Dados 'uvv';
COMMENT ON DATABASE uvv is 'Banco de Dados criado para gerenciar e armazenar dados referente a lojas na uvv';

-- Acessando o Banco de dados 'uvv' com o usuário 'joaodellarmelina' com a senha;
\c "dbname=uvv user= joaodellarmelina password= computacao@raiz"

-- Criação de um esquema chamado 'lojas';
CREATE SCHEMA lojas;

-- Comentario do esquema 'lojas';
COMMENT ON SCHEMA lojas is 'Esquema criado para "organizar" as tabelas do BD uvv';

-- Configurando o usuário 'joaodellarmelina' para ter definido o esquema criado.
ALTER USER joaodellarmelina SET search_path TO lojas;



--    ######## CRIAÇÕES DE TABELAS ########


/*
1. CRIAÇÃO DA TABELA produtos.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

-- 2.

COMMENT ON TABLE lojas.produtos IS 'Todos os produtos disponiveis.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Identificação do produto.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Descrição do nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço da unidade de cada produto.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes do produto.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Extensão do arquivo.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Tipo arquivo imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Parâmetro de codificação de caracteres.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizao IS 'Data da ultima atualização da imagem do produto.';

/*
1. CRIAÇÃO DA TABELA lojas.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC(8,6),
                longitude NUMERIC(9,6),
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id),
                CONSTRAINT informe_um_endereço CHECK (endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL)
);

-- 2.

COMMENT ON TABLE lojas.lojas IS 'Tabela conterá todos os dados das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificação da loja.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna descreverá o Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'URL do site da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço de localização da loja.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude para localização da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude para localização da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Extensão no qual a logo está inserida.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Tipo de arquivo no qual a logo está inserida.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Parâmetro de codificação caracteres.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo.';

/*
1. CRIAÇÃO DA TABELA estoques.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);

-- 2.

COMMENT ON TABLE lojas.estoques IS 'Constará a quantidade de produtos disponiveis nas lojas.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Identificação do estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identificação da loja.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identificação do produto.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade de produtos em estoque.';

/*
1. CRIAÇÃO DA TABELA clientes.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id),
                CONSTRAINT informe_telefones_diferentes UNIQUE (telefone1, telefone2, telefone3)
);

-- 2.

COMMENT ON TABLE lojas.clientes IS 'Tabela destinada a armazenar todos os dados dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna para fazer a identificação dos clientes.';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna para Email de contato dos clientes.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Coluna para descrever o nome dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Armazenará o telefone de contato numéro 1 dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Armazenará o telefone de contato numéro 2 dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Armazenará o telefone de contato numéro 3 dos clientes.';

/*
1. CRIAÇÃO DA TABELA envios.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id),
                CONSTRAINT status_informado_inválido CHECK (status in ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))
); 

-- 2.

COMMENT ON TABLE lojas.envios IS 'Entidade fraca com todos os envios de pedidos feitos.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Identificação de envio.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Identificação da loja.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Coluna para fazer a identificação dos clientes.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço para qual o envio está sendo feito.';
COMMENT ON COLUMN lojas.envios.status IS 'Status do envio.';

/*
1. CRIAÇÃO DA TABELA pedidos.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id),
                CONSTRAINT status_informado_inválido CHECK (status in ('CANCELADO' , 'COMPLETO' ,'ABERTO' ,'PAGO' , 'REEMBOLSADO' ,'ENVIADO'))
);

-- 2.

COMMENT ON TABLE lojas.pedidos IS 'Tabela que irá conter todos os pedidos feitos por clientes';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Identificação dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Armazenará a data e hora que o pedido foi efetuado.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna para fazer a identificação dos clientes.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status do pedido efetuado.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identificação da loja.';

/*
1. CRIAÇÃO DA TABELA pedidos_itens.
2. COMENTARIOS DA TABELA E COLUNAS
*/

-- 1.

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedido_id PRIMARY KEY (pedido_id, produto_id),
                CONSTRAINT informe_valor_positivo CHECK (preco_unitario > 0)
                
);

-- 2.

COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela criada para constar todos os itens pedidos pelos clientes.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Identificação do pedido efetuado.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Identificação do produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Número do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitario do produto do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade de itens do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Identificação de envio.';

-- ####################### ####################### ####################### ####################### #######################

-- Definindo as foreign key (FK) da tabela *pedidos*

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Definindo as foreign key (FK) da tabela *envios*

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Definindo as foreign key (FK) da tabela *estoques* 

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques__fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques__fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Definindo as foreign key (FK) da tabela *pedidos_itens* 

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


