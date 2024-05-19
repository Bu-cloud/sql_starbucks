--create table profile(zero smallINT,gênero char(1), idade smallint, id varchar(100), membresia int, salário real);
--copy profile from 'D:\Bruna\Desktop\SQL\Starbucks\profile.csv' delimiter ',' csv header ;
--select * from profile fetch first 5 rows only;

-- create table portfolio(zero smallint, comissão smallint, canais varchar(100), dificuldade smallint, duração smallint, oferta char(20), id varchar(100));
-- copy portfolio from 'D:\Bruna\Desktop\SQL\Starbucks\portfolio.csv' delimiter ',' csv header;
--select * from portfolio;

-- drop table transcript;
-- create table transcript(id int,person varchar(100),events char(30),transactions varchar(100),horas smallint);
-- copy transcript from 'D:\Bruna\Desktop\SQL\Starbucks\transcript.csv' delimiter ',' csv header ;
-- select * from transcript fetch first 5 rows only;
-- alter table transcript add column copia_transactions varchar(100);
-- update transcript set copia_transactions=transactions;

--update transcript set transactions=trim(trailing '}' from substring(transactions from 1 for position(':' in transactions)-1)) where position(':' in transactions)<0;

-- UPDATE transcript
-- SET transactions = LEFT(transactions, LENGTH(transactions) - 2)
-- WHERE transactions LIKE '%''%''}';
-- select * from portfolio;
-- select * from profile;

-- id de portfolio com id de transcript

-- select copia_transactions,substring(copia_transactions,position(':'in copia_transactions)+3,length('5a8bc65990b245e5a138643cd4eb9837')) from transcript where copia_transactions like '%reward%';

--alter table transcript add column id_oferta varchar(100);
-- pega os caracteres após : de comprimento igual ao id na tabela portfolio e adiciona à coluna id_oferta
--update transcript set id_oferta=substring(copia_transactions,position(':'in copia_transactions)+3,length('5a8bc65990b245e5a138643cd4eb9837')) where copia_transactions like '%offer%';

-- alter table transcript add column reward smallint;
-- pega apenas um ou mais digitos após a pavra reward:, converte para inteiro e adiciona na nova coluna reward
-- update transcript set reward=cast(substring(transactions from 'reward'': (\d+)') as smallint) where transactions like '%reward%';


-- alter table transcript add column amount float;
-- tira o ultimo caracter } da coluna nas linhas que tem amount
-- UPDATE transcript SET copia_transactions = LEFT(copia_transactions, LENGTH(copia_transactions) - 1) WHERE copia_transactions LIKE '%amount%';
-- pega todos os caracteres apos o : da coluna copia nas linhas que consta amount e adiciona na coluna amount
-- update transcript set amount=cast( substring(copia_transactions, position(': ' in copia_transactions)+1) as float) where copia_transactions like '%amount%';

-- select amount from transcript where amount is not null;
-- select port.comissão,transc.amount from portfolio as port join transcript as transc on transc.id_oferta=port.id ;
-- 
-- calculo de quantas ofertas de cada id foram feitas
-- select sum( case when id_oferta = 'ae264e3637204a6fb9bb56bc8210ddfd' then 1 else 0 end) as "soma primeiro id",
--  sum( case when id_oferta = '4d5c57ea9a6940dd891ad53e9dbe8da0' then 1 else 0 end) as "soma segundo id",
--  sum(case when id_oferta = '3f207df678b143eea3cee63160fa8bed' then 1 else 0 end) as "soma 3 id",
--  sum(case when id_oferta = '9b98b8c7a33c4b65b9aebfe6a799e6d9' then 1 else 0 end) as "soma 4 id",
--  sum(case when id_oferta = '0b1e1539f2cc45b7b9fa7c272da2e1d7' then 1 else 0 end) as "soma 5 id",
--  sum(case when id_oferta = '2298d6c36e964ae4a3e7e9706d1fb8c2' then 1 else 0 end) as "soma 6 id",
--  sum(case when id_oferta = 'fafdcd668e3743c1bb461111dcafc2a4' then 1 else 0 end) as "soma 7 id",
--  sum(case when id_oferta = '5a8bc65990b245e5a138643cd4eb9837' then 1 else 0 end) as "soma 8 id",
--  sum(case when id_oferta = 'f19421c1d4aa40978ebb69ca19b0e20d' then 1 else 0 end) as "soma 9 id",
--  sum(case when id_oferta = '2906b810c7d4411798c6938adc9daaa5' then 1 else 0 end) as "soma 10 id"
-- from transcript;


-- temos 10.95% de ofertas com reward e 45.33% com valor da transação, pega o maior id para saber o numero de linhas
-- Select count(reward) as "ofertas com reward" from transcript;
-- Select count(amount) as "ofertas com amount" from transcript;
-- select max(id) from transcript;

-- conta a quantidade de ofertas disparadas por id
-- select id_oferta, count(id_oferta) AS "quantidade de ofertas" from transcript group by id_oferta;

-- contando clientes por gênero
-- a maioria das pessoas é homem, representando 57.23% do total, enquanto 1.43% tem gênero outro, e 41,34% é feminino
-- select gênero, count(gênero) as "quantidade de pessoas" from profile group by gênero;


-- contando todos os clientes com idade errada
-- select count(idade) from profile where idade =118;

-- contando as idades dos clientes por grupo
-- os grupos dos adultos e dos idosos estão empatados (diferença de 0,16%) no primeiro lugar com 39.6% e 39.5%, enquanto os jovens são 21%, sem contar os registros com idade errada
-- select sum( case when idade < 18 then 1 else 0 end ) as "menores de idade",
--         sum(case when idade>=18 and idade<40 then 1 else 0 end) as "jovens",
--         sum (case when idade>=40 and idade < 60 then 1 else 0 end ) as "adultos",  sum(case when idade>=60 and idade<118 then 1 else 0 end) as "idosos" from profile;
--  
-- separa em colunas de dia, mês e ano a data de entrada na membresia
-- alter table profile add column dia char(2);
-- update profile set dia = substring(cast(membresia as char(8)),7,2);
-- alter table profile alter column dia type int2 using dia::int2;
-- 
-- alter table profile add column mes int2;
-- update profile set mes = cast(substring(cast(membresia as char(8)),5,2) as int2);
-- 
-- alter table profile add column ano int2;
-- update profile set ano =cast(substring(cast(membresia as char(8)),1,4) as int2);
-- select * from transcript as t inner join portfolio as p on t.id_oferta=p.id;

-- qual gênero mais compra e em qual tipo de oferta?
-- select events,count(events) as "qtd enviada" from transcript group by events;
--quantidade de ofertas enviadas para mulheres 
-- select t.events, count(t.events) as "qtd enviada para mulheres" from transcript as t inner join profile as p on t.person=p.id where p.gênero='F' group by events;
-- esta forma mostra apenas os resultados para um gênero de cada vez, seria necessário escrever uma querie para cada gênero
-- a window function mostra o resultado para cada linha, o que dificulta a visualização, por isso, testei de outra forma ainda
-- select p.gênero, t.events, count(t.events) over(partition by t.events,p.gênero )from transcript as t inner join profile as p on t.person=p.id;
-- esta forma resume adequadamente os resultados por gÊnero e oferta
-- select p.gênero,t.events, count(t.events) as "qtd_ofertas" from transcript as t inner join profile as p on t.person=p.id group by t.events,p.gênero;
-- select * from transcript where events like '%transaction%';

-- pergunta 1 What is the distribution of customers in each age category according to their gender type? Tem mais adultos no outros e homens, e mais mulheres idosas
-- select gênero, sum(case when idade>=18 and idade<40 then 1 else 0 end) as "jovens",
--         sum (case when idade>=40 and idade < 60 then 1 else 0 end ) as "adultos",  sum(case when idade>=60 and idade<118 then 1 else 0 end) as "idosos" from profile group by gênero;
        
 -- pergunta 2: What is the distribution of each offer type in each age category ?
--  select p.oferta,sum(case when pro.idade>=18 and pro.idade<40 then 1 else 0 end) as "jovens",
--         sum (case when pro.idade>=40 and pro.idade < 60 then 1 else 0 end ) as "adultos", 
--          sum(case when pro.idade>=60 and pro.idade<118 then 1 else 0 end) as "idosos"
--          from transcript as t
--         inner join portfolio as p on t.id_oferta=p.id
--         inner join profile as pro on pro.id=t.person
--         group by p.oferta;
 
 --Q3 — Based on the demographic data of the customers who gets the highest income , males or females or others?
 -- A: mulheres
--  select gênero,avg(salário) as "média" ,max(salário) as "máximo salário da categoria" from profile where idade<118 group by gênero;
 
 -- Q4 — How many new members Starbucks got each year?
--  select ano,count(ano) from profile group by ano order by ano asc;
 
 --Q5 — What is the distribution of the offers that each gender receive 
-- select p.oferta,count(p.oferta),pro.gênero
--          from profile as pro
--         inner join transcript as t on pro.id=t.person
--         inner join portfolio as p on t.id_oferta=p.id
--         group by p.oferta, pro.gênero;

--Q6 — What is the completion rate of each offer for gender type, age category and income category for each offer type?
-- 

-- 


-- select profile.gênero, portfolio.oferta, 100*sum(case when t.events='offer completed' then 1 else 0 end)/sum(count(t.events)) over() from transcript as t inner join profile on profile.id=t.person
-- inner join portfolio on portfolio.id=t.id_oferta
--  where t.events='offer completed' group by profile.gênero, t.events, portfolio.oferta 
--  order by portfolio.oferta;
-- 
-- 
-- 
-- 
-- select portfolio.oferta, t.events, 100*sum(case when p.idade <40  then 1 else 0 end)/33579 as "ofertas completas dos jovens",
--  100*sum(case when (p.idade >=40 and p.idade<60) then 1 else 0 end)/33579 as "ofertas completas dos adultos",
-- 100*sum(case when (p.idade >=60 and p.idade<118 ) then 1 else 0 end)/33579 as "ofertas completas dos idosos"
--  from profile as p inner join transcript as t on t.person=p.id INNER JOIN portfolio on portfolio.id=t.id_oferta
--   where t.events='offer completed' 
--   group by portfolio.oferta, t.events;
--  
-- 
-- select portfolio.oferta, 100*sum(case when (p.salário<=50000 ) then 1 else 0 end)/count(p.salário) as "faixa salarial 1",
--  100*sum(case when (p.salário >50000 and p.salário<=70000) then 1 else 0 end)/count(p.salário) as "faixa salarial 2",
-- 100*sum(case when (p.salário >70000 and p.salário<=90000) then 1 else 0 end)/count(p.salário) as "faixa salarial 3",
-- 100*sum(case when (p.salário >90000 and p.salário<=110000) then 1 else 0 end)/count(p.salário) as "faixa salarial 4",
-- 100*sum(case when (p.salário >110000) then 1 else 0 end)/count(p.salário) as "faixa salarial 5"
--  from profile as p 
--  inner join transcript as t on t.person=p.id
--  inner join portfolio on portfolio.id=t.id_oferta
--   where t.events='offer completed'
--   group by portfolio.oferta;
--  
-- Q: qual a taxa média de completude de oferta por cliente por gênero?
-- select id_oferta,sum(case when events='offer viewed' then 1 else 0 end) as "vistas",sum(case when events='offer completed' then 1 else 0 end) as "completadas", person as "pessoa" from transcript group by transcript.id_oferta,person ;
-- select sum(case when profile.idade<40 then 1 else 0 end) from profile where ;

--Q7 — What is the completion rate of each offer type with and without view in each age and income category?
-- com view e completa por idade
-- select portfolio.oferta as "oferta vista e completa", 100*sum(case when profile.idade
-- <40 then 1 else 0 end)/3100 as " total de jovens", 100*sum(case when profile.idade>=40 and profile.idade<60 then 1 else 0 end)/5850 as "total de adultos", 100*sum(case when profile.idade>=60 and profile.idade<118 then 1 else 0 end)/5875 as "total de idosos"  from(
--     select id_oferta,sum(case when events='offer viewed' then 1 else 0 end) as "vistas",
--     sum(case when events='offer completed' then 1 else 0 end) as "completadas", person as "pessoa"
--     from transcript group by transcript.id_oferta, person) 
-- my_table 
-- inner join profile on profile.id=my_table.pessoa
-- inner join portfolio on portfolio.id=my_table.id_oferta
-- where my_table.completadas=1 and my_table.vistas=1
-- group by portfolio.oferta;
-- 
-- sem view e completa
-- select portfolio.oferta AS "oferta não vista e completa", sum(case when profile.idade
-- <40 then 1 else 0 end) as " total de jovens", sum(case when profile.idade>=40 and profile.idade<60 then 1 else 0 end) as "total de adultos", sum(case when profile.idade>=60 and profile.idade<118 then 1 else 0 end) as "total de idosos"  from(
-- select id_oferta,sum(case when events='offer viewed' then 1 else 0 end) as "vistas",
-- sum(case when events='offer completed' then 1 else 0 end) as "completadas"
-- from transcript group by transcript.id_oferta) my_table 
-- inner join profile on profile.id=my_table.pessoa
-- inner join portfolio on portfolio.id=my_table.id_oferta
-- where my_table.completadas=1 and my_table.vistas=0
-- group by portfolio.oferta;
-- 

-- 3100 abaixo de 40, 5850 abaixo de 60, 5875 acima de 60 tirando o erro

-- select portfolio.oferta, 100*sum(case when (p.salário<=50000 ) then 1 else 0 end)/count(p.salário) as "faixa salarial 1",
--  100*sum(case when (p.salário >50000 and p.salário<=70000) then 1 else 0 end)/count(p.salário) as "faixa salarial 2",
-- 100*sum(case when (p.salário >70000 and p.salário<=90000) then 1 else 0 end)/count(p.salário) as "faixa salarial 3",
-- 100*sum(case when (p.salário >90000 and p.salário<=110000) then 1 else 0 end)/count(p.salário) as "faixa salarial 4",
-- 100*sum(case when (p.salário >110000) then 1 else 0 end)/count(p.salário) as "faixa salarial 5" FROM (
--         select id_oferta,sum(case when events='offer viewed' then 1 else 0 end) as "vistas",
--     sum(case when events='offer completed' then 1 else 0 end) as "completadas", person as "pessoa"
--     from transcript group by transcript.id_oferta, person) 
-- my_table 
-- inner join profile on profile.id=my_table.pessoa
-- inner join portfolio on portfolio.id=my_table.id_oferta
-- where my_table.completadas=1 and my_table.vistas=1
-- group by portfolio.oferta;
SELECT count(salário<50000) FROM profile;
SELECT * FROM transcript FETCH FIRST 5 ROWS ONLY;
SELECT * FROM portfolio;
SELECT events,count(events) FROM transcript GROUP BY events;