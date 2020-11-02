use Hotel;

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

select * from cuenta_contable;
insert into cuenta_contable values ("1", "Caja", "Activo", "1", "0", "10000","500", "9500", "0", "0", "Contiene el efectivo" );

insert into Documento_bancario values ("01", "Cheque", "-", "A");

insert into concepto_bancario values ("1", "Pago a proveedor", "-", "A", "1");

insert into mov_bancEnc values ("1", "01", "2020/10/22", "1000", "Pago a office depot");
insert into mov_bancdet values ("1", "1", "1000", "Deudor");