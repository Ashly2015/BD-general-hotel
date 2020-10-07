#drop database hotel;
create database hotel;
use hotel;

/*Área Financiera*/
create table nivel_academico( -- peticion de la empresa 
	id_nivel_academico varchar(10) primary key,
	nombre_nivel varchar(100), 
    descripcion varchar(80)
) engine = InnoDB default char set=latin1;

#INSERT NIVEL ACADEMICO
insert into nivel_academico values ("1", "A", "descripcion");

create table explab_detallado(
	id_tipoexp varchar(10) primary key,-- 1
    nombre_tipo varchar(50), -- inventarios, bodega
    nombre_empresa varchar(50), -- x
	tiempo_inicio date, -- 10/10/2000
    tiempo_finalizacion date -- 10/08/2015
) engine = InnoDB default char set=latin1;

#INSERTS explab_detallado
insert into explab_detallado values ("1", "Exp1", "A", "1999/08/12", "2020/08/22");

create table experiencia_laboral(
	id_experiencia varchar(10) primary key,
    id_tipoexp varchar(10), -- foranea
    
    foreign key (id_tipoexp) references explab_detallado(id_tipoexp)
) engine = InnoDB default char set=latin1;

#INSERTS experiencia_laboral
insert into experiencia_laboral values ("1", "1");

create table referenciasP(
	id_referenciaP varchar(10) primary key,
	nombre_personaP varchar(50),
    telefono_personaP int
) engine = InnoDB default char set=latin1;

#INSERTS referenciasP
insert into referenciasP values ("1", "Juan", "123");

create table referenciasL(
	id_referenciaL varchar(10) primary key,
    nombre_personaL varchar(50),
    telefono_personaL int
) engine = InnoDB default char set=latin1;

#INSERTS referenciasL
insert into referenciasL values ("1", "Daniel", "456");

create table puesto(
	id_puesto varchar(10) primary key,
    nombre_puesto varchar(35),
    descripcion varchar(35),
    estatus_puesto char(1)
) engine = InnoDB default char set=latin1;

#INSERTS puesto
insert into puesto values ("1", "Puesto1", "ninguna", "A");


create table departamento(
	id_departamento varchar(10) primary key,
    nombre_departamento varchar(35),
    estatus_departamento char(1)
) engine = InnoDB default char set=latin1;

#INSERTS departamento
insert into departamento values ("1", "Depto1", "A");


create table solicitud_empresarial(
	id_solicitud varchar(10) primary key,
    rango_edad_menor int,
    rango_edad_mayor int,
    genero char(1),
    id_puesto varchar(10),
    id_departamento varchar(10),
	id_nivel_academico varchar(10), -- foranea
    id_experiencia varchar(10), -- foranea
    descripcion text, -- sueldo, (lo que se ofrece a la persona) 
    
    foreign key (id_puesto) references puesto(id_puesto),
    foreign key (id_departamento) references departamento(id_departamento),
    foreign key (id_nivel_academico) references nivel_academico(id_nivel_academico),
    foreign key (id_experiencia) references experiencia_laboral(id_experiencia)
) engine = InnoDB default char set=latin1;

#INSERTS solicitud_empresarial
insert into solicitud_empresarial values ("1", "20", "30", "M", "1", "1", "1","1", "ninguna");

create table medio(
	id_medio varchar(10) primary key,
    id_solicitud varchar(10),
    nombre_medio varchar(35),
    descripcion varchar(80),
    
    foreign key(id_solicitud) references solicitud_empresarial(id_solicitud)
) engine = InnoDB default char set=latin1;

insert into medio values ("1", "1", "Prensa", "ninguna");


create table curriculum(/*Reclutamiento*/
	dpi_persona int primary key,
    nombres_persona varchar(100),
    apellidos_persona varchar(100),
    telefono_persona int,
    correo_electronico varchar(80),
    direccion_persona varchar(80),
    genero_persona char(1),
    edad_persona int,
--    nivel_academico varchar(80),
	id_nivel_academico varchar(10), -- foranea
    id_referenciaP varchar(10), -- foranea
    id_referenciaL varchar(10), -- foranea
    id_experiencia varchar(10), -- foranea
    id_medio varchar(10), -- foranea
    
    foreign key ( id_nivel_academico) references nivel_academico(id_nivel_academico),
    foreign key ( id_referenciaP) references referenciasP(id_referenciaP),
    foreign key ( id_referenciaL) references referenciasL(id_referenciaL),
    foreign key ( id_experiencia) references experiencia_laboral(id_experiencia),
    foreign key ( id_medio) references medio(id_medio)
) engine = InnoDB default char set=latin1;

insert into curriculum values ("125", "Jose", "Hernandez", "852", "Jose@gmail.com", "ciudad", "M", "22", "1", "1", "1", "1", "1");


create table aplicacion(
	id_aplicacion varchar(10) primary key,
    dpi_persona int, -- foranea 
    cumple_requisitos char(1), -- Aplica o no Aplica
    
    foreign key(dpi_persona) references curriculum(dpi_persona)
) engine = InnoDB default char set=latin1;

insert into aplicacion values ("1", "125", "S");

create table tipo_pruebas(
	id_prueba varchar(10) primary key,
    tipo_prueba varchar(35) -- psicologico, poligrafo, tarjeta de pulmones, socioeconomico, habilidades
) engine = InnoDB default char set=latin1;

insert into tipo_pruebas values ("1", "psicologico");



create table aplicacion_prueba(
	id_ap varchar(10) primary key, -- codigo aplicacion prueba
	id_prueba varchar(10),
	id_aplicacion varchar(10), -- si cumple requisitos
    estatus_prueba char(1), -- aprobado, denegado
    
    foreign key (id_prueba) references tipo_pruebas(id_prueba),
    foreign key (id_aplicacion) references aplicacion(id_aplicacion)
) engine = InnoDB default char set=latin1;

insert into aplicacion_prueba values ("1", "1", "1", "A");


create table seleccion(
	id_seleccion varchar(10) primary key,
    id_ap varchar(10), -- foranea
    estatus_seleccion char(1), -- pendiente, aprobado, rechazado
    
    foreign key (id_ap) references aplicacion_prueba (id_ap)
) engine = InnoDB default char set=latin1;

insert into seleccion values ("1", "1", "A");

create table actividad(-- capacitacion, induccion, desempeño
	id_actividad varchar(10) primary key,
    tipo_actividad varchar(50),
    descripcion varchar(80)
) engine = InnoDB default char set=latin1;

insert into actividad values ("1", "1", "A");



create table periodo_prueba(
	id_periodop varchar(10) primary key,
    id_seleccion varchar(10), -- foranea
    fecha_inicio date,
    fecha_finalizacion date,
    pago float,
    id_actividad varchar(10),
    
    foreign key (id_actividad) references actividad(id_actividad),
    foreign key (id_seleccion) references seleccion(id_seleccion)
) engine = InnoDB default char set=latin1;

insert into periodo_prueba values ("1", "1", "2020/02/25", "2020/03/15", "100", "1");


create table contratacion(
	id_contratacion varchar(10) primary key,
	id_periodop varchar(10),
    fecha_contratacion date,
    duracion_contrato varchar(35),
    estatus_contratacion char(1), -- contratado, rechazado
	
    foreign key (id_periodop) references periodo_prueba(id_periodop)
) engine = InnoDB default char set=latin1;

insert into contratacion values ("1", "1", "2020/08/12", "10 meses", "A");


create table bitacora_empleado(
	id_bitacora varchar(10) primary key,
    id_contratacion varchar(10),
    id_departamento varchar(10),
    id_puesto varchar(10),
    
    foreign key (id_contratacion) references contratacion (id_contratacion),
    foreign key (id_departamento) references departamento (id_departamento),
    foreign key (id_puesto) references puesto (id_puesto)
) engine = InnoDB default char set=latin1;


create table empleado_contratado( /*EMPLEADO*/
	id_empleado varchar(10) primary key,
    id_contratacion varchar(10), -- foranea
    id_puesto varchar(10), -- foranea
    id_departamento varchar(10),  -- foranea
    sueldo_empleado float,
    
    foreign key (id_contratacion) references contratacion(id_contratacion),
    foreign key (id_puesto) references puesto(id_puesto),
    foreign key (id_departamento) references departamento(id_departamento)
) engine = InnoDB default char set=latin1;

insert into empleado_contratado values ("1", "1", "1", "1", "5000");

create table actividad_empleado( -- capacitacion, desempeño
	id_empleado varchar(10),
    id_actividad varchar(10),
    
    foreign key (id_empleado) references empleado_contratado(id_empleado),
    foreign key (id_actividad) references actividad(id_actividad)
) engine = InnoDB default char set=latin1;

create table concepto_planilla(
	id_conceptoPlanilla varchar(10) primary key,
	nombre_concepto varchar(20),
	tipo_concepto varchar (10),
	clase_concepto varchar(25),
	Valor_concepto  float,
	aplicacion_concepto varchar(20)
) engine = InnoDB default char set=latin1;

/*Área de Bancos*/
create table moneda(
	id_moneda varchar(10) primary key,
    nombre_moneda varchar(20) not null,
    tipo_cambio float,
    estatus_moneda char(1)
)engine = InnoDB default charset=latin1;

#inserts moneda
insert into tipo_precio values ("0", "Dolar", 7.54,"A");

create table concepto_movimiento(
	id_concepto varchar(10) primary key,
    nombre_concepto varchar(35), /*clientes, anticipo, cobro a clientes*/
    tipo_concepto varchar(50) /*cargo, abono*/
) engine = InnoDB default char set=latin1;

/*Pago de planilla al banco */
create table planilla_enc(
	id_planillaenc varchar(10) primary key,
	id_empleado varchar(10),
	total_percepcion float,
	total_deduccion float,
	total_liquido  float,
    id_concepto varchar(10),
    
	foreign key(id_empleado) references empleado_contratado(id_empleado),
    foreign key (id_concepto) references concepto_movimiento(id_concepto)
) engine = InnoDB default char set=latin1;

create table planilla_det(
	id_planillaenc varchar(10),
	id_conceptoPlanilla varchar(10),
	id_empleado varchar(10),
	valor_conceptoDet float,
    
    primary key (id_planillaenc, id_conceptoPlanilla, id_empleado),
    
    foreign key (id_planillaenc) references planilla_enc(id_planillaenc),
	foreign key(id_conceptoPlanilla) references Concepto_Planilla(id_conceptoPlanilla),
	foreign key(id_empleado) references empleado_contratado(id_empleado)
) engine = InnoDB default char set=latin1;


create table forma_pago(
	id_formapago varchar(10) primary key,
    tipo_pago varchar(35) /*cheque, efectivo, tarjeta, nota de credito, otro*/
) engine = InnoDB default char set=latin1;

create table movimientos_bancarios(
	id_concepto varchar(10), /*foranea*/
    fecha date,
    fecha_aplicacion datetime,
    descripcion varchar(80),
    estado char(1),
    id_formapago varchar(10), /*foranea*/
	abono float, 
    cargo float,
    saldo float,
    
    foreign key (id_concepto) references concepto_movimiento(id_concepto),
    foreign key (id_formapago) references forma_pago(id_formapago)
) engine = InnoDB default char set=latin1;

create table banco(
	nombre_banco varchar(50),
    nombre_cuenta varchar(50), /*Cuenta maestra*/
    clave_banco varchar(10),
    funcionario varchar(50),
    telefono int,
    numero_plaza int,
    numero_sucursal int,
    saldo_inicial float,
    id_moneda varchar(10),
    id_concepto varchar(10), /*Movimientos*/
    
    foreign key (id_moneda) references moneda(id_moneda),
    foreign key (id_concepto) references movimientos_bancarios(id_concepto)
) engine = InnoDB default char set=latin1;

create table conciliacion_bancenc(
	id_encabezado varchar(10) primary key,
    cargo_conciliar float,
    abono_conciliar float,
    saldo_corte float,
    cargo_conciliado float,
    abono_conciliado float,
    saldo_final float
) engine = InnoDB default char set=latin1;

create table conciliacion_bancaria_det(
	id_encabezado varchar(10), /*foranea*/
	id_concepto varchar(10), /*foranea*/
    fecha_aplicacion date,
    descripcion varchar(50),
    id_formapago varchar(10), /*foranea*/
    beneficiario varchar(35),
    estado_conciliacion char(1),
    cargo float,
    abono float,
    
    primary key (id_encabezado, id_concepto, id_formapago),
    
    foreign key(id_concepto) references concepto_movimiento(id_concepto),
    foreign key(id_formapago) references forma_pago(id_formapago),
    foreign key(id_encabezado) references conciliacion_bancenc(id_encabezado)
) engine = InnoDB default char set=latin1;


/*Área de Contabilidad*/
create table cuenta_contable(
	id_cuenta varchar(10) primary key,
    nombre_cuenta varchar(35),
    tipo_cuenta varchar(35),
    descripcion_cuenta varchar(35)
) engine = InnoDB default char set=latin1;

create table poliza_encab(
	id_encabezado varchar(10) primary key,
    tipo_poliza varchar(50), /*DR:diario, EG: egresos. IG: ingresos*/
    fecha date,
    descripcion_poliza varchar(80)
) engine = InnoDB default char set=latin1;

create table poliza_detalle(
	id_encabezado varchar(10), /*foranea*/
    id_cuenta varchar(10), /*foranea*/
    descripcion_movpoliza varchar(50),
    fecha_inicio date,
    fecha_final date,
    debe float,
    haber float,
    estatus_poliza char(1),
    
    primary key (id_encabezado, id_cuenta),
    
    /*Foraneas*/
    foreign key (id_encabezado) references poliza_encab(id_encabezado),
    foreign key (id_cuenta) references cuenta_contable(id_cuenta)
) engine = InnoDB default char set=latin1;

create table impuesto_huesped(
	id_impuesto varchar(10) primary key,
    tipo_impuesto varchar(50), /*IVA, impuesto turismo*/
    cantidad_impuesto float,
    descripcion_impuesto varchar(80),
    estatus_impuesto char(1)
) engine = InnoDB default char set=latin1;

/*Multi usuario*/
create table usuario( -- login de usuario
	id_usuario varchar(10) primary key,
    password_usuario varchar(35) not null
    -- id_hotel varchar(10), /*Foranea*/
    
    -- foreign key (ID_Empresa) references Empresa(ID_Empresa)
)engine = InnoDB default charset=latin1;

insert into usuario values ("admin", "1234");
/*-------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------Área Administrativa--------------------------------------------------------*/
create table sucursal (
id_sucursal int auto_increment primary key,
nombre varchar(20) not null,
direccion varchar(20) not null,
telefono varchar(20) not null
)engine=Innodb default charset=latin1;

#inserts sucursal
insert into sucursal values ("0", "Norte", "Zona18", "telefono");

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

#inserts PILOTO
insert into piloto VALUES(0,"1","12345","A",01-01-2021,500,"A");
insert into piloto VALUES(0,"2","54327""B",01-01-2022,500,"A");
insert into piloto VALUES(0,"3","86554","B",01-01-2021,500,"A");
insert into piloto VALUES(0,"4","87654","B",01-01-2023,500,"A");
insert into piloto VALUES(0,"5","19283","B",01-01-2022,500,"A");

create table bodega (
id_bodega int auto_increment primary key,
id_sucursal int not null,
nombre varchar(20) not null,
direccion varchar(40) not null,
estatus varchar(1) not null,
foreign key(id_sucursal) references
sucursal(id_sucursal)
)engine=Innodb default charset=latin1;

#inserts BODEGA
insert into bodega VALUES(0,1,"Bodega 1","zona 5","D");
insert into bodega VALUES(0,1,"Bodega 2","zona 5","D");
insert into bodega VALUES(0,2,"Bodega 3","zona 6","D");
insert into bodega VALUES(0,3,"Bodega 4","zona 1","D");
insert into bodega VALUES(0,4,"Bodega 5","zona 2","D");

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

#inserts PROVEEDOR
insert into proveedor VALUES(0,"proveedor 1","zona 2");
insert into proveedor VALUES(0,"proveedor 2","zona 7");
insert into proveedor VALUES(0,"proveedor 3","zona 3");
insert into proveedor VALUES(0,"proveedor 4","zona 15");
insert into proveedor VALUES(0,"proveedor 5","zona 10");

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

#inserts tipo_cliente
insert into tipo_cliente values (0, "Frecuente", "A");
insert into tipo_cliente values (0, "Normal", "A");
insert into tipo_cliente values (0, "Premium", "A");


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

#inserts cliente
insert into cliente values (0,1, "Ashly Barrios", "ranbr@gmail.com", "54738829","Zona 5");
insert into cliente values (0,2, "Heydi Queme", "hsqa@gmail.com", "5472239","Zona 10");
insert into cliente values (0,2, "Kevin Flores", "kfka@gmail.com", "23471239","Zona 1");

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
id_impuesto int primary key auto_increment not null,
nombre_impuesto varchar(50) not null,
estatus_impuesto varchar(1) not null
)engine=innodb;

#inserts IMPUESTO
insert into impuesto VALUES(0,"impuesto 1","A");
insert into impuesto VALUES(0,"impuesto 2","A");
insert into impuesto VALUES(0,"impuesto 3","A");
insert into impuesto VALUES(0,"impuesto 4","A");
insert into impuesto VALUES(0,"impuesto 5","A");

create table vendedor(
id_vendedor int primary key auto_increment,
id_empleado varchar(10) not null,
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
porcentaje double not null,
comision double not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine=Innodb default charset=latin1;

#inserts VENDEDOR
insert into vendedor VALUES(0,"1","vendedor1@email.com","12345678","zona 5",10.25,1000);
insert into vendedor VALUES(0,"2","vendedor2@email.com","87654321","zona 8",5.50,550);
insert into vendedor VALUES(0,"3","vendedor3@email.com","12875643","zona 1",15.0,150);
insert into vendedor VALUES(0,"4","vendedor4@email.com","18273645","zona 3",25.0,245);
insert into vendedor VALUES(0,"5","vendedor5@email.com","83217462","zona 5",5.0,500);

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
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine=Innodb default charset=latin1;

#inserts COBRADOR
insert into cobrador VALUES(0,1,"cobrador1@email.com","10298375","zona 1");
insert into cobrador VALUES(0,2,"cobrador2@email.com","94326543","zona 3");
insert into cobrador VALUES(0,3,"cobrador3@email.com","92845361","zona 2");
insert into cobrador VALUES(0,4,"cobrador4@email.com","95632354","zona 5");
insert into cobrador VALUES(0,5,"cobrador5@email.com","22567945","zona 6");

create table servicios(
id_servicio int primary key not null,
nombre_servicio varchar(50) not null,
estatus_servicio varchar(1) not null
)engine=innodb;

#inserts servicios
insert into servicios values (0,"masaje","A");
insert into servicios values (0,"transporte","A");

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
id_tipo_habitacion int auto_increment primary key not null,
nombre varchar(3) not null,
descripcion varchar(300) null,
caracteristicas varchar (500) null,
precio_diario double not null,
cupo_maximo int not null
)engine=Innodb default charset=latin1;

#inserts TIPO HABITACION
insert into tipo_habitacion VALUES(0,"Habitacion pequeña","Habitación pequeña para una sola persona y sin acceso a aire acondicionado.","1 cama, 1 sofá, 1 baño, 1 cocina pequeña.",150,1);
insert into tipo_habitacion VALUES(0,"Habitacion mediana","Habitación mediana para tres personas con acceso a aire acondicionado.","3 camas, 1 juego de 3 sofás, 3 baños, 1 cocina.",400,3);
insert into tipo_habitacion VALUES(0,"Habitacion grande","Habitación grande para cinco personas con acceso a aire acondicionado.","5 camas, 1 juego de 3 sofás, 3 baño, 1 cocina.",700,5);
insert into tipo_habitacion VALUES(0,"Habitacion tipo suite","Habitación tipo suite para ocho personas que puede o no tener acceso a aire acondicionado.","8 camas, 1 juego de 4 sofás, 5 baños, 1 cocina grande.",1200,8);

create table habitacion(
id_habitacion int auto_increment primary key not null,
id_tipo_habitacion int not null,
nivel int not null,
estatus varchar(1) not null,
foreign key (id_tipo_habitacion) references
tipo_habitacion(id_tipo_habitacion)
)engine=Innodb default charset=latin1;

#inserts HABITACION
insert into habitacion VALUES(0,1,1,"D");
insert into habitacion VALUES(0,2,1,"D");
insert into habitacion VALUES(0,3,1,"D");
insert into habitacion VALUES(0,4,1,"D");
insert into habitacion VALUES(0,1,1,"D");

create table salon (
id_salon int auto_increment primary key not null,
nombre varchar(3) not null,
capacidad int not null,
nivel int not null,
precio double not null,
estatus varchar(1) not null
)engine=Innodb default charset=latin1;

#inserts SALON
insert into salon VALUES(0,"Salon 1", 2000, 1, 800, "D");
insert into salon VALUES(0, "Salon 2", 3000, 1, 900, "D");
insert into salon VALUES(0, "Salon General", 7000, 2, 1000, "D");

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
id_lavanderia int primary key not null auto_increment,
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

#inserts tipo_precio
insert into tipo_precio values (0,"0", "Lavanderia", "A");
insert into tipo_precio values (0,"0", "Restaurante", "A");
insert into tipo_precio values (0,"0", "Servicio", "A");

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

#inserts lista_precio
insert into lista_precio values (0,1,1, 22.26, 5.2);
insert into lista_precio values (0,1,2, 2.26, 5.2);
insert into lista_precio values (0,2,1, 22.26, 5.2);

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

#inserts descuento
insert into descuento values (0,"Promocion",10,2);
insert into descuento values (0,"Pago al contado",7,2);

