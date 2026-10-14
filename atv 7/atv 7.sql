-- ============================================================
-- AUTOTECHNOLOGY EXPRESS
-- Banco de dados: oficina_mecanica_db
-- SGBD: Microsoft SQL Server (SSMS)
-- ============================================================

-- 1. CRIAR O BANCO DE DADOS
IF DB_ID(N'oficina_mecanica_db') IS NULL
BEGIN
    CREATE DATABASE oficina_mecanica_db;
END;
GO

USE oficina_mecanica_db;
GO

-- ============================================================
-- 2. CRIAR A TABELA CLIENTES
-- ============================================================

CREATE TABLE dbo.Clientes (
    id_cliente INT IDENTITY(1,1) NOT NULL,
    nome NVARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    rua NVARCHAR(150) NULL,
    numero VARCHAR(10) NULL,
    bairro NVARCHAR(100) NULL,
    cidade NVARCHAR(100) NOT NULL,
    estado CHAR(2) NULL,
    cep VARCHAR(10) NULL,

    CONSTRAINT PK_Clientes
        PRIMARY KEY (id_cliente),

    CONSTRAINT UQ_Clientes_CPF
        UNIQUE (cpf),

    CONSTRAINT UQ_Clientes_Email
        UNIQUE (email)
);
GO

-- ============================================================
-- 3. CRIAR A TABELA MECANICOS
-- ============================================================

CREATE TABLE dbo.Mecanicos (
    id_mecanico INT IDENTITY(1,1) NOT NULL,
    nome NVARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL,
    data_contratacao DATE NOT NULL,
    funcao NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Mecanicos
        PRIMARY KEY (id_mecanico),

    CONSTRAINT UQ_Mecanicos_CPF
        UNIQUE (cpf),

    CONSTRAINT UQ_Mecanicos_Email
        UNIQUE (email)
);
GO

-- ============================================================
-- 4. CRIAR A TABELA VEICULOS
-- ============================================================

CREATE TABLE dbo.Veiculos (
    id_veiculo INT IDENTITY(1,1) NOT NULL,
    id_cliente INT NOT NULL,
    placa VARCHAR(7) NOT NULL,
    marca NVARCHAR(50) NOT NULL,
    modelo NVARCHAR(50) NOT NULL,
    ano_fabricacao SMALLINT NOT NULL,
    chassi VARCHAR(30) NOT NULL,

    CONSTRAINT PK_Veiculos
        PRIMARY KEY (id_veiculo),

    CONSTRAINT UQ_Veiculos_Placa
        UNIQUE (placa),

    CONSTRAINT UQ_Veiculos_Chassi
        UNIQUE (chassi),

    CONSTRAINT FK_Veiculos_Clientes
        FOREIGN KEY (id_cliente)
        REFERENCES dbo.Clientes(id_cliente)
);
GO

-- ============================================================
-- 5. CRIAR A TABELA ORDENS DE SERVICO
-- ============================================================

CREATE TABLE dbo.OrdensServico (
    id_ordem INT IDENTITY(1,1) NOT NULL,
    id_veiculo INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_abertura DATETIME2(0) NOT NULL,
    estimativa_entrega DATETIME2(0) NOT NULL,
    descricao NVARCHAR(500) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_OrdensServico
        PRIMARY KEY (id_ordem),

    CONSTRAINT FK_OrdensServico_Veiculos
        FOREIGN KEY (id_veiculo)
        REFERENCES dbo.Veiculos(id_veiculo),

    CONSTRAINT FK_OrdensServico_Mecanicos
        FOREIGN KEY (id_mecanico)
        REFERENCES dbo.Mecanicos(id_mecanico)
);
GO

-- ============================================================
-- 6. INSERIR CLIENTES
-- ============================================================

INSERT INTO dbo.Clientes
    (nome, cpf, telefone, email, cidade)
VALUES
    (N'João da Silva', '123.456.789-00',
     '(14) 99876-1234', 'joao.silva@email.com', N'Botucatu');

SELECT * FROM dbo.Clientes;

INSERT INTO dbo.Clientes
    (nome, cpf, telefone, email, cidade)
VALUES
    (N'Mariana de Oliveira', '987.654.321-00',
     '(14) 99123-4567', 'mariana.oliveira@email.com', N'Pardinho');

SELECT * FROM dbo.Clientes;

INSERT INTO dbo.Clientes
    (nome, cpf, telefone, email, cidade)
VALUES
    (N'Carlos Menezes', '321.987.654-11',
     '(14) 99654-3210', 'carlos.mennezis@email.com', N'São Manuel');

SELECT * FROM dbo.Clientes;

INSERT INTO dbo.Clientes
    (nome, cpf, telefone, email, cidade)
VALUES
    (N'Ana Beatriz de Souza', '456.789.123-22',
     '(14) 99444-8899', 'ana.souza@email.com', N'Botucatu');

SELECT * FROM dbo.Clientes;

-- ============================================================
-- 7. INSERIR MECANICOS
-- ============================================================

INSERT INTO dbo.Mecanicos
    (nome, cpf, telefone, email, data_contratacao, funcao)
VALUES
    (N'Rafael dos Santos', '888.999.000-11',
     '(14) 99777-1234', 'rafael.santos@autotechnology.com',
     '2025-01-01', N'Mecânico Geral');

SELECT * FROM dbo.Mecanicos;

INSERT INTO dbo.Mecanicos
    (nome, cpf, telefone, email, data_contratacao, funcao)
VALUES
    (N'Luciana Fernandes', '777.888.999-22',
     '(14) 99666-4567', 'luciana.fernandes@autotechnology.com',
     '2025-06-15', N'Especialista em Freios');

SELECT * FROM dbo.Mecanicos;

INSERT INTO dbo.Mecanicos
    (nome, cpf, telefone, email, data_contratacao, funcao)
VALUES
    (N'Pedro Almeida', '666.777.888-33',
     '(14) 99555-7890', 'pedro.almeida@autotechnology.com',
     '2023-09-10', N'Eletricista Automotivo');

SELECT * FROM dbo.Mecanicos;

INSERT INTO dbo.Mecanicos
    (nome, cpf, telefone, email, data_contratacao, funcao)
VALUES
    (N'Carla Monteiro', '555.666.777-44',
     '(14) 99444-3210', 'carla.monteiro@autotechnology.com',
     '2024-06-01', N'Mecânica de Veículos Leves');

SELECT * FROM dbo.Mecanicos;

-- ============================================================
-- 8. INSERIR VEICULOS
-- Os IDs dos clientes são obtidos pelo CPF.
-- Não dependemos de IDs presumidos.
-- ============================================================

INSERT INTO dbo.Veiculos
    (id_cliente, placa, marca, modelo, ano_fabricacao, chassi)
SELECT id_cliente, 'ABC1A23', N'Fiat', N'Uno', 2015,
       '9BWZZZ377VT004251'
FROM dbo.Clientes
WHERE cpf = '123.456.789-00';

SELECT * FROM dbo.Veiculos;

INSERT INTO dbo.Veiculos
    (id_cliente, placa, marca, modelo, ano_fabricacao, chassi)
SELECT id_cliente, 'XYZ9Z99', N'Chevrolet', N'Onix', 2020,
       '9BG116GW04C400001'
FROM dbo.Clientes
WHERE cpf = '987.654.321-00';

SELECT * FROM dbo.Veiculos;

INSERT INTO dbo.Veiculos
    (id_cliente, placa, marca, modelo, ano_fabricacao, chassi)
SELECT id_cliente, 'JKL3D45', N'Toyota', N'Corolla', 2018,
       '8AJZZZ123J1234567'
FROM dbo.Clientes
WHERE cpf = '321.987.654-11';

SELECT * FROM dbo.Veiculos;

INSERT INTO dbo.Veiculos
    (id_cliente, placa, marca, modelo, ano_fabricacao, chassi)
SELECT id_cliente, 'QWE7E77', N'Honda', N'Fit', 2017,
       '93HGE8850EZ500123'
FROM dbo.Clientes
WHERE cpf = '456.789.123-22';

SELECT * FROM dbo.Veiculos;

-- ============================================================
-- 9. INSERIR ORDENS DE SERVICO
-- Os IDs são encontrados pelas placas e CPFs.
-- ============================================================

INSERT INTO dbo.OrdensServico
    (id_veiculo, id_mecanico, data_abertura,
     estimativa_entrega, descricao, valor_total, status)
SELECT
    v.id_veiculo,
    m.id_mecanico,
    '2025-09-20T08:30:00',
    '2025-09-21T08:30:00',
    N'Troca de óleo e filtro',
    150.00,
    'Concluída'
FROM dbo.Veiculos v
JOIN dbo.Clientes c ON c.id_cliente = v.id_cliente
JOIN dbo.Mecanicos m ON m.cpf = '888.999.000-11'
WHERE v.placa = 'ABC1A23'
  AND c.cpf = '123.456.789-00';

SELECT * FROM dbo.OrdensServico;

INSERT INTO dbo.OrdensServico
    (id_veiculo, id_mecanico, data_abertura,
     estimativa_entrega, descricao, valor_total, status)
SELECT
    v.id_veiculo,
    m.id_mecanico,
    '2025-09-21T10:00:00',
    '2025-09-23T10:00:00',
    N'Substituição de pastilhas de freio dianteiras',
    300.00,
    'Em Andamento'
FROM dbo.Veiculos v
JOIN dbo.Clientes c ON c.id_cliente = v.id_cliente
JOIN dbo.Mecanicos m ON m.cpf = '777.888.999-22'
WHERE v.placa = 'XYZ9Z99'
  AND c.cpf = '987.654.321-00';

SELECT * FROM dbo.OrdensServico;

INSERT INTO dbo.OrdensServico
    (id_veiculo, id_mecanico, data_abertura,
     estimativa_entrega, descricao, valor_total, status)
SELECT
    v.id_veiculo,
    m.id_mecanico,
    '2025-09-22T14:15:00',
    '2025-09-23T08:00:00',
    N'Diagnóstico de falha no sistema elétrico',
    120.00,
    'Aberta'
FROM dbo.Veiculos v
JOIN dbo.Clientes c ON c.id_cliente = v.id_cliente
JOIN dbo.Mecanicos m ON m.cpf = '666.777.888-33'
WHERE v.placa = 'JKL3D45'
  AND c.cpf = '321.987.654-11';

SELECT * FROM dbo.OrdensServico;

INSERT INTO dbo.OrdensServico
    (id_veiculo, id_mecanico, data_abertura,
     estimativa_entrega, descricao, valor_total, status)
SELECT
    v.id_veiculo,
    m.id_mecanico,
    '2025-09-23T09:45:00',
    '2025-09-24T09:45:00',
    N'Alinhamento e balanceamento',
    100.00,
    'Cancelada'
FROM dbo.Veiculos v
JOIN dbo.Clientes c ON c.id_cliente = v.id_cliente
JOIN dbo.Mecanicos m ON m.cpf = '555.666.777-44'
WHERE v.placa = 'QWE7E77'
  AND c.cpf = '456.789.123-22';

SELECT * FROM dbo.OrdensServico;

-- ============================================================
-- 10. ATUALIZAR O MODELO DO VEICULO
-- Placa QWE7E77: Fit -> Civic
-- ============================================================

UPDATE dbo.Veiculos
SET modelo = N'Civic'
WHERE placa = 'QWE7E77';

SELECT * FROM dbo.Veiculos;

-- ============================================================
-- 11. ATUALIZAR O EMAIL DE CARLOS MENEZES
-- ============================================================

UPDATE dbo.Clientes
SET email = 'carlos.menezes@email.com'
WHERE cpf = '321.987.654-11';

SELECT * FROM dbo.Clientes;

-- ============================================================
-- 12. EXCLUIR A ORDEM DE SERVICO CANCELADA
-- Veículo de placa QWE7E77
-- ============================================================

DELETE FROM dbo.OrdensServico
WHERE id_veiculo = (
    SELECT id_veiculo
    FROM dbo.Veiculos
    WHERE placa = 'QWE7E77'
);

SELECT * FROM dbo.OrdensServico;

-- ============================================================
-- 13. CONSULTA FINAL DE TODAS AS TABELAS
-- ============================================================

SELECT * FROM dbo.Clientes;
SELECT * FROM dbo.Veiculos;
SELECT * FROM dbo.Mecanicos;
SELECT * FROM dbo.OrdensServico;

-- ============================================================
-- 14. CONSULTA RELACIONAL COMPLETA
-- Exibe cliente, veículo, mecânico e ordem de serviço.
-- ============================================================

SELECT
    os.id_ordem,
    c.nome AS cliente,
    v.placa,
    v.marca,
    v.modelo,
    m.nome AS mecanico_responsavel,
    os.data_abertura,
    os.estimativa_entrega,
    os.descricao,
    os.valor_total,
    os.status
FROM dbo.OrdensServico os
INNER JOIN dbo.Veiculos v
    ON v.id_veiculo = os.id_veiculo
INNER JOIN dbo.Clientes c
    ON c.id_cliente = v.id_cliente
INNER JOIN dbo.Mecanicos m
    ON m.id_mecanico = os.id_mecanico
ORDER BY os.id_ordem;
GO
