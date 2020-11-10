use hotel_general;
insert into usuario values ("admin", "1234");
-- RRHH
insert into nivel_academico values ("1", "A", "descripcion");
insert into explab_detallado values ("1", "Exp1", "A", "1999/08/12", "2020/08/22");
insert into experiencia_laboral values ("1", "1");
insert into referenciasP values ("1", "Juan", "123");
insert into referenciasL values ("1", "Daniel", "456");
insert into puesto values ("1", "Puesto1", "ninguna", "A");
insert into departamento values ("1", "Depto1", "A");
insert into solicitud_empresarial values ("1", "20", "30", "M", "1", "1", "1","1", "ninguna");
insert into medio values ("1", "1", "Prensa", "ninguna");
insert into curriculum values ("125", "Daniel", "Hernandez", "852", "Jose@gmail.com", "ciudad", "M", "22", "1", "1", "1", "1", "1");
insert into curriculum values ("126", "Juan", "pedro", "123", "Juan@gmail.com", "ciudad", "M", "22", "1", "1", "1", "1", "1");
insert into aplicacion values ("1", "125", "S");
insert into tipo_pruebas values ("1", "psicologico");
insert into tipo_pruebas values ("2", "Poligrafo");
insert into aplicacion_prueba values ("1", "1", "1", "A");
insert into seleccion values ("1", "1", "A");
insert into actividad values ("1", "Prueba1", "A");
insert into actividad values ("2", "Prueba2", "A");
insert into periodo_prueba values ("1", "1", "2020/02/25", "2020/03/15", "100", "1");
insert into contratacion values ("1", "1", "2020/08/12", "10 meses", "A");
insert into empleado_contratado values ("1", "1", "1", "1", "5000");
insert into actividad_empleado values ("1",  "1");

-- Bancos 
insert into moneda values ("1", "Quetzal", "0", "A");
insert into moneda values ("2", "Dolar", "7.74", "A");
insert into moneda values ("3", "Euro", "9.20", "A");

-- Parte de contabilidad
insert into clasificacion_cuenta values ("1", "Corriente");
insert into clasificacion_cuenta values ("2", "No Corriente");
insert into clasificacion_cuenta values ("3", "Capital");

insert into cuenta_contable values ("1", "Caja", "Activo", "1", "0", "10000","500", "9500", "0", "0", "Contiene el efectivo" );

insert into Documento_bancario values ("01", "Cheque", "-", "A");

insert into concepto_bancario values ("1", "Pago a proveedor", "-", "A", "1");

insert into mov_bancEnc values ("1", "01", "2020/10/22", "1000", "Pago a office depot");
insert into mov_bancdet values ("1", "1", "1000", "Deudor");

-- Parte Administrativa

#inserts sucursal
insert into sucursal values ("0", "Norte", "Zona18", "telefono");

#insert linea
insert into linea values (0,"comida","1");
insert into linea values (0,"Electrica","1");
insert into linea values (0,"Blanca","1");
insert into linea values (0,"Vehiculos","1");

#insert marca
insert into marca values (0,"Toyota","1");
insert into marca values (0,"BMW","1");
insert into marca values (0,"Samsung","1");
insert into marca values (0,"Ideal","1");

#inserts PILOTO
insert into piloto VALUES(0,"1","12345","A","2021-01-05",500,"A");
insert into piloto VALUES(0,"1","54327","B","2022-03-07",500,"A");

#inserts BODEGA
insert into bodega VALUES(0,1,"Bodega 1","zona 5","D");
insert into bodega VALUES(0,1,"Bodega 2","zona 5","D");
insert into bodega VALUES(0,1,"Bodega 3","zona 6","D");
insert into bodega VALUES(0,1,"Bodega 4","zona 1","D");
insert into bodega VALUES(0,1,"Bodega 5","zona 2","D");

#Inserts tipo_inventario
insert into tipo_inventario values (0,"Inicial","1");
insert into tipo_inventario values (0,"Intermedio","1");
insert into tipo_inventario values (0,"Final","1");

#insert inventario
insert into inventario values (0,1,1,1,1,"Comida","A",600,650,10,"Pedidos en la barra o encargos","2020/05/12");
insert into inventario values (0,2,1,1,1,"Transporte","A",400,450,10,"servicio a disposicion de pedidos","2020/05/12");
insert into inventario values (0,3,1,1,1,"Lavanderia","A",450,500,10,"Prendas encargadas","2020/05/12");

insert into vehiculo values (0,1,2,1,4,"SK5D4","2010","Negro","4","1");
insert into vehiculo values (0,1,2,2,4,"GE5D4","2011","Negro","5","1");
insert into vehiculo values (0,1,2,1,4,"GE574","2015","Negro","5","1");

#inserts PROVEEDOR
insert into proveedor VALUES(0,"proveedor 1","zona 2");
insert into proveedor VALUES(0,"proveedor 2","zona 7");
insert into proveedor VALUES(0,"proveedor 3","zona 3");
insert into proveedor VALUES(0,"proveedor 4","zona 15");
insert into proveedor VALUES(0,"proveedor 5","zona 10");

#inserts de caja
INSERT INTO caja VALUES (0,"A","Caja General");
INSERT INTO caja VALUES (0,"A","Caja Chica");
INSERT INTO caja VALUES (0,"A","Caja 1");

#Inserts de serie
INSERT INTO serie VALUES(0,1,1,"1");
INSERT INTO serie VALUES(0,1,2,"2");

#inserts tipo_cliente
insert into tipo_cliente values (0, "Frecuente", "A");
insert into tipo_cliente values (0, "Normal", "A");
insert into tipo_cliente values (0, "Premium", "A");

#inserts cliente
insert into cliente values (0,1, "Ashly Barrios", "2017588-9", "ranbr@gmail.com", "54738829","Zona 5");
insert into cliente values (0,2, "Heydi Queme", "585956-8", "hsqa@gmail.com", "5472239","Zona 10");
insert into cliente values (0,2, "Kevin Flores","56565555-6", "kfka@gmail.com", "23471239","Zona 1");

#inserts IMPUESTO
insert into impuestos VALUES(0,"impuesto 1","A");
insert into impuestos VALUES(0,"impuesto 2","A");
insert into impuestos VALUES(0,"impuesto 3","A");
insert into impuestos VALUES(0,"impuesto 4","A");
insert into impuestos VALUES(0,"impuesto 5","A");

#inserts VENDEDOR
insert into vendedor VALUES(0,"1","vendedor1@email.com","12345678","zona 5",10.25,1000);

#inserts COBRADOR
insert into cobrador VALUES(0,1,"cobrador1@email.com","10298375","zona 1");

#inserts servicios
insert into servicios values (0,"masaje","A");
insert into servicios values (0,"transporte","A");

#inserts TIPO HABITACION
insert into tipo_habitacion VALUES(0,"Habitacion pequeña","Habitación pequeña para una sola persona y sin acceso a aire acondicionado.","1 cama, 1 sofá, 1 baño, 1 cocina pequeña.",150,1);
insert into tipo_habitacion VALUES(0,"Habitacion mediana","Habitación mediana para tres personas con acceso a aire acondicionado.","3 camas, 1 juego de 3 sofás, 3 baños, 1 cocina.",400,3);
insert into tipo_habitacion VALUES(0,"Habitacion grande","Habitación grande para cinco personas con acceso a aire acondicionado.","5 camas, 1 juego de 3 sofás, 3 baño, 1 cocina.",700,5);
insert into tipo_habitacion VALUES(0,"Habitacion tipo suite","Habitación tipo suite para ocho personas que puede o no tener acceso a aire acondicionado.","8 camas, 1 juego de 4 sofás, 5 baños, 1 cocina grande.",1200,8);

#inserts HABITACION
insert into habitacion VALUES(0,1,1,"D");
insert into habitacion VALUES(0,2,1,"D");
insert into habitacion VALUES(0,3,1,"D");
insert into habitacion VALUES(0,4,1,"D");
insert into habitacion VALUES(0,1,1,"D");

#inserts SALON
insert into salon VALUES(0,"Salon 1", 2000, 1, 800, "D");
insert into salon VALUES(0, "Salon 2", 3000, 1, 900, "D");
insert into salon VALUES(0, "Salon General", 7000, 2, 1000, "D");

#insert aplicacion_tipo_parametro
insert into aplicacion_tipo_parametro values (0,"Todos","A");
insert into aplicacion_tipo_parametro values (0,"Algunos","A");

#insert tipo_parametro
insert into tipo_parametro values (0,1,"Venta","A");

#insert parametro
insert into parametros values (0,1,"Devolucion","50","A");
insert into parametros values (0,1,"Daño","100","A");
insert into parametros values (0,1,"Robo","150","A");

#Inserts lavanderia
INSERT INTO lavanderia VALUES (0,"Lavanderia Lola", 1, "A");
INSERT INTO lavanderia VALUES (0,"Lavanderia Cabo", 1, "A");
INSERT INTO lavanderia VALUES (0,"Lavanderia Fuelte", 1, "A");

#Inserts prenda
INSERT INTO prenda VALUES (0, 3, "Pantalones", '2020/08/10', '17:25:32.1212222');
INSERT INTO prenda VALUES (0, 2, "Playeras", '2020/08/10', '17:25:32.1212222');

#inserts tipo_precio
insert into tipo_precio values (0,1, "Lavanderia", "A");
insert into tipo_precio values (0,1, "Restaurante", "A");
insert into tipo_precio values (0,1, "Servicio", "A");

#inserts lista_precio
insert into lista_precio values (0,1,1, 22.26, 5.2);
insert into lista_precio values (0,1,2, 2.26, 5.2);
insert into lista_precio values (0,2,1, 22.26, 5.2);

#inserts descuento
insert into descuento values (0,"Promocion",10,2);
insert into descuento values (0,"Pago al contado",7,2);

#inserts ventas
insert into venta_encabezado values(1,1,1,1,1,100,"2020-11-01");
insert into venta_detalle values(1,1,1,1,100);

insert into compra_encabezado values(1,1,1,100,"2020-11-01");
insert into compra_encabezado values(2,1,2,100,"2020-12-01");
insert into compra_detalle values(1,1,1,100);
insert into compra_detalle values(2,1,1,10);

insert into tipo_pago_credito values(1, "tarjeta", "A");
insert into tipo_pago_credito values(2, "cheque", "A");
insert into tipo_pago_credito values(3, "efectivo", "A");

insert into usuario_hoteleria values("1", "zuzu", "123", "1", "A");

insert into bitacora values("0", "1", "Ingresó al programa", "2020-11-09", "13:17:00");

select * from hotel_general.bitacora;
