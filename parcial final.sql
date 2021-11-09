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


delimiter %%
CREATE PROCEDURE compra(in FECHA datetime, in LUGAR varchar(20), in ID int, in VALOR decimal, in PIN int)
begin
declare p int;
declare f datetime;
declare c decimal;
SELECT 
    cl.cupo_individual - SUM(co.valor)
INTO c FROM
    clientes AS cl
        INNER JOIN
    compras AS co ON cl.id_cliente = co.id_cliente
WHERE
    ID = cl.id_cliente;
SELECT 
    di.pin
INTO p FROM
    dispositivos AS di
        INNER JOIN
    clientes AS cl ON di.id_dispositivo = cl.id_dispositivo
WHERE
    ID = cl.id_cliente;
set f = LAST_DAY(FECHA);
if FECHA = f 
	THEN
	select' La fecha de compra no está autorizada' as TRANSACCIÓN_RECHAZADA;
elseif
	PIN != p
	then
	seLECT 'Pin incorrecto' as TRANSACCIÓN_RECHAZADA;
elseif 
	VALOR > c
	then
	select 'Cupo excedido' as TRANSACCIÓN_RECHAZADA;
else
	select 'Compra finalizada' as TRANSACCIÓN_EXITOSA;
insert into compras
    set
    fecha = FECHA,
    lugar = LUGAR,
    id_cliente = ID,
	valor = VALOR;
END IF;
end %%
delimiter %%

/*Brindar reportes al cliente*/

delimiter %%
create procedure Reporte_Compras (in CEDULA int,in fecha_inicial datetime, in fecha_final datetime)
begin
select cl.nombre_cliente AS Cliente,cl.id_dispositivo as Dispositivo,co.fecha as Fecha_Compra,co.lugar as Establecimiento,co.valor as Valor
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
where co.id_cliente = CEDULA 
union
select '','','','TOTAL =', sum(valor)
from compras
where fecha between fecha_inicial and fecha_final and id_cliente = CEDULA;
end %%
delimiter %%


/*Autorizar cupo*/
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
