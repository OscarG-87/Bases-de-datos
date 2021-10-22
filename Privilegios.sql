create user 'Coordinador'@'localhost' identified by 'Coordinador123'; 
create user 'Profesor'@'localhost' identified by 'Profesor123'; 
create user 'Estudiante'@'localhost' identified by 'Estudiante123'; 
grant select,update,execute on *.* to Coordinador@localhost;
grant select,update,execute on *.* to Profesor@localhost;
grant select,execute on *.* to Estudiante@localhost;

****COORDINADOR*****
1. Ingresa, borra y actualiza información  de los estudiantes y sus carreras.
drop procedure Modificar_Info_Estudiantes
delimiter //
create procedure Modificar_Info_Estudiantes (in pcod_e int, in pdir_e varchar(50), in tel_e int, in id_carr int)
begin
update estudiantes
set 
dir_e = pdir_e,
tel_e = ptel_e,
id_carr = pid_carr
where
cod_e = pcod_e;
end //
delimiter //
select * from Estudiantes;
set SQL_SAFE_UPDATES=0;
call Modificar_Notas(4,'Calle 45 # 40-65',3358796,2);

2. Puede Borrar y modificar las notas de los estudiantes y sus carrearas (inscribe-estudiantes)
delimiter //
create procedure Modificar_Notas_Carreras_Estudiantes (in pcod_e int, in pid_carr int, in pn1 int, in pn2 int, in pn3 int)
begin
update estudiantes as est
inner join inscribe as ins
on est.cod_e = ins.cod_e
set 
est.id_carr = pid_carr,
ins.n1 = pn1,
ins.n2 = pn2,
ins.n3 = pn2
where
est.cod_e = pcod_e;
end //
delimiter //
call Modificar_Notas_Carreras_Estudiantes(11,5,4,4,4);

3. Administra la información de las asignaturas que imparten los profesores y los grupos(imparte)
delimiter //
Create procedure Actualizar_Asignaturas_Grupos (in pid_p int, pcod_a int, in pcurso int, in phorario varchar (15))
begin
update imparte
set
cod_a = pcod_a,
curso = pcurso,
horario = phorario
where id_p = pid_p;
end //
delimiter //
call Actualizar_Asignaturas_Grupos (4,20,600,'Tarde');
call Actualizar_Asignaturas_Grupos (4,7,625,'Mañana');
drop procedure Actualizar_Asignaturas_Grupos;


******PROFESOR*****
4. Ingresa y actualiza las notas de sus estudiantes y sus asignaturas (imparte)
delimiter //
create procedure Actualizar_Notas_Asignaturas (in pcod_e int, in pcod_a int, in pn1 int, in pn2 int, in pn3 int)
begin
update inscribe
set
n1 = pn1,
n2 = pn2,
n3 = pn3
where 
cod_e = pcod_e and cod_a = pcod_a;
end //
delimiter //

drop procedure Actualizar_Notas_Asignaturas
call Actualizar_Notas_Asignaturas (6,1,5,5,5);
call Actualizar_Notas_Asignaturas (6,1,2,5,5)

5. Puede consultar la lista de estudiantes de sus cursos
Create view Consultar_Estudiantes_grupos as
select est.cod_e, est.nombre_e, ins.cod_a, ins.grupo
from estudiantes as est
inner join inscribe as ins
on est.cod_e = ins.cod_e
where ins.grupo like 'N233'




*****ESTUDIANTE*****
6. Puede consultar sus notas
delimiter //
Create procedure Consultar_Notas (in pcod_e int)
begin
Select est.cod_e, est.nombre_e, asi.nom_a, ins.n1, ins.n2, ins.n3
from estudiantes as est
inner join inscribe as ins
on est.cod_e = ins.cod_e
inner join asignaturas as asi
on ins.cod_a = asi.cod_a
where est.cod_e = pcod_e
group by asi.nom_a;
end //
delimiter //

drop procedure Consultar_Notas;
call Consultar_Notas (3)

7.Puede consultar los docentes asignados
delimiter //
create procedure Consultar_Docentes_Asignados (in pcod_e int)
begin
select nom_a, grupo, nom_p
from asignaturas as asi
inner join inscribe as ins
on asi.cod_a = ins.cod_a
inner join profesores as pro
on ins.id_p = pro.id_p
where ins.cod_e =pcod_e;
end //
Delimiter //
call Consultar_Docentes_Asignados (12);
drop procedure Consultar_Docentes_Asignados
