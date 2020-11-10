-- drop database hotel_general;
create database hotel_general;
use hotel_general;

-- ---------------------------------------------------------------------------------
-- 								Área Financiera 
-- ----------------------------------------------------------------------------------                

/*Área de RRHH*/
create table nivel_academico( -- peticion de la empresa 
	id_nivel_academico varchar(10) primary key,
	nombre_nivel varchar(100), 
    descripcion varchar(80)
) engine = InnoDB default char set=latin1;

create table explab_detallado(
	id_tipoexp varchar(10) primary key,-- 1
    nombre_tipo varchar(50), -- inventarios, bodega
    nombre_empresa varchar(50), -- x
	tiempo_inicio date, -- 10/10/2000
    tiempo_finalizacion date -- 10/08/2015
) engine = InnoDB default char set=latin1;

create table experiencia_laboral(
	id_experiencia varchar(10) primary key,
    id_tipoexp varchar(10), -- foranea
    
    foreign key (id_tipoexp) references explab_detallado(id_tipoexp)
) engine = InnoDB default char set=latin1;

create table referenciasP(
	id_referenciaP varchar(10) primary key,
	nombre_personaP varchar(50),
    telefono_personaP int
) engine = InnoDB default char set=latin1;

create table referenciasL(
	id_referenciaL varchar(10) primary key,
    nombre_personaL varchar(50),
    telefono_personaL int
) engine = InnoDB default char set=latin1;

create table puesto(
	id_puesto varchar(10) primary key,
    nombre_puesto varchar(35),
    descripcion varchar(35),
    estatus_puesto char(1)
) engine = InnoDB default char set=latin1;

create table departamento(
	id_departamento varchar(10) primary key,
    nombre_departamento varchar(35),
    estatus_departamento char(1)
) engine = InnoDB default char set=latin1;

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
    
        
    ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table medio(
	id_medio varchar(10) primary key,
    id_solicitud varchar(10),
    nombre_medio varchar(35),
    descripcion varchar(80),
    
    foreign key(id_solicitud) references solicitud_empresarial(id_solicitud)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table curriculum(/*Reclutamiento*/
	dpi_persona varchar(13) primary key,
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
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table aplicacion(
	id_aplicacion varchar(10) primary key,
    dpi_persona varchar(13), -- foranea 
    cumple_requisitos char(1), -- Aplica o no Aplica
    
    foreign key(dpi_persona) references curriculum(dpi_persona)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table tipo_pruebas(
	id_prueba varchar(10) primary key,
    tipo_prueba varchar(35) -- psicologico, poligrafo, tarjeta de pulmones, socioeconomico, habilidades
) engine = InnoDB default char set=latin1;

create table aplicacion_prueba(
	id_ap varchar(10) primary key, -- codigo aplicacion prueba
	id_prueba varchar(10),
	id_aplicacion varchar(10), -- si cumple requisitos
    estatus_prueba char(1), -- aprobado, denegado
    
    foreign key (id_prueba) references tipo_pruebas(id_prueba),
    foreign key (id_aplicacion) references aplicacion(id_aplicacion)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table seleccion(
	id_seleccion varchar(10) primary key,
    id_ap varchar(10), -- foranea
    estatus_seleccion char(1), -- pendiente, aprobado, rechazado
    
    foreign key (id_ap) references aplicacion_prueba (id_ap)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table actividad(-- capacitacion, induccion, desempeño
	id_actividad varchar(10) primary key,
    tipo_actividad varchar(50),
    descripcion varchar(80)
) engine = InnoDB default char set=latin1;

create table periodo_prueba(
	id_periodop varchar(10) primary key,
    id_seleccion varchar(10), -- foranea
    fecha_inicio date,
    fecha_finalizacion date,
    pago float,
    id_actividad varchar(10),
    
    foreign key (id_actividad) references actividad(id_actividad),
    foreign key (id_seleccion) references seleccion(id_seleccion)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table contratacion(
	id_contratacion varchar(10) primary key,
	id_periodop varchar(10),
    fecha_contratacion date,
    duracion_contrato varchar(35),
    estatus_contratacion char(1), -- contratado, rechazado
	
    foreign key (id_periodop) references periodo_prueba(id_periodop)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table empleado_contratado( -- Se modifica se actualiza bitacora
	id_empleado varchar(10) primary key,
    id_contratacion varchar(10), -- foranea
    id_puesto varchar(10), -- foranea
    id_departamento varchar(10),  -- foranea
    sueldo_empleado float,
    
    foreign key (id_contratacion) references contratacion(id_contratacion),
    foreign key (id_puesto) references puesto(id_puesto),
    foreign key (id_departamento) references departamento(id_departamento)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table bitacora_empleado(
	id_bitacora int primary key auto_increment,
    id_empleado_B varchar(10),
    
    -- id contratacion
    -- puesto
    -- dep
    -- dpi
    -- Nombre persona
    -- Fecha contrata
    -- Sueldo
    -- Fecha Finalizacion
    
    foreign key (id_empleado_B ) references empleado_contratado(id_empleado)
	-- ON UPDATE CASCADE
	-- ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

create table actividad_empleado( -- capacitacion, desempeño
	id_empleado varchar(10) primary key,
    id_actividad varchar(10),
    
    foreign key (id_empleado) references empleado_contratado(id_empleado),
    foreign key (id_actividad) references actividad(id_actividad)
	ON UPDATE CASCADE
	ON DELETE SET NULL
) engine = InnoDB default char set=latin1;

/*Área de Nómina*/
create table concepto_planilla(
	id_conceptoPlanilla varchar(10) primary key,
	nombre_concepto varchar(20),
	tipo_concepto varchar (10),
	clase_concepto varchar(25),
	Valor_concepto float,
	aplicacion_concepto varchar(20)
) engine = InnoDB default char set=latin1;

create table planilla_enc(
	id_planillaenc varchar(10) primary key,
	total_percepcion float,
	total_deduccion float,
	total_liquido  float
    -- id_concepto varchar(10),
    
    -- foreign key (id_concepto) references concepto_movimiento(id_concepto)
) engine = InnoDB default char set=latin1;

create table planilla_det(
	id_planillaenc varchar(10),
	id_empleado varchar(10),
    id_conceptoPlanilla varchar(10),
	valor_conceptoDet float,
    
    primary key (id_planillaenc, id_empleado, id_conceptoPlanilla),
    
    foreign key (id_planillaenc) references planilla_enc(id_planillaenc),
	foreign key(id_conceptoPlanilla) references Concepto_Planilla(id_conceptoPlanilla),
	foreign key(id_empleado) references empleado_contratado(id_empleado)
) engine = InnoDB default char set=latin1;

/*Área de Bancos*/
create table moneda(
	id_moneda varchar(10) primary key,
    nombre_moneda varchar(20) not null,
    tipo_cambio float,
    estatus_moneda char(1)
)engine = InnoDB default charset=latin1;

-- parte de contabilidad 
create table clasificacion_cuenta(
	id_clasificacion varchar(10) primary key,
    nombre_clasificacion varchar(50)
) engine = InnoDB default char set=latin1;

create table cuenta_contable(
	id_cuenta varchar(10) primary key,
    nombre_cuenta varchar(35),
    tipo_cuenta varchar(35),
    id_clasificacion varchar(10),
    
    -- saldos
    saldo_anterior float,
    cargos_mes float,
    abonos_mes float,
    saldo_actual float,
    cargos_acumulados float,
    abonos_acumulados float,
    
    descripcion_cuenta varchar(35),
    
    foreign key (id_clasificacion) references clasificacion_cuenta (id_clasificacion)
) engine = InnoDB default char set=latin1;

create table Documento_bancario(
	codigo_Documento varchar(10) primary key,
    nombre_Documento varchar(50),
    afecta char(1),  -- + o - a la cuenta
    estatus_concepto char(1)

) engine = InnoDB default char set=latin1;

create table concepto_bancario(
	codigo_concepto varchar(10) primary key,
    nombre_concepto varchar(50),
    afecta char(1),  -- + o - a la cuenta
    estatus_concepto char(1),
    id_cuenta varchar(10),
    
    foreign key (id_cuenta) references cuenta_contable(id_cuenta)
) engine = InnoDB default char set=latin1;

create table mov_bancEnc( -- solo que mov se realizo y cual es el monto 
	id_movEnc varchar(10) primary key,
    codigo_Documento varchar(10),
    fecha date,
    monto float,
    descripcion varchar(80),
    
    foreign key (codigo_Documento) references Documento_bancario(codigo_Documento)
	
) engine = InnoDB default char set=latin1;

create table mov_bancDet( -- cuentas involucradas y partida contable 
	id_movEnc varchar(10),
    codigo_concepto varchar(10),
    saldo float,
    tipo_saldo varchar(35), -- deudor o acreedor, Debe o haber
    
    primary key (id_movEnc, codigo_concepto), -- clave compuesta y agruparemos por tipo de saldo 
    
    foreign key (id_movEnc) references mov_bancEnc(id_movEnc),
    foreign key (codigo_concepto) references concepto_bancario(codigo_concepto)
    
) engine = InnoDB default char set=latin1;

/*create table concepto_movimiento(
	id_concepto varchar(10) primary key,
    nombre_concepto varchar(35), /*clientes, anticipo, cobro a clientes
    -- tipo_concepto varchar(50) /*cargo, abono
) engine = InnoDB default char set=latin1;*/

create table forma_pago(
	id_formapago varchar(10) primary key,
    tipo_pago varchar(35) /*cheque, efectivo, tarjeta, nota de credito, otro*/
) engine = InnoDB default char set=latin1;

/*create table movimientos_bancarios(
	id_concepto varchar(10), -- foranea
    fecha date,
    fecha_aplicacion datetime,
    descripcion varchar(80),
    estado char(1),
    id_formapago varchar(10), -- foranea
	abono float, 
    cargo float,
    saldo float,
    
    foreign key (id_concepto) references concepto_movimiento(id_concepto),
    foreign key (id_formapago) references forma_pago(id_formapago)
) engine = InnoDB default char set=latin1;*/

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
    id_movEnc varchar(10), /*Movimientos*/
    
    foreign key (id_moneda) references moneda(id_moneda),
    foreign key (id_movEnc) references mov_bancEnc(id_movEnc)
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
	codigo_concepto varchar(10), /*foranea*/
    fecha_aplicacion date,
    descripcion varchar(50),
    id_formapago varchar(10), /*foranea*/
    beneficiario varchar(35),
    estado_conciliacion char(1),
    cargo float,
    abono float,
    
    primary key (id_encabezado, codigo_concepto, id_formapago),
    
	foreign key (codigo_concepto) references concepto_bancario (codigo_concepto),
    foreign key(id_formapago) references forma_pago(id_formapago),
    foreign key(id_encabezado) references conciliacion_bancenc(id_encabezado)
) engine = InnoDB default char set=latin1;

/*Área de Contabilidad*/

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


/*-------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------Área Administrativa--------------------------------------------------------*/
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
tipo_licencia varchar(2) not null,
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
estatus varchar(1) not null,
nombre_caja varchar(45) not null
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
id_compraE int not null primary key,
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
cuota double ,
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
nit_cliente varchar(30) not null,
correo varchar(80) not null,
telefono varchar(11) not null,
direccion varchar(80) not null,
foreign key (id_tipo_cliente) references
tipo_cliente(id_tipo_cliente)
)engine=Innodb default charset=latin1;
-- select * from cliente;

create table tipo_pago_credito(
id_tipo int not null primary key,
nombre_tipo varchar(50) not null,
estado varchar(1) not null
)engine=Innodb default char set=latin1;

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
tipo_tiempo int not null,
forma_pago int not null,
total double not null,
fecha_inicio date not null,
fecha_final date not null,
foreign key (id_cliente) references
cliente(id_cliente),
foreign key (id_sucursal) references
sucursal(id_sucursal),
foreign key(id_moneda) references
moneda(id_moneda),
foreign key(forma_pago) references
tipo_pago_credito(id_tipo),
primary key(id_credito_cliente)
)engine=Innodb default charset=latin1;


create table impuestos(
id_impuesto int primary key auto_increment not null,
nombre_impuesto varchar(50) not null,
estatus_impuesto varchar(1) not null
)engine=innodb;


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
id_ventaD int primary key not null,
id_inventario int not null,
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


create table servicios(
id_servicio int primary key not null auto_increment,
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
id_tipo_habitacion int auto_increment primary key not null,
nombre varchar(50) not null,
descripcion varchar(300) null,
caracteristicas varchar (500) null,
precio_diario double not null,
cupo_maximo int not null
)engine=Innodb default charset=latin1;


create table habitacion(
id_habitacion int auto_increment primary key not null,
id_tipo_habitacion int not null,
nivel int not null,
estatus varchar(1) not null,
foreign key (id_tipo_habitacion) references
tipo_habitacion(id_tipo_habitacion)
)engine=Innodb default charset=latin1;


create table salon (
id_salon int auto_increment primary key not null,
nombre varchar(50) not null,
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
id_aplicacion_tipo_parametro int primary key not null auto_increment,
nombre_aplicacion varchar(50) not null,
estatus_aplicacion varchar(1) not null
)engine=Innodb default charset=latin1; 



create table tipo_parametro(
id_tipo_parametro int primary key not null auto_increment,
id_aplicacion_tipo_parametro int not null,
nombre_tipo varchar(50) not null,
estatus_tipo varchar(1) not null,
foreign key (id_aplicacion_tipo_parametro) references
aplicacion_tipo_parametro(id_aplicacion_tipo_parametro)
)engine=Innodb default charset=latin1; 



create table parametros(
id_parametro int primary key not null auto_increment,
id_tipo_parametro int not null,
nombre_parametro varchar(50) not null,
valor_parametro double not null,
estatus_parametro varchar(1) not null,
foreign key (id_tipo_parametro) references
tipo_parametro(id_tipo_parametro)
)engine=Innodb default charset=latin1; 



create table control_objetos_olvidados(
id_objeto int primary key not null auto_increment,
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
id_prenda int not null primary key auto_increment,
cantidad int not null,
descripcion varchar(300) not null,
fecha_fin date not null,
hora time not null
)engine = InnoDB default charset = latin1;


create table servicio_lavanderia(
id_servicio_lavanderia int primary key not null auto_increment,
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
id_tipo_precio int primary key not null auto_increment,
id_moneda varchar(10) not null,
nombre varchar(40) not null,
estatus varchar(1) not null,
foreign key(id_moneda) references
moneda(id_moneda)
)engine=Innodb default charset=latin1;


create table lista_precio(
id_lista_precio int primary key not null auto_increment,
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
id_cotizacion_detalle_proveedor int primary key not null auto_increment,
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
id_descuento int not null auto_increment primary key,
nombre_descuento varchar(80) not null,
porcentaje double not null,
id_tipo_cliente int not null,
foreign key (id_tipo_cliente) references
tipo_cliente(id_tipo_cliente)
)engine=Innodb default charset=latin1;

create table rol_usuario(
id_rol_usuario varchar (20) primary key not null,
nombre_rol varchar (40) not null,
rol_key varchar (35) not null,
estado varchar (1) not null
)engine = InnoDB default charset=latin1;

create table usuario_hoteleria(-- login de usuario hotel
id_usuario varchar (35) primary key not null,
nombre_usuario varchar (20) not null,
password_usuario varchar (35) not null,
id_empleado varchar (10) not null,
estado varchar (1) not null,
foreign key(id_empleado) references
empleado_contratado(id_empleado)
)engine = InnoDB default charset=latin1;

create table bitacora(
id_bitacora int primary key auto_increment,
id_usuario varchar(35) not null,
descripcion varchar(200),
fecha date not null,
hora time not null,
foreign key (id_usuario) references
usuario_hoteleria(id_usuario)
)engine=InnoDB  default charset=latin1;

create table registro_contable(
codigo varchar(10) primary key,
codigo_operacion varchar(10) not null,
fecha_operacion date not null,
cuenta_cargo varchar(10) not null,
cuenta_abono varchar(10) not null,
cantidad double not null,
quien_carga varchar(10) not null,
quien_abona varchar(10) not null,

foreign key (cuenta_cargo) references cuenta_contable(id_cuenta),
foreign key (cuenta_abono) references cuenta_contable(id_cuenta)
)engine=Innodb default char set=latin1;


