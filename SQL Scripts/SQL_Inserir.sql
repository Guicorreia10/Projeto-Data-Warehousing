-- =============================================================
-- SCRIPT: DW_TechLusa_Lab 
-- =============================================================

-- 1. BASE DE DADOS
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DW_TechLusa_Lab')
BEGIN
    CREATE DATABASE DW_TechLusa_Lab;
END
GO

USE DW_TechLusa_Lab;
GO

-- 2. LIMPEZA TOTAL (Eliminar tabelas antigas para recriar sem erros)
IF OBJECT_ID('Facto_Vendas', 'U') IS NOT NULL DROP TABLE Facto_Vendas;
IF OBJECT_ID('Dim_Produto', 'U') IS NOT NULL DROP TABLE Dim_Produto;
IF OBJECT_ID('Dim_Cliente', 'U') IS NOT NULL DROP TABLE Dim_Cliente;
IF OBJECT_ID('Dim_Localizacao', 'U') IS NOT NULL DROP TABLE Dim_Localizacao;
IF OBJECT_ID('Dim_Tempo', 'U') IS NOT NULL DROP TABLE Dim_Tempo;
GO

-- 3. CRIAÇÃO DAS TABELAS

-- 3.1. Dimensão Tempo (Estrutura Completa/Rica)
CREATE TABLE Dim_Tempo (
    SK_Tempo INT PRIMARY KEY,           -- Formato: YYYYMMDD
    Data DATE,
    Ano SMALLINT,
    Mes SMALLINT,
    Dia SMALLINT,
    Dia_Semana SMALLINT,
    Dia_Ano SMALLINT,
    Ano_Bissexto CHAR(1),
    Dia_Util CHAR(1),
    Fim_Semana CHAR(1),
    Feriado CHAR(1),
    Pre_Feriado CHAR(1),
    Pos_Feriado CHAR(1),
    Nome_Feriado VARCHAR(30),
    Nome_Dia_Semana VARCHAR(15),
    Nome_Dia_Semana_Abrev CHAR(3),
    Nome_Mes VARCHAR(15),
    Nome_Mes_Abrev CHAR(3),
    Quinzena SMALLINT,
    Bimestre SMALLINT,
    Trimestre SMALLINT,
    Semestre SMALLINT,
    Nr_Semana_Mes SMALLINT,
    Nr_Semana_Ano SMALLINT,
    Estacao_Ano VARCHAR(15),
    Data_Por_Extenso VARCHAR(100)
);

-- 3.2. Outras Dimensões
CREATE TABLE Dim_Produto (
    SK_Produto INT IDENTITY(1,1) PRIMARY KEY,
    Nome_Produto VARCHAR(100),
    Categoria VARCHAR(50),
    Custo DECIMAL(10,2)
);

CREATE TABLE Dim_Cliente (
    SK_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nome_Cliente VARCHAR(100),
    Segmento VARCHAR(50),
    Pais VARCHAR(50)
);

CREATE TABLE Dim_Localizacao (
    SK_Localizacao INT IDENTITY(1,1) PRIMARY KEY,
    Cidade VARCHAR(50),
    Distrito VARCHAR(50) 
);

-- 3.3. Tabela de Factos
CREATE TABLE Facto_Vendas (
    SK_Venda INT IDENTITY(1,1) PRIMARY KEY,
    SK_Produto INT FOREIGN KEY REFERENCES Dim_Produto(SK_Produto),
    SK_Cliente INT FOREIGN KEY REFERENCES Dim_Cliente(SK_Cliente),
    SK_Localizacao INT FOREIGN KEY REFERENCES Dim_Localizacao(SK_Localizacao),
    SK_Tempo INT FOREIGN KEY REFERENCES Dim_Tempo(SK_Tempo),
    Quantidade INT,
    Valor_Total DECIMAL(10,2)
);
GO

-- 4. POVOAR AS DIMENSÕES

-- 4.1. Produtos
INSERT INTO Dim_Produto (Nome_Produto, Categoria, Custo) VALUES
('Portátil Gaming X', 'Informática', 800.00),
('Rato Wireless', 'Acessórios', 15.00),
('Monitor 24"', 'Periféricos', 120.00),
('Teclado Mecânico', 'Acessórios', 45.00),
('Impressora Laser', 'Escritório', 200.00),
('Tablet Pro 11"', 'Informática', 450.00),
('Desktop All-in-One', 'Informática', 900.00),
('Servidor Rack 1U', 'Informática', 1200.00),
('Headset Gamer 7.1', 'Acessórios', 65.00),
('Webcam HD 1080p', 'Acessórios', 40.00),
('Tapete Rato XXL', 'Acessórios', 12.00),
('Suporte Portátil', 'Acessórios', 25.00),
('Monitor Curvo 27"', 'Periféricos', 250.00),
('Monitor Ultrawide 34"', 'Periféricos', 400.00),
('Projetor LED 4K', 'Periféricos', 600.00),
('Cadeira Ergonómica', 'Escritório', 150.00),
('Secretária Ajustável', 'Escritório', 220.00),
('Destruidora de Papel', 'Escritório', 35.00),
('SSD NVMe 1TB', 'Componentes', 85.00),
('Placa Gráfica RTX 4060', 'Componentes', 350.00),
('Memória RAM 16GB DDR4', 'Componentes', 50.00),
('Fonte Alimentação 750W', 'Componentes', 75.00),
('Router Wi-Fi 6', 'Redes', 110.00),
('Switch 8 Portas', 'Redes', 30.00),
('Cabo Rede 5m CAT6', 'Redes', 8.00);

-- 4.2. Clientes
INSERT INTO Dim_Cliente (Nome_Cliente, Segmento, Pais) VALUES
('Ana Silva', 'Particular', 'Portugal'),
('Rui Santos', 'Particular', 'Portugal'),
('Carlos Ferreira', 'Particular', 'Portugal'),
('Sofia Martins', 'Particular', 'Portugal'),
('Pedro Oliveira', 'Particular', 'Portugal'),
('Marta Costa', 'Particular', 'Portugal'),
('Inovação Digital SA', 'Corporate', 'Portugal'),
('Banco do Atlântico', 'Corporate', 'Portugal'),
('Consultoria Financeira Lda', 'Corporate', 'Portugal'),
('Tech Solutions Lda', 'Corporate', 'Portugal'),
('Electro Norte', 'Retalho', 'Portugal'),
('Supermercado Central', 'Retalho', 'Portugal'),
('PC World Lisboa', 'Retalho', 'Portugal'),
('Loja do Bairro', 'Retalho', 'Portugal'),
('Tienda Madrid SL', 'Retalho', 'Espanha'),
('Global Trade SL', 'Corporate', 'Espanha'),
('Jean Pierre', 'Particular', 'França'),
('Tech Berlin GmbH', 'Corporate', 'Alemanha'),
('London Electronics Ltd', 'Corporate', 'Reino Unido'),
('João Pereira', 'Particular', 'Brasil');

-- 4.3. Localizações (Expandida)
INSERT INTO Dim_Localizacao (Cidade, Distrito) VALUES
('Viana do Castelo', 'Viana do Castelo'),('Ponte de Lima', 'Viana do Castelo'),('Arcos de Valdevez', 'Viana do Castelo'),
('Braga', 'Braga'),('Guimarães', 'Braga'),('Vila Nova de Famalicão', 'Braga'),('Barcelos', 'Braga'),
('Vila Real', 'Vila Real'),('Chaves', 'Vila Real'),('Peso da Régua', 'Vila Real'),
('Bragança', 'Bragança'),('Mirandela', 'Bragança'),
('Porto', 'Porto'),('Vila Nova de Gaia', 'Porto'),('Matosinhos', 'Porto'),('Maia', 'Porto'),('Póvoa de Varzim', 'Porto'),
('Aveiro', 'Aveiro'),('Santa Maria da Feira', 'Aveiro'),('Ovar', 'Aveiro'),('Ílhavo', 'Aveiro'),
('Viseu', 'Viseu'),('Lamego', 'Viseu'),('Tondela', 'Viseu'),
('Guarda', 'Guarda'),('Seia', 'Guarda'),
('Coimbra', 'Coimbra'),('Figueira da Foz', 'Coimbra'),('Cantanhede', 'Coimbra'),
('Castelo Branco', 'Castelo Branco'),('Covilhã', 'Castelo Branco'),('Fundão', 'Castelo Branco'),
('Leiria', 'Leiria'),('Caldas da Rainha', 'Leiria'),('Pombal', 'Leiria'),('Nazaré', 'Leiria'),
('Lisboa', 'Lisboa'),('Sintra', 'Lisboa'),('Cascais', 'Lisboa'),('Loures', 'Lisboa'),('Amadora', 'Lisboa'),('Oeiras', 'Lisboa'),
('Santarém', 'Santarém'),('Tomar', 'Santarém'),('Torres Novas', 'Santarém'),
('Setúbal', 'Setúbal'),('Almada', 'Setúbal'),('Seixal', 'Setúbal'),('Barreiro', 'Setúbal'),
('Portalegre', 'Portalegre'),('Elvas', 'Portalegre'),
('Évora', 'Évora'),('Estremoz', 'Évora'),('Montemor-o-Novo', 'Évora'),
('Beja', 'Beja'),('Moura', 'Beja'),('Odemira', 'Beja'),
('Faro', 'Faro'),('Portimão', 'Faro'),('Loulé', 'Faro'),('Albufeira', 'Faro'),('Lagos', 'Faro'),
('Funchal', 'Madeira'),('Santa Cruz', 'Madeira'),
('Ponta Delgada', 'Açores'),('Angra do Heroísmo', 'Açores');

-- 4.4. Dimensão Tempo (Lógica Complexa para 2024)
DECLARE @dataInicial date, @dataFinal date, @data date, 
    @ano smallint, @mes smallint, @dia smallint, 
    @diaSemana smallint, @diaUtil char(1), @fimSemana char(1), 
    @feriado char(1), @preFeriado char(1), @posFeriado char(1), 
    @nomeFeriado varchar(30), @nomeDiaSemana varchar(15), 
    @nomeDiaSemanaAbrev char(3), @nomeMes varchar(15), 
    @nomeMesAbrev char(3), @bimestre smallint, @trimestre smallint, 
    @nrSemanaMes smallint, @estacaoAno varchar(15)

SET @dataInicial = '2024-01-01'
SET @dataFinal = '2024-12-31'
SET LANGUAGE Portuguese; -- Garante os nomes em PT

WHILE @dataInicial <= @dataFinal
BEGIN
    SET @data = @dataInicial
    SET @ano = year(@data)
    SET @mes = month(@data)
    SET @dia = day(@data)
    SET @diaSemana = datepart(weekday,@data)

    IF @diaSemana in (1,7) SET @fimSemana = 'S' ELSE SET @fimSemana = 'N'

    -- Feriados de Portugal
    SET @nomeFeriado = NULL
    IF (@mes = 1 and @dia = 1) SET @nomeFeriado = 'Ano Novo'
    ELSE IF (@mes = 4 and @dia = 25) SET @nomeFeriado = 'Dia da Liberdade'
    ELSE IF (@mes = 5 and @dia = 1) SET @nomeFeriado = 'Dia do Trabalhador'
    ELSE IF (@mes = 6 and @dia = 10) SET @nomeFeriado = 'Dia de Portugal'
    ELSE IF (@mes = 8 and @dia = 15) SET @nomeFeriado = 'Assunção N. Sra.'
    ELSE IF (@mes = 10 and @dia = 5) SET @nomeFeriado = 'Implantação República'
    ELSE IF (@mes = 11 and @dia = 1) SET @nomeFeriado = 'Todos os Santos'
    ELSE IF (@mes = 12 and @dia = 1) SET @nomeFeriado = 'Restauração'
    ELSE IF (@mes = 12 and @dia = 8) SET @nomeFeriado = 'Imaculada Conceição'
    ELSE IF (@mes = 12 and @dia = 25) SET @nomeFeriado = 'Natal'

    IF @nomeFeriado IS NOT NULL SET @feriado = 'S' ELSE SET @feriado = 'N'
    
    -- Pré e Pós Feriado (Simplificado)
    SET @preFeriado = 'N'
    SET @posFeriado = 'N'

    -- Nomes
    SET @nomeMes = DATENAME(MONTH, @data)
    SET @nomeMesAbrev = LEFT(@nomeMes, 3)
    SET @nomeDiaSemana = DATENAME(WEEKDAY, @data)
    SET @nomeDiaSemanaAbrev = LEFT(@nomeDiaSemana, 3)

    IF @fimSemana = 'S' OR @feriado = 'S' SET @diaUtil = 'N' ELSE SET @diaUtil = 'S'

    -- Trimestres e Semestres
    SET @bimestre = CASE WHEN @mes IN (1,2) THEN 1 WHEN @mes IN (3,4) THEN 2 WHEN @mes IN (5,6) THEN 3 WHEN @mes IN (7,8) THEN 4 WHEN @mes IN (9,10) THEN 5 ELSE 6 END
    SET @trimestre = DATEPART(QUARTER, @data)
    SET @nrSemanaMes = (DATEPART(WEEK, @data) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0,@data), 0)) + 1)

    -- Estações do Ano
    IF @data between cast(cast(@ano as varchar) + '-09-23' as date) and cast(cast(@ano as varchar) + '-12-20' as date) SET @estacaoAno = 'Outono'
    ELSE IF @data between cast(cast(@ano as varchar) + '-03-21' as date) and cast(cast(@ano as varchar) + '-06-20' as date) SET @estacaoAno = 'Primavera'
    ELSE IF @data between cast(cast(@ano as varchar) + '-06-21' as date) and cast(cast(@ano as varchar) + '-09-22' as date) SET @estacaoAno = 'Verão'
    ELSE SET @estacaoAno = 'Inverno'

    INSERT INTO Dim_Tempo VALUES (
        CAST(FORMAT(@data, 'yyyyMMdd') AS INT),
        @data, @ano, @mes, @dia, @diaSemana, datepart(dayofyear,@data),
        case when (@ano % 4) = 0 then 'S' else 'N' end,
        @diaUtil, @fimSemana, @feriado, @preFeriado, @posFeriado,
        @nomeFeriado, @nomeDiaSemana, @nomeDiaSemanaAbrev, @nomeMes, @nomeMesAbrev,
        case when @dia < 16 then 1 else 2 end, @bimestre, @trimestre,
        case when @mes < 7 then 1 else 2 end, @nrSemanaMes, datepart(week,@data),
        @estacaoAno,
        lower(@nomeDiaSemana + ', ' + cast(@dia as varchar) + ' de ' + @nomeMes + ' de ' + cast(@ano as varchar))
    );
    SET @dataInicial = dateadd(day,1,@dataInicial) 
END
GO

-- 5. GERAR VENDAS (4000 Registos - Utilizando a nova Dim_Tempo)
DECLARE @k INT = 0;
WHILE @k < 4000
BEGIN
    DECLARE @RandProd INT = (SELECT TOP 1 SK_Produto FROM Dim_Produto ORDER BY NEWID());
    DECLARE @RandCli INT = (SELECT TOP 1 SK_Cliente FROM Dim_Cliente ORDER BY NEWID());
    DECLARE @RandLoc INT = (SELECT TOP 1 SK_Localizacao FROM Dim_Localizacao ORDER BY NEWID());
    
    -- Agora escolhemos uma data aleatória da NOVA tabela rica
    DECLARE @RandTempo INT = (SELECT TOP 1 SK_Tempo FROM Dim_Tempo ORDER BY NEWID());
    
    DECLARE @Qtd INT = ABS(CHECKSUM(NEWID()) % 10) + 1; 
    DECLARE @Custo DECIMAL(10,2) = (SELECT Custo FROM Dim_Produto WHERE SK_Produto = @RandProd);
    DECLARE @Margem DECIMAL(10,2) = 1.1 + (ABS(CHECKSUM(NEWID()) % 4) * 0.1); 
    DECLARE @Total DECIMAL(10,2) = @Qtd * (@Custo * @Margem);

    INSERT INTO Facto_Vendas (SK_Produto, SK_Cliente, SK_Localizacao, SK_Tempo, Quantidade, Valor_Total)
    VALUES (@RandProd, @RandCli, @RandLoc, @RandTempo, @Qtd, @Total);

    SET @k = @k + 1;
END;
GO

-- 6. VERIFICAÇÃO FINAL
SELECT 
    (SELECT COUNT(*) FROM Dim_Produto) AS 'Total Produtos',
    (SELECT COUNT(*) FROM Dim_Localizacao) AS 'Total Cidades',
    (SELECT COUNT(*) FROM Dim_Cliente) AS 'Total Clientes',
    (SELECT COUNT(*) FROM Dim_Tempo) AS 'Dias em 2024 (366)',
    (SELECT COUNT(*) FROM Facto_Vendas) AS 'Vendas Geradas',
    SUM(Valor_Total) AS 'Faturacao_Total_Simulada'
FROM Facto_Vendas;



--Indices
USE DW_TechLusa_Lab;
GO

-- Índice para agilizar a procura por Produto (Questão 1)
CREATE NONCLUSTERED INDEX IX_Facto_Produto 
ON Facto_Vendas(SK_Produto);

-- Índice para agilizar a procura Temporal e Sazonal (Questão 2)
CREATE NONCLUSTERED INDEX IX_Facto_Tempo 
ON Facto_Vendas(SK_Tempo) INCLUDE (Valor_Total);

-- Índice para agilizar a procura por Cliente (Questão 3)
CREATE NONCLUSTERED INDEX IX_Facto_Cliente 
ON Facto_Vendas(SK_Cliente);

-- Índice para agilizar a procura Geográfica (Questão 4)
CREATE NONCLUSTERED INDEX IX_Facto_Localizacao 
ON Facto_Vendas(SK_Localizacao);
GO



--rollup
-- Resposta à Análise Temporal com ROLLUP
SELECT 
    ISNULL(dt.Estacao_Ano, 'TOTAL GERAL') AS Estacao,
    ISNULL(dt.Nome_Mes, 'Subtotal Estação') AS Mes,
    SUM(fv.Valor_Total) AS Faturacao,
    COUNT(*) AS Nr_Vendas
FROM Facto_Vendas fv
JOIN Dim_Tempo dt ON fv.SK_Tempo = dt.SK_Tempo
GROUP BY ROLLUP(dt.Estacao_Ano, dt.Nome_Mes);

--cubos
-- Resposta à Análise Geográfica/Produto com CUBE
SELECT 
    ISNULL(dl.Distrito, 'TODOS OS DISTRITOS') AS Distrito,
    ISNULL(dp.Categoria, 'TODAS AS CATEGORIAS') AS Categoria,
    SUM(fv.Valor_Total) AS Vendas_Totais
FROM Facto_Vendas fv
JOIN Dim_Localizacao dl ON fv.SK_Localizacao = dl.SK_Localizacao
JOIN Dim_Produto dp ON fv.SK_Produto = dp.SK_Produto
GROUP BY CUBE(dl.Distrito, dp.Categoria);

-- Resposta à Análise de Cliente com CTE e Ranking
WITH VendasPorCliente AS (
    SELECT 
        dc.Nome_Cliente,
        dc.Segmento,
        SUM(fv.Valor_Total) AS Total_Gasto
    FROM Facto_Vendas fv
    JOIN Dim_Cliente dc ON fv.SK_Cliente = dc.SK_Cliente
    GROUP BY dc.Nome_Cliente, dc.Segmento
),
RankingClientes AS (
    SELECT 
        Nome_Cliente,
        Segmento,
        Total_Gasto,
        DENSE_RANK() OVER (ORDER BY Total_Gasto DESC) AS Posicao
    FROM VendasPorCliente
)
SELECT * FROM RankingClientes
WHERE Posicao <= 3;



-- Resposta Integrada às Questões 1 (Produto) e 3 (Cliente) com GROUPING SETS
-- Objetivo: Obter totais independentes por Segmento e Categoria numa única passagem
SELECT 
    ISNULL(dc.Segmento, 'AGREGADO GERAL') AS Segmento_Cliente,
    ISNULL(dp.Categoria, 'AGREGADO GERAL') AS Categoria_Produto,
    SUM(fv.Valor_Total) AS Vendas_Totais
FROM Facto_Vendas fv
JOIN Dim_Cliente dc ON fv.SK_Cliente = dc.SK_Cliente
JOIN Dim_Produto dp ON fv.SK_Produto = dp.SK_Produto
GROUP BY GROUPING SETS (
    (dc.Segmento),  -- Totaliza por Segmento (Responde à Q3)
    (dp.Categoria), -- Totaliza por Categoria (Responde à Q1)
    ()              -- Total Geral (Grand Total)
);

-- "A Visão 360º": Análise Integrada de Todas as Dimensões (Geografia, Cliente, Produto, Tempo)
-- Objetivo: Obter uma síntese executiva completa numa única execução otimizada

SELECT 
    CASE 
        WHEN dl.Distrito IS NOT NULL THEN 'Geografia'
        WHEN dc.Segmento IS NOT NULL THEN 'Cliente'
        WHEN dp.Categoria IS NOT NULL THEN 'Produto'
        WHEN dt.Estacao_Ano IS NOT NULL THEN 'Sazonalidade'
        ELSE 'TOTAL GLOBAL' 
    END AS Eixo_Analise,
    
    COALESCE(dl.Distrito, dc.Segmento, dp.Categoria, dt.Estacao_Ano, '---') AS Dimensao,
    
    SUM(fv.Valor_Total) AS Vendas_Totais,
    COUNT(*) AS Nr_Transacoes,  -- CORREÇÃO: Usa COUNT(*) para contar as linhas
    CAST(AVG(fv.Valor_Total) AS DECIMAL(10,2)) AS Ticket_Medio

FROM Facto_Vendas fv
JOIN Dim_Localizacao dl ON fv.SK_Localizacao = dl.SK_Localizacao
JOIN Dim_Cliente dc ON fv.SK_Cliente = dc.SK_Cliente
JOIN Dim_Produto dp ON fv.SK_Produto = dp.SK_Produto
JOIN Dim_Tempo dt ON fv.SK_Tempo = dt.SK_Tempo

GROUP BY GROUPING SETS (
    (dl.Distrito),      -- Agrega por Distrito (Q4)
    (dc.Segmento),      -- Agrega por Segmento (Q3)
    (dp.Categoria),     -- Agrega por Categoria (Q1)
    (dt.Estacao_Ano),   -- Agrega por Estação (Q2)
    ()                  -- Total Geral
)
ORDER BY Eixo_Analise, Vendas_Totais DESC;