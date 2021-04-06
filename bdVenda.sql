CREATE DATABASE bdVenda
USE bdVenda

/*Criação das tabelas*/
CREATE TABLE tbCliente(
	codCliente int primary key identity(1,1) not null,
	nomeCliente varchar(30) not null,
	cpfCliente varchar(11) not null,
	emailCliente varchar(30) not null,
	sexoCliente varchar(2) not null,
	dtnascCliente date not null
);

CREATE TABLE tbFabricante(
	codFabricante int primary key identity(1,1) not null,
	nomeFabricante varchar(30) not null
);

CREATE TABLE tbFornecedor(
	codFornecedor int primary key identity(1,1) not null,
	nomeFornecedor varchar(15) not null,
	contatoFornecedor varchar(15) not null
);

CREATE TABLE tbProduto(
	codProduto int primary key identity(1,1) not null,
	descricaoProduto varchar(30) not null,
	valorProduto decimal(10,2) not null,
	quantidadeProduto int not null,
	codFabricante int foreign key references tbFabricante(codFabricante) not null,
	codFornecedor int foreign key references tbFornecedor(codFornecedor) not null
);

CREATE TABLE tbVenda(
	codVenda int primary key identity(1,1) not null,
	dataVenda date not null,
	valorTotal decimal(10,2) not null,
	codCliente int foreign key references tbCliente(codCliente) not null
);

CREATE TABLE tbItensVenda(
	codItensVenda int primary key identity(1,1) not null,
	codVenda int foreign key references tbVenda(codVenda) not null,
	codProduto int foreign key references tbProduto(codProduto) not null,
	quantidadeItensVenda int not null,
	subTotalItensVenda int not null
);

/*SELECT=====================================*/

select codCliente, nomeCliente AS Nome, 
substring(cpfCliente,1,9) + ' - ' + substring(cpfCliente,10,11) AS CPF,
emailCliente AS EMAIL, sexoCliente AS Sexo,
dtnascCliente AS 'Data de Nascimento'
from tbCliente

select codFabricante, nomeFabricante AS 'Nome do Fabricante' from tbFabricante

select codFornecedor, 
nomeFornecedor AS 'Nome do Fornecedor',
contatoFornecedor AS Contato
from tbFornecedor

select codItensVenda, codVenda AS Venda,
codProduto AS Produto,
quantidadeItensVenda AS Quantidade,
subTotalItensVenda
from tbItensVenda

select codProduto, descricaoProduto AS 'Descrição do Produto',
codFabricante, codFornecedor
from tbProduto

select codVenda, dataVenda AS Venda,
'R$' + cast(valorTotal AS varchar) AS Valor,
codCliente
from tbVenda

/*INSERTS==========================================*/

insert into 
tbCliente(nomeCliente,cpfCliente,emailCliente,sexoCliente,dtnascCliente) values
	('Armando José Santana','12345678900','armandoJsantan@outlook.com.br','M','1961-02-21'),
	('Sheila Carvalho Leal','45678909823','scarvalho@ig.com.br','F','1978-09-13'),
	('Carlos Henrique Souza','76598278299','carlosh@outlook.com','M','1981-09-08'),
	('Maria Aparecida Souza','87365309899','mariamaria@etec.sp.gov.br','F','1962-07-07'),
	('Adriana Nogueira Silva','10000000001','drica19@terra.com.br','F','1977-04-09'),
	('Paulo Henrique Silva','87390123111','ph2021@uol.com.br','M','1987-02-02');

insert into tbFabricante(nomeFabricante) values
	('Unilever'),
	('P&G'),
	('Bunge');

insert into tbFornecedor(nomeFornecedor,contatoFornecedor) values
	('Atacadão','Carlos Santos'),
	('Assai','Maria Stella'),
	('Roldão','Paulo César');

insert into 
tbProduto(descricaoProduto,valorProduto,quantidadeProduto,codFabricante,codFornecedor) 
values
	('Amaciante Downy',5.76,1500,2,1),
	('Amaciante Confort',5.45,2300,1,1),
	('Sabão em Pó OMO',5.99,1280,1,2),
	('Margarina Qually',4.76,2500,3,1),
	('Salsicha Hot-dog Sadia',6.78,2900,3,1),
	('Mortadela Perdigão',2.50,1200,3,3),
	('Hamburger Sadia',9.89,1600,3,1),
	('Fralda Pampers',36.00,340,2,3),
	('Xampu Seda',5.89,800,1,2),
	('Condicionador Seda',6.50,700,1,3);

insert into tbVenda(dataVenda,valorTotal,codCliente) values
	('2021-2-1',4500,1),
	('2021-2-3',3400,1),
	('2021-3-10',2100,2),
	('2021-3-15',2700,3),
	('2021-3-17',560,3),
	('2021-3-6',1200,4),
	('2021-3-7',3500,5),
	('2021-2-9',3400,1),
	('2021-3-20',4000,2);

insert into tbItensVenda(codVenda,codProduto,quantidadeItensVenda,subTotalItensVenda)
values
	(1,1,200,1500),
	(1,2,300,3000),
	(2,4,120,1400),
	(2,2,200,1000),
	(2,3,130,1000),
	(3,5,200,2100),
	(4,4,120,1000),
	(4,5,450,700),
	(5,5,200,560),
	(6,7,200,600),
	(6,6,300,600),
	(8,1,300,2500),
	(8,2,200,1000),
	(9,6,250,1700),
	(9,5,200,1700),
	(9,4,1000,4000);