
create database hotel;
use hotel;

create table sucursal (
id_sucursal int auto_increment primary key,
nombre varchar(20) not null,
direccion varchar(20) not null,
telefono varchar(20) not null
)engine=Innodb default charset=latin1;

create table linea (
id_linea int auto_increment primary key,
nombre varchar(20) not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table marca (
id_marca int auto_increment primary key,
nombre varchar(20) not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table piloto (
id_piloto int auto_increment primary key,
id_empleado varchar(10) not null,
numero_licencia varchar(20) not null,
tipo_licencia int not null,
fehca_vencimiento_licencia date not null,
viatico double not null,
estatus varchar(1) not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine=Innodb default charset=latin1;

create table bodega (
id_bodega int auto_increment primary key,
id_sucursal int not null,
nombre varchar(20) not null,
direccion varchar(40) not null,
estatus varchar(1) not null,
foreign key(id_sucursal) references
sucursal(id_sucursal)
)engine=Innodb default charset=latin1;

create table tipo_inventario (
id_tipo_inventario int auto_increment primary key,
nombre varchar(20) not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table inventario (
id_inventario int auto_increment primary key,
id_tipo_inventario int not null,
id_bodega int not null,
id_marca int not null,
id_linea int not null,
nombre varchar(20) not null,
estatus varchar(1) not null,
precio double not null,
costo double not null,
existencia int not null,
descripcion varchar(50) not null,
fecha_vencimiento date not null,
foreign key(id_marca) references
marca(id_marca),
foreign key(id_linea) references
linea(id_linea),
foreign key(id_tipo_inventario) references
tipo_inventario(id_tipo_inventario),
foreign key(id_bodega) references
bodega(id_bodega)
)engine=Innodb default charset=latin1;

create table vehiculo (
id_vehiculo int auto_increment primary key,
id_piloto int not null,
id_inventario int not null,
id_marca int not null,
id_linea int not null,
placa varchar(7) not null,
modelo int not null,
color varchar(10) not null,
numero_pasajeros int not null,
estatus varchar(1) not null,
foreign key(id_piloto) references
piloto(id_piloto),
foreign key(id_inventario) references
inventario(id_inventario),
foreign key(id_marca) references
marca(id_marca),
foreign key(id_linea) references
linea(id_linea)
)engine=Innodb default charset=latin1;

create table proveedor(
id_proveedor int auto_increment primary key,
nombre varchar(128) not null,
direccion varchar(128) not null
)engine=Innodb default charset=latin1;

create table caja(
id_caja int auto_increment primary key,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table serie(
id_serie int auto_increment primary key,
id_sucursal int not null,
id_caja int  not null,
tipo Varchar(2) not null,
foreign key (id_sucursal) references
sucursal(id_sucursal),
foreign key (id_caja) references
caja(id_caja)
)engine=Innodb default charset=latin1;

create table mov_transporte(
id_mov_transporte int auto_increment primary key,
id_vehiculo int not null,
id_piloto int not null,
fecha_ingreso date not null,
fecha_sailida date not null,
hora_inico time not null,
hora_final time not null,
kilometraje_salida double not null,
kilometraje_entrada double not null,
ubicacion varchar(50) not null,
estatus varchar(1) not null,
foreign key (id_piloto) references
piloto(id_piloto)
)engine=Innodb default charset=latin1;


create table compra_encabezado(
id_compraE int not null auto_increment primary key,
id_sucursal int not null,
id_proveedor int not null,
total double ,
fecha date not null,
foreign key (id_proveedor) references
proveedor(id_proveedor),
foreign key (id_sucursal) references
sucursal(id_sucursal)
)engine=Innodb default charset=latin1;

create table compra_detalle(
id_inventario int primary key not null,
id_compraE int not null,
id_moneda varchar(10) not null,
cantidad int not null,
foreign key (id_inventario) references
inventario(id_inventario),
foreign key (id_compraE) references
compra_encabezado(id_compraE),
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;


create table credito_proveedor(
id_credito_proveedor int  auto_increment,
id_proveedor int not null,
id_sucursal int not null,
id_compraE int not null,
id_moneda varchar(10) not null,
porcentaje double,
interes double,
cuota double not null,
pago_acumulado double not null,
tiempo_pago int not null,
tipo_tiempo varchar(80) not null,
forma_pago varchar(80) not null,
total double not null,
fecha_inicio date not null,
fecha_final date not null,
foreign key (id_proveedor) references
proveedor(id_proveedor),
foreign key (id_sucursal) references
sucursal(id_sucursal),
foreign key (id_compraE) references
compra_encabezado(id_compraE),
foreign key(id_moneda) references
moneda(id_moneda),
primary key(id_credito_proveedor,id_proveedor,id_sucursal,id_compraE)
)engine=Innodb default charset=latin1;

create table tipo_cliente(
id_tipo_cliente int primary key auto_increment,
nombre varchar(80) not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table cliente(
id_cliente int primary key auto_increment,
id_tipo_cliente int not null,
nombre_cliente varchar(80) not null,
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
foreign key (id_tipo_cliente) references
tipo_cliente(id_tipo_cliente)
)engine=Innodb default charset=latin1;

create table credito_cliente(
id_credito_cliente int  auto_increment,
id_cliente int not null,
id_sucursal int not null,
id_ventaE int not null,
id_moneda varchar(10) not null,
porcentaje double,
interes double,
cuota double not null,
pago_acumulado double not null,
tiempo_pago int not null,
tipo_tiempo varchar(80) not null,
forma_pago varchar(80) not null,
total double not null,
fecha_inicio date not null,
fecha_final date not null,
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_sucursal) references
sucursal(id_sucursal),
foreign key(id_moneda) references
moneda(id_moneda),
primary key(id_credito_cliente,id_cliente,id_sucursal)
)engine=Innodb default charset=latin1;

create table impuestos(
id_impuesto int primary key not null,
nombre_impuesto varchar(50) not null,
estatus_impuesto varchar(1) not null
)engine=innodb;

create table vendedor(
id_vendedor int primary key auto_increment,
id_empleado varchar(10) not null,
nombre_vendedor varchar(80) not null,
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
porcentaje double not null,
comision double not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine=Innodb default charset=latin1;

create table venta_encabezado(
id_ventaE int primary key not null,
id_vendedor int not null,
id_sucursal int not null,
id_cliente int not null,
id_impuesto_aplicado int not null,
total double ,
fecha date not null,
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_vendedor) references
vendedor(id_vendedor),
foreign key (id_sucursal) references
sucursal(id_sucursal),
foreign key (id_impuesto_aplicado) references
impuestos(id_impuesto)
)engine=Innodb default charset=latin1;

create table venta_detalle(
id_inventario int primary key not null,
id_ventaE int not null,
id_moneda varchar(10) not null,
cantidad int not null,
foreign key (id_inventario) references
inventario(id_inventario),
foreign key (id_ventaE) references
venta_encabezado(id_ventaE),
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;

create table cobrador(
id_cobrador int primary key auto_increment,
id_empleado varchar(10) not null,
nombre_cobrador varchar(80) not null,
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine=Innodb default charset=latin1;

create table servicios(
id_servicio int primary key not null,
nombre_servicio varchar(50) not null,
estatus_servicio varchar(1) not null
)engine=innodb;

create table tipo_mov_inventario(
id_tipo_mov_inventario int primary key auto_increment,
id_inventario int not null,
nombre varchar(80) not null,
accion varchar(1) not null,
estatus varchar(1) not null,
cantidad int not null,
fecha date not null,
motivo varchar(128) not null,
foreign key (id_inventario) references
inventario (id_inventario)
)engine=Innodb default charset=latin1;

create table cotizacion_encabezado_cliente(
id_cotizacion_encabezado_cliente int primary key auto_increment,
id_proveedor int not null,
id_cliente int not null,
id_vendedor int not null,
total double not null,
tiempo_limite date not null,
foreign key (id_proveedor) references
proveedor(id_proveedor),
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_vendedor) references
vendedor(id_vendedor)
)engine=Innodb default charset=latin1;

create table cotizacion_detalle_cliente(
id_cotizacion_detalle_cliente int primary key not null,
id_servicio int not null,
id_cotizacion_encabezado_cliente int not null,
id_moneda varchar(10) not null,
cantidad int not null,
costo double not null,
foreign key (id_servicio) references
servicios(id_servicio),
foreign key(id_moneda) references
moneda(id_moneda),
foreign key (id_cotizacion_encabezado_cliente) references
cotizacion_encabezado_cliente(id_cotizacion_encabezado_cliente)
)engine=Innodb default charset=latin1;


create table tipo_habitacion(
id_tipo_habitacion int primary key not null,
nombre varchar(3) not null,
descripcion varchar(300) null,
caracteristicas varchar (500) null,
precio_diario double not null,
cupo_maximo int not null
)engine=Innodb default charset=latin1;

create table habitacion(
id_habitacion int primary key not null,
id_tipo_habitacion int not null,
nivel int not null,
estatus varchar(1) not null,
foreign key (id_tipo_habitacion) references
tipo_habitacion(id_tipo_habitacion)
)engine=Innodb default charset=latin1;

create table salon (
id_salon int primary key not null,
nombre varchar(3) not null,
capacidad int not null,
nivel int not null,
precio double not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

create table tipo_pago(
id_tipo_pago int primary key not null,
id_moneda varchar(10) not null,
nombre_tipo_pago varchar(50) not null,
tipo_pago varchar(100) not null,
forma_pago varchar(100) not null,
tarjeta varchar(150) null,
total_pago double(7,2) not null,
fecha_pago date not null,
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;

create table reservacion_salon_encabezado (
id_reservacion_salon_encabezado int primary key not null,
id_cliente int not null,
id_tipo_pago int not null,
total double not null,
foreign key (id_tipo_pago) references
tipo_pago(id_tipo_pago),
foreign key (id_cliente) references
cliente(id_cliente)
)engine=Innodb default charset=latin1;

create table reservacion_salon_detalle (
id_reservacion_salon_detalle int primary key not null,
id_reservacion_salon_encabezado int not null,
duracion int not null,
cargo_extra double,
numero_personas int not null,
fecha_reservacion date not null,
hora_inicio time ,
foreign key (id_reservacion_salon_encabezado) references
reservacion_salon_encabezado(id_reservacion_salon_encabezado)
)engine=Innodb default charset=latin1;



create table reservacion_encabezado(
id_reservacion_encabezado int primary key not null,
id_cliente int not null,
id_tipo_pago int not null,
total double not null,
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_tipo_pago) references
tipo_pago(id_tipo_pago)
)engine=Innodb default charset=latin1;

create table reservacion_detalle(
id_reservacion_detalle int primary key not null,
id_reservacion_encabezado int  not null,
id_habitacion int not null,
numero_personas int not null,
dias_alojamiento int not null,
fecha_reservacion date not null,
fecha_fin date not null,
hora_entrada time , #se va actualizar
hora_salida time , #se va actualizar
cantidad_habitacion int not null,
foreign key (id_reservacion_encabezado) references
reservacion_encabezado(id_reservacion_encabezado),
foreign key (id_habitacion) references
habitacion(id_habitacion)
)engine=Innodb default charset=latin1; 

CREATE TABLE consumo (
id_consumo int not null auto_increment,
id_reservacion_detalle int not null,
id_inventario int not null,
cantidad double(10,2) not null,
precio_venta double(10,2) not null,
estado varchar(2) not null,
primary key (id_consumo),
foreign key (id_inventario) references inventario (id_inventario),
foreign key (id_reservacion_detalle) references reservacion_detalle (id_reservacion_detalle)
)engine=InnoDB  default charset = latin1;

create table servicio_habitacion(
id_servicio_habitacion int primary key not null,
nombre varchar(50) not null,
descripcion varchar(250) not null,
costo double(10,2) not null,
hora time not null,
fecha date not null,
estado varchar(2) not null
)engine = InnoDB default charset=latin1;


create table aplicacion_tipo_parametro(
id_aplicacion_tipo_parametro int primary key not null,
nombre_aplicacion varchar(50) not null,
estatus_aplicacion varchar(1) not null
)engine=Innodb default charset=latin1; 

create table tipo_parametro(
id_tipo_parametro int primary key not null,
id_aplicacion_tipo_parametro int not null,
nombre_tipo varchar(50) not null,
estatus_tipo varchar(1) not null,
foreign key (id_aplicacion_tipo_parametro) references
aplicacion_tipo_parametro(id_aplicacion_tipo_parametro)
)engine=Innodb default charset=latin1; 

create table parametros(
id_parametro int primary key not null,
id_tipo_parametro int not null,
nombre_parametro varchar(50) not null,
valor_parametro double not null,
estatus_parametro varchar(1) not null,
foreign key (id_tipo_parametro) references
tipo_parametro(id_tipo_parametro)
)engine=Innodb default charset=latin1; 

create table control_objetos_olvidados(
id_objeto int primary key not null,
id_habitacion int,
nombre_objeto varchar(50) not null,
fecha_ingreso date not null,
fecha_salida date,
id_salon int,
estatus_objeto varchar(1),
foreign key (id_habitacion) references
habitacion(id_habitacion),
foreign key (id_salon) references
salon(id_salon)
)engine=Innodb default charset=latin1; 

create table lavanderia(
id_lavanderia int primary key not null,
nombre_lavanderia varchar(50) not null,
id_sucursal int not null,
estatus_lavanderia varchar(1) not null,
foreign key (id_sucursal) references
sucursal(id_sucursal)
)engine=innodb default charset=latin1;

create table prenda(
id_prenda int not null primary key,
cantidad int not null,
descripcion varchar(300) not null,
fecha_fin date not null,
hora time not null
)engine = InnoDB default charset = latin1;

create table servicio_lavanderia(
id_servicio_lavanderia int primary key not null,
id_lavanderia int not null,
id_prenda int not null,
nombre varchar(100) not null,
precio int not null,
fecha_ingreso date not null,
fecha_salida date,
id_venta int not null,
estado varchar(2) not null,
foreign key (id_lavanderia) references
lavanderia(id_lavanderia),
foreign key (id_prenda) references prenda (id_prenda)
)engine=innodb default charset=latin1; 

create table tipo_precio(
id_tipo_precio int primary key not null,
id_moneda varchar(10) not null,
nombre varchar(40) not null,
estatus varchar(1) not null,
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;

create table lista_precio(
id_lista_precio int primary key not null,
id_tipo_cliente int not null,
id_tipo_precio int not null,
precio double not null,
porcentaje double not null,
foreign key (id_tipo_cliente) references
tipo_cliente(id_tipo_cliente),
foreign key (id_tipo_precio) references
tipo_precio(id_tipo_precio)
)engine=Innodb default charset=latin1;

create table cotizacion_encabezado_proveedor(
id_cotizacion_encabezado_proveedor int primary key auto_increment,
id_proveedor int not null,
id_cliente int not null,
id_vendedor int not null,
total double not null,
tiempo_limite date not null,
foreign key (id_proveedor) references
proveedor(id_proveedor),
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_vendedor) references
vendedor(id_vendedor)
)engine=Innodb default charset=latin1;

create table cotizacion_detalle_proveedor(
id_cotizacion_detalle_proveedor int primary key not null,
id_inventario int not null,
id_cotizacion_encabezado_proveedor int not null,
id_moneda varchar(10) not null,
cantidad int not null,
costo double not null,
foreign key (id_inventario) references
inventario(id_inventario),
foreign key(id_moneda) references
moneda(id_moneda),
foreign key (id_cotizacion_encabezado_proveedor) references
cotizacion_encabezado_proveedor(id_cotizacion_encabezado_proveedor)
)engine=Innodb default charset=latin1;

create table descuento(
id_descuento int not null,
nombre_descuento varchar(80) not null,
porcentaje double not null,
id_tipo_cliente int not null,
foreign key (id_tipo_cliente) references
tipo_cliente(id_tipo_cliente)
)engine=Innodb default charset=latin1;