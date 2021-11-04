create database parcial_final;
create table clientes (
id_cliente int primary key,
nombre_cliente varchar (30),
tel_cliente int,
correo_cliente varchar (30),
cupo_individual int,
cupo_global int
);

insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(1,'Jairo Sarmiento',5687412,'jairos@correo.com',6000000,28400000,1121);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(2,'Isabel Dominguez',4568521,'isabel@correo.com',3000000,28400000,1122);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(3,'Lina Martinez',3659874,'lina@correo.com',3500000,28400000,1123);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(4,'Laura rodriguez',1259634,'laura@correo.com',2800000,28400000,1124);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(5,'sonia Arbelaez',2569874,'sonia@correo.com',3500000,28400000,1125);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(6,'Lucia Savogal',6589654,'lucia@correo.com',3800000,28400000,1126);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(7,'Alicia Machado',8529654,'alicia@correo.com',2600000,28400000,1127);
insert into clientes (id_cliente,nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values(8,'Carmen Corrales',8529223,'carmen@correo.com',3200000,28400000,1128);

create table dispositivos (
id_dispositivo int primary key
);
insert into dispositivos(id_dispositivo) values (1121);
insert into dispositivos(id_dispositivo) values (1122);
insert into dispositivos(id_dispositivo) values (1123);
insert into dispositivos(id_dispositivo) values (1124);
insert into dispositivos(id_dispositivo) values (1125);
insert into dispositivos(id_dispositivo) values (1126);
insert into dispositivos(id_dispositivo) values (1127);
insert into dispositivos(id_dispositivo) values (1128);

create table compras (
id_compra int primary key,
fecha datetime,
lugar varchar (20),
id_cliente int,
valor decimal
); 
set SQL_SAFE_UPDATES=0;

delimiter %%
create procedure compra (in pfecha datetime, in plugar varchar(20), in pid_cliente int, in pvalor decimal)
begin
if pvalor> 28440000 or pfecha > '2021-11-29 00:00:00'  and pfecha < '2021-11-30 23-59-59'
then
	select  '"El valor supera el cupo designado o la fecha de compra no está autorizada"' as '¡ERROR EN TRANSACCIÓN!';
else 
	insert into compras
    set
    fecha = fecha,
    lugar = plugar,
    id_cliente = pid_cliente,
	valor = pvalor;
end if;
end %%
delimiter %%


***compra test**
delimiter %%
create procedure compra_test (in pfecha datetime, in plugar varchar(20), in pid_cliente int, in pvalor decimal)
begin
if  pfecha =  LAST_DAY(date)
then
	select  '"El valor supera el cupo designado o la fecha de compra no está autorizada"' as '¡ERROR EN TRANSACCIÓN!';
else 
	insert into compras
    set
    fecha = fecha,
    lugar = plugar,
    id_cliente = pid_cliente,
	valor = pvalor;
end if;
end %%
delimiter %%


create view cupo as
select (cl.cupo_individual-co.valor) as cuporestante
from compras as co
inner join clientes as cl
on co.id_cliente = cl.id_cliente
where co.id_cliente = 


delimiter %%
create procedure conteo(in pid_cliente int, in pvalor int)
begin
declare cupoi int;
select cl.cupo_individual-co.valor into cupoi 
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
where co.id_cliente = pid_cliente;
select  cupoi;
end %%
delimiter %%

create trigger validar before insert on compras as co
inner join clientes as cl
on cl.id_cliente = co.id_cliente
if co.valor> cl.cupo_individual
then 
select 'El valor de la compra supera el cupo asignado'
else 
delimiter %%
create procedure compra (in pfecha datetime, in plugar varchar(20), in pid_cliente int, in pvalor decimal)
begin
declare cupo decimal;
select cl.cupo_individual - co.valor into cupo
from clientes as cl
join compras as co
on cl.id_cliente = co.id_cliente
where co.id_cliente = pid_cliente;
if pvalor> cupo
then
	select  cupo as cupo,'"El valor supera el cupo designado"' as '¡ERROR EN TRANSACCIÓN!';
else 
	insert into compras
    set
    fecha = pfecha,
    lugar = plugar,
    id_cliente = pid_cliente,
	valor = pvalor;
end if;
end %%
delimiter %%
drop procedure compra;

******/*Brindar reportes al cliente*/******

delimiter %%
create procedure reporte_G (in pnombre_cliente varchar (30))
begin
select cl.nombre_cliente,cl.id_dispositivo,co.fecha,co.lugar,co.valor
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
where pnombre_cliente = nombre_cliente;
end %%
delimiter %%

delimiter %%
create procedure reporte_2 (in fecha_inicial datetime, in fecha_final datetime)
begin
select cl.nombre_cliente AS Cliente,cl.id_dispositivo as Dispositivo,co.fecha as Fecha_Compra,co.lugar as Establecimiento,co.valor as Valor
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
where co.id_cliente = 2 and fecha between fecha_inicial and fecha_final
union
select '','','','TOTAL =', sum(valor)
from compras
where fecha between fecha_inicial and fecha_final;
end %%
delimiter %%
select * from compras
where fecha between fecha_inicial and fecha_final;
select '',sum(valor) as total

from compras

