--create table profile(zero smallINT,gênero char(1), idade smallint, id varchar(100), membresia int, salário real);
--copy profile from 'D:\Bruna\Desktop\SQL\Starbucks\profile.csv' delimiter ',' csv header ;
--select * from profile fetch first 5 rows only;

-- create table portfolio(zero smallint, comissão smallint, canais varchar(100), dificuldade smallint, duração smallint, oferta char(20), id varchar(100));
-- copy portfolio from 'D:\Bruna\Desktop\SQL\Starbucks\portfolio.csv' delimiter ',' csv header;
--select * from portfolio;

-- drop table transcript;
-- create table transcript(id int,person varchar(100),events char(30),transactions varchar(100),horas smallint);
-- copy transcript from 'D:\Bruna\Desktop\SQL\Starbucks\transcript.csv' delimiter ',' csv header ;
SELECT * FROM transcript FETCH FIRST 5 ROWS ONLY;
-- alter table transcript add column copia_transactions varchar(100);
-- update transcript set copia_transactions=transactions;

--update transcript set transactions=trim(trailing '}' from substring(transactions from 1 for position(':' in transactions)-1)) where position(':' in transactions)<0;

-- UPDATE transcript
-- SET transactions = LEFT(transactions, LENGTH(transactions) - 2)
-- WHERE transactions LIKE '%''%''}';
SELECT * FROM portfolio;
SELECT * FROM profile;

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
SELECT events,count(events) AS "qtd enviada" FROM transcript GROUP BY events;
--quantidade de ofertas enviadas para mulheres 
-- select t.events, count(t.events) as "qtd enviada para mulheres" from transcript as t inner join profile as p on t.person=p.id where p.gênero='F' group by events;
-- esta forma mostra apenas os resultados para um gênero de cada vez, seria necessário escrever uma querie para cada gênero
-- a window function mostra o resultado para cada linha, o que dificulta a visualização, por isso, testei de outra forma ainda
-- select p.gênero, t.events, count(t.events) over(partition by t.events,p.gênero )from transcript as t inner join profile as p on t.person=p.id;
-- esta forma resume adequadamente os resultados por gÊnero e oferta
SELECT p.gênero,t.events, count(t.events) AS "qtd_ofertas" FROM transcript AS t INNER JOIN profile AS p ON t.person=p.id GROUP BY t.events,p.gênero;
SELECT * FROM transcript WHERE events LIKE '%transaction%';

SELECT p.gênero, 