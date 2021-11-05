create database parcial_final;
create table clientes (
id_cliente int primary key,
nombre_cliente varchar (30),
tel_cliente int,
correo_cliente varchar (30),
cupo_individual int,
cupo_global int,
id_dispositivo int
);

insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Jairo Sarmiento',5687412,'jairos@correo.com',6000000,28400000,1121);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Isabel Dominguez',4568521,'isabel@correo.com',3000000,28400000,1122);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Lina Martinez',3659874,'lina@correo.com',3500000,28400000,1123);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Laura rodriguez',1259634,'laura@correo.com',2800000,28400000,1124);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('sonia Arbelaez',2569874,'sonia@correo.com',3500000,28400000,1125);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Lucia Savogal',6589654,'lucia@correo.com',3800000,28400000,1126);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Alicia Machado',8529654,'alicia@correo.com',2600000,28400000,1127);
insert into clientes (nombre_cliente,tel_cliente,correo_cliente,cupo_individual,cupo_global,id_dispositivo)
values('Carmen Corrales',8529223,'carmen@correo.com',3200000,28400000,1128);

create table dispositivos (
id_dispositivo int primary key,
pin int
);
insert into dispositivos(id_dispositivo,pin) values (1121,2021);
insert into dispositivos(id_dispositivo,pin) values (1122,2022);
insert into dispositivos(id_dispositivo,pin) values (1123,2023);
insert into dispositivos(id_dispositivo,pin) values (1124,2024);
insert into dispositivos(id_dispositivo,pin) values (1125,2025);
insert into dispositivos(id_dispositivo,pin) values (1126,2026);
insert into dispositivos(id_dispositivo,pin) values (1127,2027);
insert into dispositivos(id_dispositivo,pin) values (1128,2028);

create table compras (
id_compra int primary key,
fecha datetime,
lugar varchar (20),
id_cliente int,
valor decimal,
pin int
); 
set SQL_SAFE_UPDATES=0;


select adddate(last_day(curdate()), 2)
select now()- interval day(now()) day
SELECT LAST_DAY('2021-10-15')

***compra test**
delimiter %%
create procedure compra_test (in FECHA datetime, in LUGAR varchar(20), in ID int, in VALOR decimal, in PIN int)
begin
declare p int;
declare f datetime;
SELECT di.pin into p
from dispositivos as di
inner join clientes as cl
on di.id_dispositivo = cl.id_dispositivo
where ID = cl.id_cliente;
set f = LAST_DAY(FECHA);
if FECHA = f 
THEN
SELECT ' LA FECHA DE COMPRA NO ESTÁ AUTORIZADA'as Alerta;
elseif
PIN != p
then
select 'Pin uncorrecto';
else
insert into compras
    set
    fecha = FECHA,
    lugar = LUGAR,
    id_cliente = ID,
	valor = VALOR;
END IF;
end
delimiter %%

delimiter %%
CREATE PROCEDURE compra(in FECHA datetime, in LUGAR varchar(20), in ID int, in VALOR decimal, in PIN int)
begin
declare c decimal;
SELECT cl.cupo_individual-sum(valor) into c
from clientes as cl inner join compras as co
on cl.id_cliente = co.id_cliente
where ID = cl.id_cliente;
if  VALOR > c
THEN
	select 'cupo excedido';
else
    insert into compras
    set
    fecha = FECHA,
    lugar = LUGAR,
    id_cliente = ID,
	valor = VALOR;
END IF;
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


*****Autorizar cupo******
delimiter %%
CREATE PROCEDURE aumentar_cupo(in ID int, in VALOR DECIMAL)
begin
DECLARE CUPO decimal;
declare sumacupo decimal;
select sum(cupo_individual) into sumacupo
from clientes;
SET CUPO = 28400000;
if
	sumacupo + VALOR > CUPO
	then
	select 'No puede exceder cupo global' AS '¡ALERTA!';
else
	update clientes
	set cupo_individual = cupo_individual+VALOR
WHERE 
id_cliente = ID;
end if;
END
DELIMITER %%
