 create user 'lais1'@'localhost' identified by 'senha';
 grant all privileges on *.* to 'lais1'@'localhost';
 flush privileges;


CREATE DATABASE loja;
##select * from mysql.user;

CREATE TABLE clientes(
id int auto_increment primary key,
nome varchar(100) not null,
email varchar(100) not null);

##ALTER TABLE clientes DROP COLUMN cpf;

create table pedidos(
id int auto_increment primary key,
cliente_id int not null,
descricao varchar(225)not null,
valor varchar(10) not null,

constraint fk_pedidos_cliente
foreign key (cliente_id) references clientes(id)
);
