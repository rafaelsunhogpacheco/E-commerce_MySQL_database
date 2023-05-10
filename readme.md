# Projeto DataBase MySQL E-commerce
Projeto banco de dados em MySQL para modelo de negócio E-Commerce

## Status do Projeto
Finalizado

![Modelo ER Entidade Relacionamento E-commerce](/src/ModeloER_E-commerce_final.png "E-Commerce")

## Conteúdo
1.  Modelo ER Entidade Relacionamento extendido
* EcommerceFinal.mwb
* Tambem disponível em pdf e png como imagens

2.  DataBase
Arquivo base de dados
* EcommerceFinal.mwb.bak

3.  Script de criação, população de dados e queries de consulta
Script para criação das tabelas, Inserção de dados para popular as tabelas, Queries de consulta
* ecommerce_script_final.sql


### Pré-requisitos 
Possuir o MySQL instalado na máquina.

### Features
1. Criar as tabelas
* Cliente
* Produto
* Entrega
* Pedido
* Pagamento
* Estoque
* Fornecedor
* Vendedor
* Produto x Vendedor
* Produto x Pedido
* Produto x Estoque
* Produto x Fornecedor

2. Popular tabelas
Inserindo dados nas tabelas

3. Realizar queries de consulta e recuperação de dados




### Queries de consulta e recuperação de dados
* Contagem dos clientes cadastrados
select count(*) from clients;


* Recuperando Cliente, Pedido e Status
select concat(Fname, ' ', Lname) as Cliente, idOrder as Pedido, orderStatus as Status_pedido
	from clients c, orders o
    where c.idClient = idOrderClient
    order by idOrder;
    
    
    
* Quantidade de pedidos por clientes
select idClient, count(*) as Number_of_orders, concat(Fname, ' ', Lname) as Cliente from clients
					inner join orders ON idClient = idOrderClient
					inner join productOrder on idPOorder = idOrder
                    group by idClient;



#### Algum vendedor também é fornecedor?
* Recuperando dados cadastrais de Vendedor que é ao mesmo tempo Fornecedor                
select idSeller as Vendedor, v.Socialname as Razao_social, v.CNPJ as CNPJ from seller v
				inner join supplier f on f.CNPJ = v.CNPJ
                order by idSeller; 






* Recuperações simples com SELECT Statement
* Filtros com WHERE Statement
* Crie expressões para gerar atributos derivados
* Defina ordenações dos dados com ORDER BY
* Condições de filtros aos grupos – HAVING Statement
* Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados



#### Relação de produtos fornecedores e estoques;
select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, quantity as Quantidade, location as Localizacao from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct
            inner join productstorage q on q.idProdStorage = s.idLstorage
            order by idProduct; 


     
* Utilizando operadores e filtros            
select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, PoValue as Valor, rating, location as Localizacao
			from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct; 



* Utilizando operadores e filtros -- CD Matriz
select idProduct as id_produto, Pname as Nome_item, Category, PoDescription as Descricao, PoValue as Valor, rating, location as Localizacao
			from  product p
			inner join storagelocation s on p.idProduct = s.idLProduct
            where location = 'Centro de Distribuição - Matriz'; 


* Recuperando produtos que possuem avaliação acima de 4
select * from product where rating > 4;


* Recuperando quantidade de itens, Valor Maximo, Valor mínimo e valor médio dos produtos
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

