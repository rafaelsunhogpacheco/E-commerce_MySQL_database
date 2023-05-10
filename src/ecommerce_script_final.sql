-- Banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    street varchar(20),
    district varchar(20),
    complement varchar(10),
    city varchar(20),
    state char(2),
    zip_code char(8),
    Bdade date,
    constraint unique_cpf_client unique (CPF)
);


-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(15) not null,
    Category enum('Eletrônicos', 'Livros', 'Games') not null,
    PoDescription varchar(255) not null,
    PoValue float,
    rating float default 0,
    constraint unique_pname unique (Pname)
);



-- criar a tabela entrega
create table delivery (
	idEntrega int primary key auto_increment,
    statusEntrega varchar(45),
    dataEntrega date,
    codRastreio varchar(45)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    orderStatus ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') default 'Processando',
    Descricao varchar(255),
    idOrderClient int,
    Frete float,
    idOdDelivery int,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient),
    constraint fk_order_delivery foreign key (idOdDelivery) references delivery(idEntrega)
);


-- criar a tabela Pagamentos
create table payments(
	idPayment int auto_increment,
    idOrderPay int,
	idClientPay int,
    idDeliveryPay int,
    dadosBoleto varchar(45),
    numCard varchar(45),
    nameCard varchar(45),
    datePayment date,
    typePayment enum('Boleto', 'Cartão', 'Dois Cartões', 'PIX'),
    primary key (idPayment, idOrderPay,idClientPay, idDeliveryPay),
	constraint fk_order_payment foreign key (idOrderPay) references orders(idOrder),
    constraint fk_client_payment foreign key (idClientPay) references clients(idClient),
    constraint fk_delivery_payment foreign key (idDeliveryPay) references delivery(idEntrega)
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int primary key not null,
    storagelocation varchar(45) not null,
    quantity int not null
);


-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact varchar(11) not null,
    street varchar(20),
    district varchar(20),
    complement varchar(10),
    city varchar(20),
    state char(2),
    zip_code char(8),
    constraint unique_supplier unique (CNPJ)
);


-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    Socialname varchar (45) not null,
    CNPJ char(15),
    CPF char(9),
    rua varchar(20),
    bairro varchar(20),
    complemento varchar(10),
    cidade varchar(20),
    estado char(2),
    cep char(8),
    constraint unique_cpf_seller unique (CPF),
    constraint unique_cnpj_seller unique (CNPJ)
);


-- criar tabela produto vendedor
create table productSeller(
	idPSeller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPSeller,idProduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_productsl_product foreign key (idProduct) references product(idProduct)
);



-- criar tabela relação produto x pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus ENUM('Disponível', 'Sem estoque'),
    primary key (idPOproduct,idPOorder),
    constraint fk_po_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_po_order foreign key (idPOorder) references orders(idOrder)
);


-- criar tabela relação produto em estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_produtc_storage foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location foreign key (idLstorage) references productStorage(idProdStorage)
);

-- criar tabela relação produto fornecedor
create table productSuplier (
	idSupplier int not null,
    idProduct int not null,
    primary key (idSupplier,idProduct),
	constraint fk_ps_supplier foreign key (idSupplier) references supplier(idSupplier),
    constraint fk_ps_product foreign key (idProduct) references product(idProduct)
);

show tables;

-- selecionando as constraints ligadas ao BD ecommerce
show databases;
use information_schema;
select * from referential_constraints where constraint_schema = 'ecommerce';


-- Inserção de dados
use ecommerce;
show tables;

alter table clients auto_increment=1;





-- Relação e conteúdo das tabelas
desc clients;
select * from clients;

insert into clients (Fname, Minit,Lname,CPF,street,district,complement,city,state,zip_code,Bdade)
			values ('Carlos', 'Dos', 'Santos',12345678911,'Rua das Palmeiras','Centro','124','São Paulo','SP','89990000','1985-01-09'),
					('Fernanda', 'RST', 'Pereira',45645678911,'Tamandare','Novo Bairro','65','São Paulo','SP','89990000','1993-03-10'),
					('Rafael', 'Alb', 'Silva',12125678911,'Av Paulista','Centro','apto 203','Chapeco','SC','89990000','2000-03-03'),
					('Mariana', 'Mei', 'Meireles',88345678911,'Rua dos Araças','Aeroporto','569','Curitiba','PR','89990000','2010-01-10'),
					('Murilo', 'Ant', 'Piovesan',33345678911,'Rua XV de Maio','Novo Horizonte','658','Campinas','SP','89990000','1992-06-09'),
					('Paula', 'Mar', 'Moraes',12598678911,'Rua Bandeirantes','Centro','1266','Hortolandia','SP','89990000','1989-04-09'),
					('Antonio', 'FFM', 'Fratin',12658978911,'Rua Rio de Janeiro','Nova Mutum','15624','Umuarama','PR','89990000','1991-02-09'),
					('Carolina', 'Let', 'Santos',12658678911,'Av Altinopolis','Pedreira','1246','São Paulo','SP','89990000','2002-10-10');
                            


desc delivery;
select * from delivery;

insert into delivery (StatusEntrega, dataEntrega,CodRastreio)
			values ('Entregue','2022-01-09','123123XXL'),
					('Enviado','2022-02-03','456456OOS'),
                    ('Devolvido','2022-05-06','789654AVC'),
                    ('Entregue','2022-03-09','568542SAP'),
                    ('Enviado','2022-04-09','568742XAB'),
                    ('Devolvido','2022-10-11','123123SDF');

insert into delivery (StatusEntrega, dataEntrega,CodRastreio)
			values ('Entregue','2022-01-09','565656XXL'),
					('Entregue','2022-02-03','999956OOS'),
                    ('Enviado','2022-05-06','121254AVC'),
                    ('Entregue','2022-03-09','787842SAP'),
                    ('Enviado','2022-04-09','333342XAB'),
                    ('Enviado','2022-10-11','659823SDF');


desc orders;
select * from orders;
insert into orders (orderStatus, Descricao,idOrderClient, Frete, idOdDelivery)
			values ('Entregue','N/A',1,59.9,3),
					('Processando','N/A',2,59.9,2),
                    ('Enviado','N/A',3,0,1),
                    ('Entregue','N/A',1,29.9,3),
                    ('Em andamento','N/A',2,29.9,2),
                    ('Entregue','N/A',3,0,1),
                    ('Entregue','N/A',1,59.9,2),
                    ('Enviado','N/A',3,0,1),
                    ('Enviado','N/A',1,0,3),
                    ('Em andamento','N/A',2,0,2),
                    ('Enviado','N/A',3,0,1);
					




desc product;
select * from product;

insert into product (Pname, Category,PoDescription, PoValue, rating)
			values ('HyperX Headset','Eletrônicos','HyperX Cloud II Gaming Headset com 7.1 Surround Sound',367.45,3.1),
					('Logitech G','Eletrônicos','Logitech G Fone de ouvido para jogos com fio 432, som surround 7.1, fone de ouvido DTS: X 2.0, microfone flip-to-mudo, PC (couro) preto/azul',499.50,4.9),
                    ('Furious Headset','Eletrônicos','Fone de ouvido para jogos PS4 PS5 Xbox One Switch PC com microfone com cancelamento de ruído, som estéreo de graves profundos',110.31,4.5),
                    ('Sapiens','Livros','Harari',125.9,4.2),
                    ('Homo Deus','Livros','Harari',210.9,4.9),
                    ('21 Lições','Livros','Harari',59.9,4.7),
                    ('Battlefield','Games','Xbox',99.9,4.9),
                    ('Star Wars','Games','PS4',89.9,4.9),
                    ('Simpsons','Games','Xbox',12.9,4.9),
                    ('Diablo','Games','PS4',99.9,4.9);


desc productorder;
select * from productorder;
insert into productorder (idPOproduct, idPOorder,PoQuantity, PoStatus)
			values (11,1,1,'Disponível'),
					(12,2,1,'Sem estoque'),
                    (13,3,2,'Disponível'),
                    (14,4,2,'Sem estoque'),
                    (15,5,1,'Disponível'),
                    (16,6,1,'Sem estoque'),
                    (11,7,2,'Disponível'),
                    (11,8,1,'Disponível'),
                    (15,9,1,'Disponível'),
                    (16,10,1,'Disponível'),
                    (16,11,1,'Disponível');
                    
                    




desc payments;
select * from payments;
select * from delivery;

-- fk orders, client, delivery

insert into payments (idOrderPay, idClientPay, idDeliveryPay, dadosBoleto, numCard, nameCard, datePayment, typePayment)
			values (11,1,1,null, 123123, 'Jose da Silva','2022-05-04','Cartão'),
					(9,2,2,'japsijdoijasd', null, 'Jose da Silva','2022-04-05','Boleto'),
                    (7,3,3,null, 123123, 'Nome no cartao','2022-06-09','Cartão'),
                    (6,4,4,'apsodkapso', null, 'Jose da Silva','2022-10-11','Boleto'),
                    (5,5,5,null, 456985, 'Nome no cartao','2022-10-11','Cartão'),
                    (3,6,10,null, 568743, 'Nome no cartao','2022-06-05','Cartão'),
                    (2,8,6,null, 5687745, 'Nome no cartao','2022-11-11','Cartão'),
                    (1,2,7,null, 236548, 'Nome no cartao','2022-10-11','Cartão'),
                    (10,1,8,null, 567845, 'Nome no cartao','2022-05-06','Cartão'),
                    (4,3,9,null, 236587, 'Nome no cartao','2022-10-11','Cartão'),
                    (8,4,11,'PIX', NULL, null,'2022-10-11','PIX'),
                    (11,1,1,'NULL', 56879456, 'Nome no cartao','2022-10-11','Cartão');



desc seller;
select * from seller;
insert into seller (Socialname, CNPJ, CPF, rua, bairro, complemento, cidade, estado, cep)
			values ('Vendemax',null,300215298,'Av Altinopolis','Pedreira','1246','São Paulo','SP','89990000'),
					('Supervenda',null ,121256789,'Av Paulista','Centro','apto 203','Chapeco','SC','89990000'),
					('Logitec', null,883456789,'Rua dos Araças','Aeroporto','569','Curitiba','PR','89990000'),
					('Express', 131353990001-60, null, 'Rua XV de Maio','Novo Horizonte','658','Campinas','SP','89990000'),
					('Virtua', 536983990001-60, null,'Rua Bandeirantes','Centro','1266','Hortolandia','SP','89990000'),
					('Omicron', 898953990001-60, null, 'Rua Rio de Janeiro','Nova Mutum','15624','Umuarama','PR','89990000'),
					('Olix', 784512990001-60, null, 'Av Altinopolis','Pedreira','1246','São Paulo','SP','89990000');


desc supplier;
select * from supplier;
insert into supplier (Socialname, CNPJ, contact, street, district, complement, city, state, zip_code)
			values ('China Express',222253350001-60,99884455,'Av Altinopolis','Pedreira','1246','São Paulo','SP','89990000'),
					('Super Produtora',132253350001-60 ,99885566,'Av Paulista','Centro','apto 203','Chapeco','SC','89990000'),
					('ForMix', 199353350001-60,33557788,'Rua dos Araças','Aeroporto','569','Curitiba','PR','89990000'),
					('Malafaia', 131353350001-60, 33442254, 'Rua XV de Maio','Novo Horizonte','658','Campinas','SP','89990000'),
					('PLatinum', 536986880001-60, 33445566,'Rua Bandeirantes','Centro','1266','Hortolandia','SP','89990000'),
					('Omicron', 898953990001-60, 33449988, 'Rua Rio de Janeiro','Nova Mutum','15624','Umuarama','PR','89990000'),
					('Olix', 784512990001-60, 33445566, 'Av Altinopolis','Pedreira','1246','São Paulo','SP','89990000');


desc productseller;
select * from productseller;
select * from seller;
select * from product;


insert into productseller (idPSeller, idProduct, prodQuantity)
			values (1,11,234),
					(2,12,7),
                    (3,13,9),
                    (4,13,234),
                    (5,15,123),
                    (6,16,98),
                    (7,17,8),
                    (1,18,77),
                    (2,19,1),
                    (3,20,17),
                    (4,11,22),
                    (5,12,66),
                    (6,13,3),
                    (7,15,34),
                    (1,16,2),
                    (2,11,234),
                    (3,11,77);
                    

desc productstorage;
select * from productstorage;

insert into productstorage (idProdStorage, storagelocation, quantity)
			values (1,'Matriz',10),
					(2,'CD Rio',15),
                    (3,'Matriz',25),
                    (4,'CD Rio',8),
                    (5,'Matriz',7);
                  

desc productsuplier;
select * from productsuplier;
select * from supplier;
select * from product;

insert into productsuplier (idSupplier, idProduct)
			values (1,11),
					(2,12),
                    (3,13),
                    (4,14),
                    (5,15),
                    (6,16),
                    (7,17),
                    (1,18),
                    (2,19),
                    (3,20),
                    (4,11),
                    (5,12),
                    (6,13),
                    (7,14),
                    (1,15),
                    (2,16),
                    (3,17),
                    (4,18),
                    (5,19),
                    (6,20);
                    

desc storagelocation;
select * from storagelocation;
select * from product;
select * from productStorage;

insert into storageLocation (idLproduct, idLstorage, location)
			values (11,1, 'Centro de Distribuição - Matriz'),
					(12,2, 'Centro de Distribuição Rio de Janeiro'),
                    (14,1, 'Centro de Distribuição - Matriz'),
					(15,2, 'Centro de Distribuição Rio de Janeiro'),
                    (17,1, 'Centro de Distribuição - Matriz'),
					(18,2, 'Centro de Distribuição Rio de Janeiro');




-- Queries de consulta e recuperação dos dados
show tables;
select * from clients;
select * from orders;

-- contagem dos clientes cadastrados
select count(*) from clients;


-- Recuperando Cliente, Pedido e Status
select concat(Fname, ' ', Lname) as Cliente, idOrder as Pedido, orderStatus as Status_pedido
	from clients c, orders o
    where c.idClient = idOrderClient
    order by idOrder;
    
    
    
-- Quantidade de pedidos por clientes
select idClient, count(*) as Number_of_orders, concat(Fname, ' ', Lname) as Cliente from clients
					inner join orders ON idClient = idOrderClient
					inner join productOrder on idPOorder = idOrder
                    group by idClient;



-- Algum vendedor também é fornecedor?
show tables;
select * from seller;
select * from supplier;


-- Recuperando dados cadastrais de Vendedor que é ao mesmo tempo Fornecedor                
select idSeller as Vendedor, v.Socialname as Razao_social, v.CNPJ as CNPJ from seller v
				inner join supplier f on f.CNPJ = v.CNPJ
                order by idSeller; 






-- Recuperações simples com SELECT Statement
-- Filtros com WHERE Statement
-- Crie expressões para gerar atributos derivados
-- Defina ordenações dos dados com ORDER BY
-- Condições de filtros aos grupos – HAVING Statement
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados



-- Relação de produtos fornecedores e estoques;

select * from storagelocation; -- idLproduct
select * from product; -- idProdutc
select * from productstorage; -- idProdStorage

select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, quantity as Quantidade, location as Localizacao from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct
            inner join productstorage q on q.idProdStorage = s.idLstorage
            order by idProduct; 


     
-- Utilizando operadores e filtros            
select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, PoValue as Valor, rating, location as Localizacao
			from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct; 



-- Utilizando operadores e filtros -- CD Matriz
select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, PoValue as Valor, rating, location as Localizacao
			from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct
            where location = 'Centro de Distribuição - Matriz'; 


-- Recuperando produtos que possuem avaliação acima de 4
select * from product where rating > 4;


-- Recuperando quantidade de itens, Valor Maximo, Valor mínimo e valor médio dos produtos
select count(*) as quantidade, max(PoValue) as valor_maximo, min(PoValue) as valor_minimo,
    round(avg(PoValue),2) as Valor_medio from product
    order by idProduct;




-- Relação de nomes dos fornecedores e nomes dos produtos;
select r.idSupplier, p.idProduct, SocialName, CNPJ, Pname as Nome_produto, Category, PoDescription as Descricao_produto, PoValue as valor, rating
	from productsuplier r
	inner join supplier s on r.idSupplier = s.idSupplier
	inner join product p on r.idProduct = p.idProduct
    order by idSupplier;





-- Relação de nomes dos fornecedores e nomes dos produtos FILTRO POR CATEGORIA;
select r.idSupplier, p.idProduct, SocialName, CNPJ, Pname as Nome_produto, Category, PoDescription as Descricao_produto, PoValue as valor, rating
	from productsuplier r
	inner join supplier s on r.idSupplier = s.idSupplier
	inner join product p on r.idProduct = p.idProduct
    where category = 'Livros'
    order by idSupplier;




-- Relação de nomes dos fornecedores e nomes dos produtos FILTRO POR NOME DO FORNECEDOR;
select r.idSupplier, p.idProduct, SocialName, CNPJ, Pname as Nome_produto, Category, PoDescription as Descricao_produto, PoValue as valor, rating
	from productsuplier r
	inner join supplier s on r.idSupplier = s.idSupplier
	inner join product p on r.idProduct = p.idProduct
    where SocialName like 'O%'
    order by idSupplier;



