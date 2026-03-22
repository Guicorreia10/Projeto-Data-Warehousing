ALTER DATABASE dw10_2526_estMercedes
ADD FILEGROUP FG_F; 

ALTER DATABASE dw10_2526_estMercedes
ADD FILEGROUP FG_G;

ALTER DATABASE dw10_2526_estMercedes
ADD FILEGROUP FG_H; 

ALTER DATABASE dw10_2526_estMercedes
ADD FILEGROUP FG_I;

ALTER DATABASE dw10_2526_estMercedes ADD FILE
	( NAME = dw10_2526_estMercedes_f,
	  FILENAME = 'f:\fgf\dw10_2526_estMercedes_f.ndf',
          SIZE = 1MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 1MB)
 TO FILEGROUP FG_F;
 
 ALTER DATABASE dw10_2526_estMercedes ADD FILE
	( NAME = dw10_2526_estMercedes_g,
	  FILENAME = 'g:\fgg\dw_EstMercedes_g.ndf',
          SIZE = 1MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 1MB)
 TO FILEGROUP FG_G;

ALTER DATABASE dw10_2526_estMercedes ADD FILE
	( NAME = dw10_2526_estMercedes_h,
	  FILENAME = 'h:\fgh\dw10_2526_estMercedes_h.ndf',
          SIZE = 1MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 1MB)
 TO FILEGROUP FG_H;

 ALTER DATABASE dw10_2526_estMercedes ADD FILE
	( NAME = dw10_2526_estMercedes_i,
	  FILENAME = 'i:\fgi\dw10_2526_estMercedes_i.ndf',
          SIZE = 1MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 1MB)
 TO FILEGROUP FG_I;

 CREATE PARTITION FUNCTION
partFuncPorIdCliente (int)
AS RANGE LEFT
FOR VALUES (100);

CREATE PARTITION SCHEME partSchemePorIdCliente
AS PARTITION partFuncPorIdCliente
TO (FG_H, FG_I);


create table dim_cliente(
id_cliente int not null,
nome_cliente varchar(50),
localidade varchar(30),
codpostal INT,
idade int,
sexo varchar(50),
estado_civil varchar(10),
) on fg_f;


create table dim_marca(
id_marca int not null,
nome_marca varchar(50)
) on fg_f;


CREATE TABLE dbo.DIM_TEMPO(
 ID_TEMPO int IDENTITY(1,1) NOT NULL,
 DATA date NOT NULL,
 ANO smallint NOT NULL,
 MES smallint NOT NULL,
 DIA smallint NOT NULL,
 DIA_SEMANA smallint NOT NULL,
 DIA_ANO smallint NOT NULL,
 ANO_BISSEXTO char(1) NOT NULL,
 DIA_UTIL char(1) NOT NULL,
 FIM_SEMANA char(1) NOT NULL,
 FERIADO char(1) NOT NULL,
 PRE_FERIADO char(1) NOT NULL,
 POS_FERIADO char(1) NOT NULL,
 NOME_FERIADO varchar(30) NULL,
 NOME_DIA_SEMANA varchar(15) NOT NULL,
 NOME_DIA_SEMANA_ABREV char(3) NOT NULL,
 NOME_MES varchar(15) NOT NULL,
 NOME_MES_ABREV char(3) NOT NULL,
 QUINZENA smallint NOT NULL,
 BIMESTRE smallint NOT NULL,
 TRIMESTRE smallint NOT NULL,
 SEMESTRE smallint NOT NULL,
 NR_SEMANA_MES smallint NOT NULL,
 NR_SEMANA_ANO smallint NOT NULL,
 ESTACAO_ANO varchar(15) NOT NULL,
 DATA_POR_EXTENSO varchar(50) NOT NULL,
 EVENTO varchar(50) NULL
 ) on fg_f;


alter table dim_cliente add constraint tb_dim_cliente 
primary key(id_cliente)
on fg_g;

alter table dim_marca add constraint tb_Dim_Marca_PK
primary key(id_marca)
on fg_g;

alter table dim_tempo add constraint tb_Dim_tempo_PK
primary key(id_tempo)
on fg_g;

create table tb_fatos(
id_tempo int,
id_cliente int,
id_marca int,
lucro decimal(8,2),
valor_retoma decimal(8,2)
)
ON partSchemePorIdCliente(id_cliente);


alter table tb_fatos add constraint tb_fatos_tempo_fk
foreign key(id_tempo) references dim_tempo;

alter table tb_fatos add constraint tb_fatos_cliente_fk
foreign key(id_cliente) references dim_cliente;

alter table tb_fatos add constraint tb_fatos_marca_fk
foreign key(id_marca) references dim_marca;

create table aux_nome (
id_aux_nome int,
nome varchar(15),
sexo varchar(15),
primary key (id_aux_nome))

create table aux_apelido (
id_aux_apelido int,
apelido varchar(15)
primary key (id_aux_apelido))

create table aux_localidade (
id_aux_localidade int,
localidade varchar(20),
codpostal int,
primary key (id_aux_localidade))

-- Inser??o dos registos auxiliares, nas tr?s tabelas anteriores

insert into aux_nome values(01,'?lvaro', 'M')
insert into aux_nome values(02,'?ngela', 'F')
insert into aux_nome values(03,'?ngelo', 'M')
insert into aux_nome values(04,'Adriana', 'F')
insert into aux_nome values(05,'Afonso', 'M')
insert into aux_nome values(06,'Alberto', 'M')
insert into aux_nome values(07,'Alexandra', 'F')
insert into aux_nome values(08,'Alexandre', 'M')
insert into aux_nome values(09,'Alfredo', 'M')
insert into aux_nome values(10,'Alice', 'F')
insert into aux_nome values(11,'Ana', 'F')
insert into aux_nome values(12,'Anabela', 'F')
insert into aux_nome values(13,'Andr?', 'M')
insert into aux_nome values(14,'Ant?nia', 'F')
insert into aux_nome values(15,'Ant?nio', 'M')
insert into aux_nome values(16,'Armando', 'M')
insert into aux_nome values(17,'Artur', 'M')
insert into aux_nome values(18,'Augusto', 'M')
insert into aux_nome values(19,'B?rbara', 'F')
insert into aux_nome values(20,'Bernardo', 'M')
insert into aux_nome values(21,'Bruna', 'F')
insert into aux_nome values(22,'Bruno', 'M')
insert into aux_nome values(23,'C?lia', 'F')
insert into aux_nome values(24,'C?sar', 'M')
insert into aux_nome values(25,'Camila', 'F')
insert into aux_nome values(26,'Carla', 'F')
insert into aux_nome values(27,'Carlos', 'M')
insert into aux_nome values(28,'Carolina', 'F')
insert into aux_nome values(29,'Catarina', 'F')
insert into aux_nome values(30,'Cec?lia', 'F')
insert into aux_nome values(31,'Cla?dia', 'F')
insert into aux_nome values(32,'Cla?dio', 'M')
insert into aux_nome values(33,'Clara', 'F')
insert into aux_nome values(34,'Cristiano', 'M')
insert into aux_nome values(35,'Cristina', 'F')
insert into aux_nome values(36,'D?rio', 'M')
insert into aux_nome values(37,'Daniel', 'M')
insert into aux_nome values(38,'Daniela', 'F')
insert into aux_nome values(39,'David', 'M')
insert into aux_nome values(40,'Diana', 'F')
insert into aux_nome values(41,'Diogo', 'M')
insert into aux_nome values(42,'Duarte', 'M')
insert into aux_nome values(43,'Dulce', 'F')
insert into aux_nome values(44,'Edgar', 'M')
insert into aux_nome values(45,'Eduarda', 'F')
insert into aux_nome values(46,'Eduardo', 'M')
insert into aux_nome values(47,'Elisa', 'F')
insert into aux_nome values(48,'Elsa', 'F')
insert into aux_nome values(49,'Emanuel', 'M')
insert into aux_nome values(50,'Emanuela', 'F')
insert into aux_nome values(51,'Eug?nia', 'F')
insert into aux_nome values(52,'Eug?nio', 'M')
insert into aux_nome values(53,'F?bio', 'M')
insert into aux_nome values(54,'F?tima', 'F')
insert into aux_nome values(55,'Fernanda', 'F')
insert into aux_nome values(56,'Fernando', 'M')
insert into aux_nome values(57,'Filipa', 'F')
insert into aux_nome values(58,'Filipe', 'M')
insert into aux_nome values(59,'Francisca', 'F')
insert into aux_nome values(60,'Francisco', 'M')
insert into aux_nome values(61,'Frederico', 'M')
insert into aux_nome values(62,'Gabriel', 'M')
insert into aux_nome values(63,'Gabriela', 'F')
insert into aux_nome values(64,'Gil', 'M')
insert into aux_nome values(65,'Gon?alo', 'M')
insert into aux_nome values(66,'Guilherme', 'M')
insert into aux_nome values(67,'Gustavo', 'M')
insert into aux_nome values(68,'H?lder', 'M')
insert into aux_nome values(69,'Helena', 'F')
insert into aux_nome values(70,'Hugo', 'M')
insert into aux_nome values(71,'In?s', 'F')
insert into aux_nome values(72,'Irene', 'F')
insert into aux_nome values(73,'Isabel', 'F')
insert into aux_nome values(74,'Jaime', 'M')
insert into aux_nome values(75,'Jo?o', 'M')
insert into aux_nome values(76,'Joana', 'F')
insert into aux_nome values(77,'Joaquim', 'M')
insert into aux_nome values(78,'Jorge', 'M')
insert into aux_nome values(79,'Jos?', 'M')
insert into aux_nome values(80,'Juliana', 'F')
insert into aux_nome values(81,'Lara', 'F')
insert into aux_nome values(82,'Laura', 'F')
insert into aux_nome values(83,'Leandro', 'M')
insert into aux_nome values(84,'Leonardo', 'M')
insert into aux_nome values(85,'Leonor', 'F')
insert into aux_nome values(86,'Louren?o', 'M')
insert into aux_nome values(87,'Lu?s', 'M')
insert into aux_nome values(88,'Lucas', 'M')
insert into aux_nome values(89,'Luisa', 'F')
insert into aux_nome values(90,'M?rcio', 'M')
insert into aux_nome values(91,'M?rio', 'M')
insert into aux_nome values(92,'M?nica', 'F')
insert into aux_nome values(93,'Mafalda', 'F')
insert into aux_nome values(94,'Manuel', 'M')
insert into aux_nome values(95,'Manuela', 'F')
insert into aux_nome values(96,'Marcelo', 'M')
insert into aux_nome values(97,'Marco', 'M')
insert into aux_nome values(98,'Marcos', 'M')
insert into aux_nome values(99,'Margarida', 'F')
insert into aux_nome values(100,'Maria', 'F')
insert into aux_nome values(101,'Mariana', 'F')
insert into aux_nome values(102,'Marina', 'F')
insert into aux_nome values(103,'Marta', 'F')
insert into aux_nome values(104,'Maur?cio', 'M')
insert into aux_nome values(105,'Miguel', 'M')
insert into aux_nome values(106,'Nat?lia', 'F')
insert into aux_nome values(107,'Nelson', 'M')
insert into aux_nome values(108,'No?mia', 'F')
insert into aux_nome values(109,'Nuno', 'M')
insert into aux_nome values(110,'Patr?cia', 'F')
insert into aux_nome values(111,'Paula', 'F')
insert into aux_nome values(112,'Paulo', 'M')
insert into aux_nome values(113,'Pedro', 'M')
insert into aux_nome values(114,'R?ben', 'M')
insert into aux_nome values(115,'Rafael', 'M')
insert into aux_nome values(116,'Raquel', 'F')
insert into aux_nome values(117,'Renato', 'M')
insert into aux_nome values(118,'Ricardo', 'M')
insert into aux_nome values(119,'Rita', 'F')
insert into aux_nome values(120,'Roberto', 'M')
insert into aux_nome values(121,'Rodrigo', 'M')
insert into aux_nome values(122,'Rog?rio', 'M')
insert into aux_nome values(123,'Rui', 'M')
insert into aux_nome values(124,'Rute', 'F')
insert into aux_nome values(125,'S?rgio', 'M')
insert into aux_nome values(126,'S?lvia', 'F')
insert into aux_nome values(127,'S?lvio', 'M')
insert into aux_nome values(128,'S?nia', 'F')
insert into aux_nome values(129,'Samuel', 'M')
insert into aux_nome values(130,'Sandra', 'F')
insert into aux_nome values(131,'Sandro', 'M')
insert into aux_nome values(132,'Sara', 'F')
insert into aux_nome values(133,'Simone', 'F')
insert into aux_nome values(134,'Sofia', 'F')
insert into aux_nome values(135,'Susana', 'F')
insert into aux_nome values(136,'Telmo', 'M')
insert into aux_nome values(137,'Teresa', 'F')
insert into aux_nome values(138,'Tiago', 'M')
insert into aux_nome values(139,'V?tor', 'M')
insert into aux_nome values(140,'Valter', 'M')
insert into aux_nome values(141,'Vanessa', 'F')
insert into aux_nome values(142,'Vasco', 'M')


insert into aux_apelido values(001,'?guas')
insert into aux_apelido values(002,'?vila')
insert into aux_apelido values(003,'Abrantes')
insert into aux_apelido values(004,'Abreu')
insert into aux_apelido values(005,'Afonso')
insert into aux_apelido values(006,'Agostinho')
insert into aux_apelido values(007,'Aguiar')
insert into aux_apelido values(008,'Albuquerque')
insert into aux_apelido values(009,'Alcobia')
insert into aux_apelido values(010,'Aldeia')
insert into aux_apelido values(011,'Aleixo')
insert into aux_apelido values(012,'Almeida')
insert into aux_apelido values(013,'Alonso')
insert into aux_apelido values(014,'Alves')
insert into aux_apelido values(015,'Amador')
insert into aux_apelido values(016,'Amaral')
insert into aux_apelido values(017,'Amaro')
insert into aux_apelido values(018,'Amorim')
insert into aux_apelido values(019,'Andrade')
insert into aux_apelido values(020,'Anjos')
insert into aux_apelido values(021,'Antunes')
insert into aux_apelido values(022,'Apar?cio')
insert into aux_apelido values(023,'Ara?jo')
insert into aux_apelido values(024,'Arruda')
insert into aux_apelido values(025,'Assun??o')
insert into aux_apelido values(026,'Augusto')
insert into aux_apelido values(027,'Avelar')
insert into aux_apelido values(028,'Azevedo')
insert into aux_apelido values(029,'Bacelar')
insert into aux_apelido values(030,'Bai?o')
insert into aux_apelido values(031,'Baltazar')
insert into aux_apelido values(032,'Bandeira')
insert into aux_apelido values(033,'Baptista')
insert into aux_apelido values(034,'Barata')
insert into aux_apelido values(035,'Barbosa')
insert into aux_apelido values(036,'Barradas')
insert into aux_apelido values(037,'Barreiros')
insert into aux_apelido values(038,'Barreto')
insert into aux_apelido values(039,'Barros')
insert into aux_apelido values(040,'Barroso')
insert into aux_apelido values(041,'Basto')
insert into aux_apelido values(042,'Bastos')
insert into aux_apelido values(043,'Batalha')
insert into aux_apelido values(044,'Beja')
insert into aux_apelido values(045,'Belo')
insert into aux_apelido values(046,'Bento')
insert into aux_apelido values(047,'Bernardes')
insert into aux_apelido values(048,'Bernardino')
insert into aux_apelido values(049,'Bispo')
insert into aux_apelido values(050,'Bobone')
insert into aux_apelido values(051,'Borges')
insert into aux_apelido values(052,'Borrego')
insert into aux_apelido values(053,'Botelho')
insert into aux_apelido values(054,'Br?s')
insert into aux_apelido values(055,'Braga')
insert into aux_apelido values(056,'Branco')
insert into aux_apelido values(057,'Brand?o')
insert into aux_apelido values(058,'Brites')
insert into aux_apelido values(059,'Brito')
insert into aux_apelido values(060,'C?mara')
insert into aux_apelido values(061,'Cabanas')
insert into aux_apelido values(062,'Cabral')
insert into aux_apelido values(063,'Cabrita')
insert into aux_apelido values(064,'Caetano')
insert into aux_apelido values(065,'Caires')
insert into aux_apelido values(066,'Calado')
insert into aux_apelido values(067,'Caldas')
insert into aux_apelido values(068,'Caldeira')
insert into aux_apelido values(069,'Camacho')
insert into aux_apelido values(070,'Campos')
insert into aux_apelido values(071,'Canelas')
insert into aux_apelido values(072,'Carapinha')
insert into aux_apelido values(073,'Cardoso')
insert into aux_apelido values(074,'Carmo')
insert into aux_apelido values(075,'Carneiro')
insert into aux_apelido values(076,'Carreira')
insert into aux_apelido values(077,'Carvalho')
insert into aux_apelido values(078,'Casanova')
insert into aux_apelido values(079,'Casquilho')
insert into aux_apelido values(080,'Castanheira')
insert into aux_apelido values(081,'Castelo')
insert into aux_apelido values(082,'Castela')
insert into aux_apelido values(083,'Castilho')
insert into aux_apelido values(084,'Castro')
insert into aux_apelido values(085,'Cavaco')
insert into aux_apelido values(086,'Ceia')
insert into aux_apelido values(087,'Cerqueira')
insert into aux_apelido values(088,'Chaves')
insert into aux_apelido values(089,'Coelho')
insert into aux_apelido values(090,'Concei??o')
insert into aux_apelido values(091,'Conde')
insert into aux_apelido values(092,'Constantino')
insert into aux_apelido values(093,'Cordeiro')
insert into aux_apelido values(094,'Correia')
insert into aux_apelido values(095,'Cortez')
insert into aux_apelido values(096,'Costa')
insert into aux_apelido values(097,'Coutinho')
insert into aux_apelido values(098,'Couto')
insert into aux_apelido values(099,'Crespo')
insert into aux_apelido values(100,'Cruz')
insert into aux_apelido values(101,'Cunha')
insert into aux_apelido values(102,'Cust?dio')
insert into aux_apelido values(103,'Damas')
insert into aux_apelido values(104,'Daniel')
insert into aux_apelido values(105,'Delgado')
insert into aux_apelido values(106,'Dias')
insert into aux_apelido values(107,'Dimas')
insert into aux_apelido values(108,'Dinis')
insert into aux_apelido values(109,'Domingos')
insert into aux_apelido values(110,'Domingues')
insert into aux_apelido values(111,'Duarte')
insert into aux_apelido values(112,'Dur?o')
insert into aux_apelido values(113,'Encarna??o')
insert into aux_apelido values(114,'Espadinha')
insert into aux_apelido values(115,'Esperan?a')
insert into aux_apelido values(116,'Estev?o')
insert into aux_apelido values(117,'Esteves')
insert into aux_apelido values(118,'Evangelista')
insert into aux_apelido values(119,'F?lix')
insert into aux_apelido values(120,'Falc?o')
insert into aux_apelido values(121,'Faria')
insert into aux_apelido values(122,'Farinha')
insert into aux_apelido values(123,'Feio')
insert into aux_apelido values(124,'Fernandes')
insert into aux_apelido values(125,'Ferraz')
insert into aux_apelido values(126,'Ferreira')
insert into aux_apelido values(127,'Ferro')
insert into aux_apelido values(128,'Fialho')
insert into aux_apelido values(129,'Fidalgo')
insert into aux_apelido values(130,'Fialho')
insert into aux_apelido values(131,'Figueira')
insert into aux_apelido values(132,'Figueiredo')
insert into aux_apelido values(133,'Filho')
insert into aux_apelido values(134,'Flores')
insert into aux_apelido values(135,'Fonseca')
insert into aux_apelido values(136,'Fontes')
insert into aux_apelido values(137,'Frade')
insert into aux_apelido values(138,'Fraga')
insert into aux_apelido values(139,'Fran?a')
insert into aux_apelido values(140,'Francisco')
insert into aux_apelido values(141,'Franco')
insert into aux_apelido values(142,'Fraz?o')
insert into aux_apelido values(143,'Freire')
insert into aux_apelido values(144,'Freitas')
insert into aux_apelido values(145,'Frias')
insert into aux_apelido values(146,'Furtado')
insert into aux_apelido values(147,'Gago')
insert into aux_apelido values(148,'Galv?o')
insert into aux_apelido values(149,'Gama')
insert into aux_apelido values(150,'Gameiro')
insert into aux_apelido values(151,'Garcia')
insert into aux_apelido values(152,'Gaspar')
insert into aux_apelido values(153,'Geraldes')
insert into aux_apelido values(154,'Gil')
insert into aux_apelido values(155,'Gir?o')
insert into aux_apelido values(156,'Godinho')
insert into aux_apelido values(157,'Gomes')
insert into aux_apelido values(158,'Gon?alves')
insert into aux_apelido values(159,'Gonzaga')
insert into aux_apelido values(160,'Gouveia')
insert into aux_apelido values(161,'Gra?a')
insert into aux_apelido values(162,'Grade')
insert into aux_apelido values(163,'Guedes')
insert into aux_apelido values(164,'Guerra')
insert into aux_apelido values(165,'Guerreiro')
insert into aux_apelido values(166,'Guimar?es')
insert into aux_apelido values(167,'Gusm?o')
insert into aux_apelido values(168,'Guterres')
insert into aux_apelido values(169,'In?cio')
insert into aux_apelido values(170,'Infante')
insert into aux_apelido values(171,'Inverno')
insert into aux_apelido values(172,'Isidoro')
insert into aux_apelido values(173,'J?nior')
insert into aux_apelido values(174,'Jacinto')
insert into aux_apelido values(175,'Jardim')
insert into aux_apelido values(176,'Jer?nimo')
insert into aux_apelido values(177,'Jesus')
insert into aux_apelido values(178,'Jord?o')
insert into aux_apelido values(179,'Jorge')
insert into aux_apelido values(180,'Justino')
insert into aux_apelido values(181,'Lacerda')
insert into aux_apelido values(182,'Ladeira')
insert into aux_apelido values(183,'Lage')
insert into aux_apelido values(184,'Lameiras')
insert into aux_apelido values(185,'Le?o')
insert into aux_apelido values(186,'Leal')
insert into aux_apelido values(187,'Leit?o')
insert into aux_apelido values(189,'Leite')
insert into aux_apelido values(190,'Lemos')
insert into aux_apelido values(191,'Leonardo')
insert into aux_apelido values(192,'Lima')
insert into aux_apelido values(193,'Lisboa')
insert into aux_apelido values(194,'Lobato')
insert into aux_apelido values(195,'Lobo')
insert into aux_apelido values(196,'Lopes')
insert into aux_apelido values(197,'Loureiro')
insert into aux_apelido values(198,'Louren?o')
insert into aux_apelido values(199,'Lu?s')
insert into aux_apelido values(200,'Lucas')
insert into aux_apelido values(201,'Luz')
insert into aux_apelido values(202,'Macedo')
insert into aux_apelido values(203,'Machado')
insert into aux_apelido values(204,'Madeira')
insert into aux_apelido values(205,'Magalh?es')
insert into aux_apelido values(206,'Maia')
insert into aux_apelido values(207,'Mamede')
insert into aux_apelido values(208,'Marinho')
insert into aux_apelido values(209,'Marques')
insert into aux_apelido values(210,'Martins')
insert into aux_apelido values(211,'Mascarenhas')
insert into aux_apelido values(212,'Mata')
insert into aux_apelido values(213,'Mateus')
insert into aux_apelido values(214,'Matias')
insert into aux_apelido values(215,'Matos')
insert into aux_apelido values(216,'Medeiros')
insert into aux_apelido values(217,'Melo')
insert into aux_apelido values(218,'Mendes')
insert into aux_apelido values(219,'Mendon?a')
insert into aux_apelido values(220,'Meneses')
insert into aux_apelido values(221,'Mesquita')
insert into aux_apelido values(222,'Miranda')
insert into aux_apelido values(223,'Moniz')
insert into aux_apelido values(224,'Monteiro')
insert into aux_apelido values(225,'Montez')
insert into aux_apelido values(226,'Morais')
insert into aux_apelido values(227,'Moreira')
insert into aux_apelido values(228,'Morgado')
insert into aux_apelido values(229,'Mota')
insert into aux_apelido values(230,'Mour?o')
insert into aux_apelido values(231,'Moura')
insert into aux_apelido values(232,'Mourinho')
insert into aux_apelido values(233,'Moutinho')
insert into aux_apelido values(234,'N?brega')
insert into aux_apelido values(235,'Nabais')
insert into aux_apelido values(236,'Narciso')
insert into aux_apelido values(237,'Nascimento')
insert into aux_apelido values(238,'Negr?o')
insert into aux_apelido values(240,'Neto')
insert into aux_apelido values(241,'Neves')
insert into aux_apelido values(242,'Nobre')
insert into aux_apelido values(243,'Nogueira')
insert into aux_apelido values(244,'Noronha')
insert into aux_apelido values(245,'Norte')
insert into aux_apelido values(246,'Novais')
insert into aux_apelido values(247,'Nunes')
insert into aux_apelido values(248,'Oliveira')
insert into aux_apelido values(249,'Os?rio')
insert into aux_apelido values(250,'Pacheco')
insert into aux_apelido values(251,'Padr?o')
insert into aux_apelido values(252,'Pais')
insert into aux_apelido values(253,'Paiva')
insert into aux_apelido values(254,'Paix?o')
insert into aux_apelido values(255,'Palma')
insert into aux_apelido values(256,'Paredes')
insert into aux_apelido values(257,'Parreira')
insert into aux_apelido values(258,'Passos')
insert into aux_apelido values(259,'Patr?cio')
insert into aux_apelido values(260,'Paulino')
insert into aux_apelido values(261,'Paulo')
insert into aux_apelido values(262,'Pedro')
insert into aux_apelido values(263,'Pedrosa')
insert into aux_apelido values(264,'Pedroso')
insert into aux_apelido values(265,'Peixoto')
insert into aux_apelido values(266,'Perdig?o')
insert into aux_apelido values(267,'Pereira')
insert into aux_apelido values(268,'Peres')
insert into aux_apelido values(269,'Pessoa')
insert into aux_apelido values(270,'Pimenta')
insert into aux_apelido values(271,'Pimentel')
insert into aux_apelido values(272,'Pina')
insert into aux_apelido values(273,'Pinheiro')
insert into aux_apelido values(274,'Pinho')
insert into aux_apelido values(275,'Pinto')
insert into aux_apelido values(276,'Pires')
insert into aux_apelido values(277,'Pita')
insert into aux_apelido values(278,'Pl?cido')
insert into aux_apelido values(279,'Po?as')
insert into aux_apelido values(280,'Ponte')
insert into aux_apelido values(281,'Porto')
insert into aux_apelido values(282,'Portugal')
insert into aux_apelido values(283,'Pra?a')
insert into aux_apelido values(284,'Prates')
insert into aux_apelido values(285,'Proen?a')
insert into aux_apelido values(286,'Ramalho')
insert into aux_apelido values(287,'Ramos')
insert into aux_apelido values(288,'Raposo')
insert into aux_apelido values(289,'Rebelo')
insert into aux_apelido values(290,'Redondo')
insert into aux_apelido values(291,'Rego')
insert into aux_apelido values(292,'Reis')
insert into aux_apelido values(293,'Resende')
insert into aux_apelido values(294,'Resendes')
insert into aux_apelido values(295,'Ribeiro')
insert into aux_apelido values(296,'Rocha')
insert into aux_apelido values(297,'Rodrigues')
insert into aux_apelido values(298,'Rom?o')
insert into aux_apelido values(299,'Roque')
insert into aux_apelido values(300,'Ros?rio')
insert into aux_apelido values(301,'Rosa')
insert into aux_apelido values(302,'Rua')
insert into aux_apelido values(303,'Ruas')
insert into aux_apelido values(304,'Ruivo')
insert into aux_apelido values(305,'Russo')
insert into aux_apelido values(306,'S?')
insert into aux_apelido values(307,'Saldanha')
insert into aux_apelido values(308,'Salema')
insert into aux_apelido values(309,'Salgado')
insert into aux_apelido values(310,'Salgueiro')
insert into aux_apelido values(311,'Sampaio')
insert into aux_apelido values(312,'Santana')
insert into aux_apelido values(313,'Santiago')
insert into aux_apelido values(314,'Santos')
insert into aux_apelido values(315,'Saraiva')
insert into aux_apelido values(316,'Sarmento')
insert into aux_apelido values(317,'Seabra')
insert into aux_apelido values(318,'Seixas')
insert into aux_apelido values(319,'Sena')
insert into aux_apelido values(320,'Sequeira')
insert into aux_apelido values(321,'Serafim')
insert into aux_apelido values(322,'Sernadas')
insert into aux_apelido values(323,'Serpa')
insert into aux_apelido values(324,'Serr?o')
insert into aux_apelido values(325,'Serra')
insert into aux_apelido values(326,'Serrano')
insert into aux_apelido values(327,'Silva')
insert into aux_apelido values(328,'Silveira')
insert into aux_apelido values(329,'Silvestre')
insert into aux_apelido values(330,'Sim?o')
insert into aux_apelido values(331,'Sim?es')
insert into aux_apelido values(332,'Soares')
insert into aux_apelido values(333,'Sobral')
insert into aux_apelido values(334,'Soeiro')
insert into aux_apelido values(335,'Sousa')
insert into aux_apelido values(336,'Taborda')
insert into aux_apelido values(337,'Tavares')
insert into aux_apelido values(338,'Taveira')
insert into aux_apelido values(339,'Teixeira')
insert into aux_apelido values(340,'Teodoro')
insert into aux_apelido values(341,'Tom?s')
insert into aux_apelido values(342,'Tom?')
insert into aux_apelido values(343,'Torrado')
insert into aux_apelido values(344,'Torres')
insert into aux_apelido values(345,'Trindade')
insert into aux_apelido values(347,'Valente')
insert into aux_apelido values(346,'Vale')
insert into aux_apelido values(348,'Valentim')
insert into aux_apelido values(349,'Varela')
insert into aux_apelido values(350,'Vargas')
insert into aux_apelido values(351,'Vasconcelos')
insert into aux_apelido values(352,'Vaz')
insert into aux_apelido values(353,'Veiga')
insert into aux_apelido values(354,'Veloso')
insert into aux_apelido values(355,'Ventura')
insert into aux_apelido values(356,'Ver?ssimo')
insert into aux_apelido values(357,'Verde')
insert into aux_apelido values(358,'Vicente')
insert into aux_apelido values(359,'Vidal')
insert into aux_apelido values(360,'Viegas')
insert into aux_apelido values(361,'Vieira')
insert into aux_apelido values(362,'Vila?a')
insert into aux_apelido values(363,'Vilarinho')
insert into aux_apelido values(364,'Vilela')
insert into aux_apelido values(365,'Vilhena')
insert into aux_apelido values(366,'Vinagre')
insert into aux_apelido values(367,'Vitorino')


insert into aux_localidade values(001,'Aveiro', 3800)
insert into aux_localidade values(002,'Beja', 7800)
insert into aux_localidade values(003,'Braga', 4700)
insert into aux_localidade values(004,'Bragan?a', 5300)
insert into aux_localidade values(005,'Coimbra', 3040)
insert into aux_localidade values(006,'?vora', 7000)
insert into aux_localidade values(007,'Faro', 8000)
insert into aux_localidade values(008,'Guarda', 6300)
insert into aux_localidade values(009,'Leiria', 2400)
insert into aux_localidade values(010,'Lisboa', 1100)
insert into aux_localidade values(011,'Portalegre', 7300)
insert into aux_localidade values(012,'Porto', 4350)
insert into aux_localidade values(013,'Santar?m', 2000)
insert into aux_localidade values(014,'Set?bal', 2900)
insert into aux_localidade values(015,'Viana do Castelo', 4900)
insert into aux_localidade values(016,'Vila Real', 5000)
insert into aux_localidade values(017,'Viseu', 3500)
insert into aux_localidade values(018,'Belmonte', 6250)
insert into aux_localidade values(019,'Castelo Branco', 6000)
insert into aux_localidade values(020,'Covilh?', 6200)
insert into aux_localidade values(021,'Fund?o', 6230)
insert into aux_localidade values(022,'Idanha-a-Nova', 6060)
insert into aux_localidade values(023,'Oleiros', 6160)
insert into aux_localidade values(024,'Penamacor', 6090)
insert into aux_localidade values(025,'Proen?a-a-Nova', 6150)
insert into aux_localidade values(026,'Sert?', 6100)
insert into aux_localidade values(027,'Vila de Rei', 6111)
insert into aux_localidade values(028,'Vila Velha de Rod?o', 6030)
insert into aux_localidade values(029,'Arganil', 3300)
insert into aux_localidade values(030,'Cantanhede', 3060)
insert into aux_localidade values(031,'Condeixa-a-Nova', 3150)
insert into aux_localidade values(032,'Figueira da Foz', 3080)
insert into aux_localidade values(033,'G?is', 3330)
insert into aux_localidade values(034,'Lous?', 3200)
insert into aux_localidade values(035,'Mira', 3070)
insert into aux_localidade values(036,'Miranda do Corvo', 3220)
insert into aux_localidade values(037,'Montemor-o-Velho', 3140)
insert into aux_localidade values(038,'Oliveira do Hospital', 3400)
insert into aux_localidade values(039,'Pampilhosa da Serra', 3320)
insert into aux_localidade values(040,'Penacova', 3360)
insert into aux_localidade values(041,'Penela', 3230)
insert into aux_localidade values(042,'Soure', 3130)
insert into aux_localidade values(043,'T?bua', 3420)
insert into aux_localidade values(044,'Vila Nova de Poiares', 3350);  

Create procedure populate_dim_cliente (@nrRegistos int)
as
declare @array_nome		table(rowid int, nome varchar(15), sexo varchar(50))
declare @array_apelido		table(rowid int, apelido varchar(15))
declare @array_localidade	table(rowid int, localidade varchar(20), codpostal int)

declare @count int
declare @aleatorio int, @i int, @tmpid int
declare @tmpSexo varchar(15)
declare @tmpNome1 varchar(15)
declare @tmpNome2 varchar(15)
declare @tmpApelido1 varchar(15)
declare @tmpApelido2 varchar(15)
declare @tmpLocalidade varchar(20)
declare @tmpCodPostal INT
declare @tmpEstadoCivil varchar(20)
declare @tmpNomeFINAL varchar(50)

set @i=1

insert @array_nome
select * from aux_nome

insert @array_apelido
select * from aux_apelido

insert @array_localidade
select * from aux_localidade

delete from dim_cliente

while @i <= @nrRegistos
	begin
	
 		set @aleatorio = rand()*142 + 1
		SELECT @tmpid = rowid, @tmpNome1 = nome, @tmpSexo = sexo
		FROM @array_nome
		WHERE rowid = @aleatorio

		set @aleatorio = rand()*142 + 1
		SELECT @tmpid = rowid, @tmpNome2 = nome
		FROM @array_nome
		WHERE rowid = @aleatorio
		
		set @aleatorio = rand()*367 + 1
		SELECT @tmpid = rowid, @tmpApelido1 = apelido 
		FROM @array_apelido
		WHERE rowid = @aleatorio

		set @aleatorio = rand()*367 + 1
		SELECT @tmpid = rowid, @tmpApelido2 = apelido 
		FROM @array_apelido
		WHERE rowid = @aleatorio

		set @tmpnomeFinal=rtrim(@tmpNome1)+' '+rtrim(@tmpNome2)+' '+rtrim(@tmpApelido1)+' '+rtrim(@tmpApelido2)
		
		set @aleatorio = rand()*44 + 1
		SELECT @tmpid = rowid, @tmpLocalidade = localidade, @tmpCodPostal = CodPostal
		FROM @array_localidade
		WHERE rowid = @aleatorio

		set @aleatorio = rand()*4 + 1
		
		set @tmpEstadoCivil =
			case @aleatorio
				when 1 then 'Solteiro'
				when 2 then 'Casado'
				when 3 then 'Divorciado'
				else 'Viuvo'
			end
		
		set @aleatorio = rand()*80 + 18

		insert into dim_cliente (id_cliente, nome_cliente, localidade, codpostal, idade, sexo, estado_civil) 
		values (@i, @tmpNomefinal, @tmpLocalidade, @tmpCodPostal, @aleatorio, @tmpSexo, @tmpEstadoCivil)

 		set @i = @i+1
	end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- Execu??o do procedimento com parametro de entrada 200 (teste esta mesma execu??o para 
-- valores diferentes no parametro de entrada)

exec populate_dim_cliente 200

select * from dim_cliente








-- Bloco de código em T-SQL que definindo "@dataInicial" e a "@dataFinal" 
-- popula a DIM_TEMPO para os valores indicados
 
 declare @dataInicial date, @dataFinal date, @data date, 
    @ano smallint, @mes smallint, @dia smallint, 
    @diaSemana smallint, @diaUtil char(1), @fimSemana char(1), 
    @feriado char(1), @preFeriado char(1), @posFeriado char(1), 
    @nomeFeriado varchar(30), @nomeDiaSemana varchar(15), 
    @nomeDiaSemanaAbrev char(3), @nomeMes varchar(15), 
    @nomeMesAbrev char(3), @bimestre smallint, @trimestre smallint, 
    @nrSemanaMes smallint, @estacaoAno varchar(15), 
    @dataPorExtenso varchar(50)

--Defina aqui o período para o qual deseja criar os dados
set @dataInicial = '01/Jan/2021'
set @dataFinal = '31/Dec/2021'

delete from dim_tempo

while @dataInicial <= @dataFinal
begin
 set @data = @dataInicial
 set @ano = year(@data)
 set @mes = month(@data)
 set @dia = day(@data)
 set @diaSemana = datepart(weekday,@data)

 if @diaSemana in (1,7) 
 set @fimSemana = 'S'
 else set @fimSemana = 'N'

 /* feriados locais/regionais e aqueles que não possuem data fixa 
 (carnaval, páscoa e corpus cristis) tb devem ser adicionados aqui */

 if (@mes = 1 and @dia in (1,2)) or (@mes = 12 and @dia = 31) --Feriado Universal
 set @nomeFeriado = 'Feriado Universal'
 else 
 if (@mes = 4 and @dia in (25)) --Dia da Liberdade
 set @nomeFeriado = 'Dia da Liberdade'
 else 
 if (@mes = 5 and @dia in (1)) --Dia do trabalhador
 set @nomeFeriado = 'Dia do trabalhador'
 else 
 if (@mes = 6 and @dia in (10)) --Dia de Portugal
 set @nomeFeriado = 'Dia de Portugal'
 else
 if (@mes = 8 and @dia in (15)) --Dia Nossa Senhora Assuncao
 set @nomeFeriado = 'Dia Nossa Senhora Assuncao'
 else 
 if (@mes = 10 and @dia in (5)) --Implantacao Republica
 set @nomeFeriado = 'Implantacao Republica'
 else
 if (@mes = 11 and @dia in (1)) --Dia de Finados
 set @nomeFeriado = 'Dia de Finados'
 else
 if (@mes = 12 and @dia in (1)) --Dia da Restaurcao da Independencia
 set @nomeFeriado = 'proclamação da república'
 else
 if (@mes = 12 and @dia in (8)) --Imaculada Conceicao
 set @nomeFeriado = 'Imaculada Conceicao'
 else
 if (@mes = 12 and @dia in (24,25)) --Natal
 set @nomeFeriado = 'Natal'
 else set @nomeFeriado = null

 if (@mes = 12 and @dia = 31) or --Feriado Universal
 (@mes = 4 and @dia = 24) or --Dia da Liberdade
 (@mes = 4 and @dia = 30) or --Dia do trabalhador
 (@mes = 6 and @dia = 9) or --Dia de Portugal
 (@mes = 8 and @dia = 14) or --Dia Nossa Senhora Assuncao
 (@mes = 10 and @dia = 4) or --Implantacao Republica
 (@mes = 10 and @dia = 31) or --Dia de Finados
 (@mes = 11 and @dia = 30) or --Dia da Restaurcao da Independencia
 (@mes = 12 and @dia = 7) or --Imaculada Conceicao
 (@mes = 12 and @dia = 24) --Natal
 set @preFeriado = 'S'
 else set @preFeriado = 'N'

 if (@mes = 1 and @dia = 1) or --Feriado Universal
 (@mes = 4 and @dia = 25) or --Dia da Liberdade
 (@mes = 5 and @dia = 1) or --Dia do trabalhador
 (@mes = 6 and @dia = 10) or --Dia de Portugal
 (@mes = 8 and @dia = 15) or --Dia Nossa Senhora Assuncao
 (@mes = 10 and @dia = 5) or --Implantacao Republica
 (@mes = 11 and @dia = 1) or --Dia de Finados
 (@mes = 12 and @dia = 1) or --Dia da Restaurcao da Independencia
 (@mes = 12 and @dia = 8) or --Imaculada Conceicao
 (@mes = 12 and @dia = 25) --Natal
 set @feriado = 'S'
 else set @feriado = 'N'

 if (@mes = 1 and @dia = 2) or --Feriado Universal
 (@mes = 4 and @dia = 26) or --Dia da Liberdade
 (@mes = 5 and @dia = 2) or --Dia do trabalhador
 (@mes = 6 and @dia = 11) or --Dia de Portugal
 (@mes = 8 and @dia = 16) or --Dia Nossa Senhora Assuncao
 (@mes = 10 and @dia = 6) or --Implantacao Republica
 (@mes = 11 and @dia = 2) or --Dia de Finados
 (@mes = 12 and @dia = 2) or --Dia da Restaurcao da Independencia
 (@mes = 12 and @dia = 9) or --Imaculada Conceicao
 (@mes = 12 and @dia = 26) --Natal
 set @posFeriado = 'S'
 else set @posFeriado = 'N'

 set @nomeMes = case when @mes = 1 then 'janeiro'
 when @mes = 2 then 'fevereiro'
 when @mes = 3 then 'março'
 when @mes = 4 then 'abril'
 when @mes = 5 then 'maio'
 when @mes = 6 then 'junho'
 when @mes = 7 then 'julho'
 when @mes = 8 then 'agosto'
 when @mes = 9 then 'setembro'
 when @mes = 10 then 'outubro'
 when @mes = 11 then 'novembro'
 when @mes = 12 then 'dezembro' end

 set @nomeMesAbrev = case when @mes = 1 then 'jan'
 when @mes = 2 then 'fev'
 when @mes = 3 then 'mar'
 when @mes = 4 then 'abr'
 when @mes = 5 then 'mai'
 when @mes = 6 then 'jun'
 when @mes = 7 then 'jul'
 when @mes = 8 then 'ago'
 when @mes = 9 then 'set'
 when @mes = 10 then 'out'
 when @mes = 11 then 'nov'
 when @mes = 12 then 'dez' end

 if @fimSemana = 'S' or @feriado = 'S'
 set @diaUtil = 'N'
 else set @diaUtil = 'S'

 set @nomeDiaSemana = case when @diaSemana = 1 then 'domingo'
 when @diaSemana = 2 then 'segunda-feira'
 when @diaSemana = 3 then 'terça-feira'
 when @diaSemana = 4 then 'quarta-feira'
 when @diaSemana = 5 then 'quinta-feira'
 when @diaSemana = 6 then 'sexta-feira'
 else 'sábado' end

 set @nomeDiaSemanaAbrev = case when @diaSemana = 1 then 'dom'
 when @diaSemana = 2 then 'seg'
 when @diaSemana = 3 then 'ter'
 when @diaSemana = 4 then 'qua'
 when @diaSemana = 5 then 'qui'
 when @diaSemana = 6 then 'sex'
 else 'sáb' end

 set @bimestre = case when @mes in (1,2) then 1
 when @mes in (3,4) then 2
 when @mes in (5,6) then 3
 when @mes in (7,8) then 4
 when @mes in (9,10) then 5
 else 6 end

 set @trimestre = case when @mes in (1,2,3) then 1
 when @mes in (4,5,6) then 2
 when @mes in (7,8,9) then 3
 else 4 end

 set @nrSemanaMes = case when @dia < 8 then 1
 when @dia < 15 then 2
 when @dia < 22 then 3
 when @dia < 29 then 4
 else 5 end

 if @data between cast('23/Sep/'+convert(char(4),@ano) as date) and cast('20/Dec/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'outono'
 else if @data between cast('21/Mar/'+convert(char(4),@ano) as date) and cast('20/Jun/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'primavera'
 else if @data between cast('21/Jun/'+convert(char(4),@ano) as date) and cast('22/Sep/'+convert(char(4),@ano) as date)
 set @estacaoAno = 'verao'
 else -- @data between 21/12 e 20/03
 set @estacaoAno = 'inverno'

INSERT INTO dbo.DIM_TEMPO
 SELECT @data
 ,@ano
 ,@mes
 ,@dia
 ,@diaSemana
 ,datepart(dayofyear,@data) --DIA_ANO
 ,case when (@ano % 4) = 0 then 'S' else 'N' end -- ANO_BISSEXTO
 ,@diaUtil
 ,@fimSemana
 ,@feriado
 ,@preFeriado
 ,@posFeriado
 ,@nomeFeriado
 ,@nomeDiaSemana
 ,@nomeDiaSemanaAbrev
 ,@nomeMes
 ,@nomeMesAbrev
 ,case when @dia < 16 then 1 else 2 end -- QUINZENA
 ,@bimestre
 ,@trimestre
 ,case when @mes < 7 then 1 else 2 end -- SEMESTRE
 ,@nrSemanaMes
 ,datepart(wk,@data)--NR_SEMANA_ANO, smallint
 ,@estacaoAno
 ,lower(@nomeDiaSemana + ', ' + cast(@dia as varchar) + ' de ' + @nomeMes + ' de ' + cast(@ano as varchar))
 ,null--EVENTO, varchar(50))

 set @dataInicial = dateadd(day,1,@dataInicial) 
end






-- drop procedure populate_tb_fatos

-- Criação do procedimento

Create procedure populate_tb_fatos (@nrRegistos int)
as

declare @aleatorio int, @i int
declare @tmpIdTempo int, @tmpIdMarca int, @tmpIdCliente int
declare @tmpLucro int
declare @tmpValorRetoma int

set @i=1

delete from tb_fatos

while @i <= @nrRegistos
	begin
	
 		set @tmpIdTempo = rand()*365 + 1
		
		set @tmpIdMarca = rand()*15 + 1
				
		set @tmpIdCliente = rand()*200 + 1
		
		set @tmpLucro = rand()*5000 + 1
		
		set @tmpValorRetoma = rand()*2000 + 1
		
		insert into tb_fatos (id_tempo, id_marca, id_cliente, lucro, valor_retoma) 
		values (@tmpIdTempo, @tmpIdMarca, @tmpIdCliente, @tmpLucro, @tmpValorRetoma)

 		set @i = @i+1
	end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- Execução do procedimento com parametro de entrada 5000 (teste esta mesma execução para 
-- valores diferentes no parametro de entrada)
-------------------------------------------------------------------------------------------------

exec populate_tb_fatos 5000

select * from tb_fatos




SELECT 
    dt.nome_dia_semana, 
    dt.semestre, 
    SUM(tf.lucro) AS Total_Lucro
FROM tb_fatos tf
INNER JOIN dim_tempo dt
    ON tf.id_tempo = dt.ID_TEMPO
GROUP BY CUBE (dt.semestre, dt.nome_dia_semana)


















-- drop procedure populate_tb_fatos

-- Criação do procedimento

Create procedure populate_tb_fatos (@nrRegistos int)
as

declare @aleatorio int, @i int
declare @tmpIdTempo int, @tmpIdMarca int, @tmpIdCliente int
declare @tmpLucro int
declare @tmpValorRetoma int

set @i=1

delete from tb_fatos

while @i <= @nrRegistos
	begin
	
 		set @tmpIdTempo = rand()*365 + 1
		
		set @tmpIdMarca = rand()*15 + 1
				
		set @tmpIdCliente = rand()*200 + 1
		
		set @tmpLucro = rand()*5000 + 1
		
		set @tmpValorRetoma = rand()*2000 + 1
		
		insert into tb_fatos (id_tempo, id_marca, id_cliente, lucro, valor_retoma) 
		values (@tmpIdTempo, @tmpIdMarca, @tmpIdCliente, @tmpLucro, @tmpValorRetoma)

 		set @i = @i+1
	end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- Execução do procedimento com parametro de entrada 5000 (teste esta mesma execução para 
-- valores diferentes no parametro de entrada)
-------------------------------------------------------------------------------------------------

exec populate_tb_fatos 5000

select * from tb_fatos