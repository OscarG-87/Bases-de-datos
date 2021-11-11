create database inventario;
insert into marca (nombre_marca) values ('cocacola');

insert into cliente (nombre_cliente,telefono_cliente,correo_cliente) values ('Oscar Galvis', 6542135,'micorreo@gmail.com');

insert into producto(nombre_producto,descripcion,precio,ubicación,unidad_medida,id_marca,id_cliente) 
values('cocacola','bebida carbonatada en botella',2500,'A-54','litros',1,1);

insert into proveedor (nombre_proveedor,nit,direccion_proveedor,correo_proveedor,ciudad_proveedor,id_marca) 
values('importaciones L&M',552748-5,'Calle 4 # 45-98','l&m@gmail.com','Bogotá',1);
select * from proveedores
set SQL_SAFE_UPDATES=0;

delete from proveedores
select * from proveedores;
select * from producto
select * from cliente;
select * from marca;