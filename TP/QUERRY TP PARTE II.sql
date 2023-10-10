CREATE DATABASE FARMACIA_TP_LABII;
GO
USE FARMACIA_TP_LABII;
GO
CREATE TABLE Provincias
(	
	id_provincia int,
	provincia varchar(50)
Constraint PK_PROVINCIAS PRIMARY KEY (id_provincia)
)
GO

CREATE TABLE Localidades
(
	id_localidad int,
	localidad varchar(50),
	id_provincia int
Constraint PK_LOCALIDADES PRIMARY KEY(id_localidad),
Constraint FK_LOCALIDADES_PROVINCIAS FOREIGN KEY (id_provincia) REFERENCES Provincias (id_provincia)
)
GO
CREATE TABLE Barrios
(
	id_barrio int,
	barrio varchar(50),
	id_localidad int
Constraint PK_BARRIOS PRIMARY KEY(id_barrio)
Constraint FK_BARRIOS_LOCALIDADES FOREIGN KEY(id_localidad) REFERENCES Localidades (id_localidad)
)
GO

CREATE TABLE Sucursales
(
	id_Sucursal int,
	id_barrio int,
	calle varchar(20),
	numeracion int,
Constraint PK_SUCURSALES PRIMARY KEY (id_Sucursal),
Constraint FK_SUCURSALES_BARRIOS FOREIGN KEY (id_barrio) REFERENCES Barrios (id_barrio)
)
GO
-------------------------------------------

CREATE TABLE Descuentos
(
	id_Descuento int,
	Descripcion varchar(50),
	Descuento decimal(2,2),
	id_localidad int
Constraint PK_DESCUENTOS PRIMARY KEY(id_Descuento)
Constraint FK_DESCUENTOS_LOCALIDADES FOREIGN KEY (id_localidad) REFERENCES Localidades (id_localidad)
)
----------------------------------------------
GO
CREATE TABLE Unidades_Medidas
(
	id_UnidadMed int,
	Unidad_Medida varchar(10)
Constraint PK_UNIDADES_MEDIDAS PRIMARY KEY (id_unidadMed)
)
GO
CREATE TABLE Tipos_Suministros
(
	id_Tipo_Suministro int,
	tipo_siministro varchar(50)
Constraint PK_TIPOS_SUMINISTROS PRIMARY KEY(id_Tipo_Suministro)
)
GO

--------------------------------------------
CREATE TABLE Tipos_Proveedores
(
	id_tipo_Prov int,
	tipo_prov varchar (50)
Constraint PK_TIPOS_PROV PRIMARY KEY(id_tipo_prov)
)
GO
CREATE TABLE Cargos_Empleados
(
	id_cargo int,
	cargo varchar(50)
Constraint PK_CARGOS PRIMARY KEY(id_cargo)
)
GO
CREATE TABLE Personas
(
	id_persona int,
	nombre varchar(30),
	apellido varchar(30),
	dni varchar(30),
	id_barrio int
Constraint PK_PERSONAS PRIMARY KEY(id_persona),
Constraint FK_PERSONAS_BARRIOS FOREIGN KEY (id_barrio) REFERENCES Barrios (id_barrio)
)
GO
CREATE TABLE Empleados
(
	id_empleado int,
	id_persona int,
	id_cargo int
Constraint PK_EMPLEADOS PRIMARY KEY (id_empleado),
Constraint FK_EMPLEADOS_PERSONAS FOREIGN KEY (id_persona) REFERENCES Personas (id_persona),
Constraint FK_EMPLEADOS_CARGOS FOREIGN KEY (id_cargo) REFERENCES Cargos_Empleados (id_cargo)
)
GO
CREATE TABLE Clientes
(
	id_cliente int,
	id_persona int
Constraint PK_CLIENTES PRIMARY KEY (id_Cliente),
Constraint FK_CLIENTES_PERSONAS FOREIGN KEY (id_persona) REFERENCES Personas (id_persona)
)
GO
CREATE TABLE Medicos
(
	id_medico int,
	id_persona int
Constraint PK_MEDICOS PRIMARY KEY (id_Medico),
Constraint FK_MEDICOS_PERSONAS FOREIGN KEY (id_persona) REFERENCES Personas (id_persona)
)
GO
CREATE TABLE Proveedores
(
	id_proveedor int,
	id_persona int,
	id_tipo_prov int
Constraint PK_PROVEEDORES PRIMARY KEY (id_Proveedor),
Constraint FK_PROVEEDORES_PERSONAS FOREIGN KEY (id_persona) REFERENCES Personas (id_persona),
Constraint FK_PROVEEDORES_TIPOS_PROV FOREIGN KEY (id_tipo_prov) REFERENCES Tipos_Proveedores (id_tipo_prov)
)
GO
CREATE TABLE Transportes
(
	id_transporte int,
	id_proveedor int,
Constraint PK_TRANSPORTES PRIMARY KEY (id_transporte),
Constraint FK_TRANSPORTES_PROVEEDORES FOREIGN KEY (id_proveedor) REFERENCES Proveedores (id_proveedor)
)
GO

CREATE TABLE Suministros
(
	id_Suministro int,
	id_Tipo_Suministro int,
	id_UnidadMed int,
	id_Descuento int,
	id_proveedor int,
	stock int
Constraint PK_SUMINISTROS PRIMARY KEY (id_Suministro),
Constraint FK_SUMINISTROS_TIPOSUM FOREIGN KEY (id_Tipo_Suministro) REFERENCES Tipos_Suministros(id_Tipo_Suministro),
Constraint FK_SUMINISTROS_UNIDADMED FOREIGN KEY (id_UnidadMed) REFERENCES Unidades_Medidas(id_UnidadMed),
Constraint FK_SUMINISTROS_DESCUENTOS FOREIGN KEY (id_Descuento) REFERENCES Descuentos (id_Descuento),
Constraint FK_SUMINISTROS_PROVEEDORES FOREIGN KEY (id_proveedor) REFERENCES Proveedores (id_proveedor)
)
------------------------------------------------------
GO
CREATE TABLE Categorias_obras_sociales

(
	id_categoria int,
	categoria varchar(50),
	id_descuento int
Constraint PK_PLANES PRIMARY KEY (id_categoria),
Constraint FK_PLANES_DESCUENTOS FOREIGN KEY (id_descuento) REFERENCES Descuentos (id_descuento)
)
GO

CREATE TABLE Obras_Sociales
(
	id_obra_social int,
	id_categoria int,
	nombre varchar(50)
Constraint PK_OBRAS_SOCIALES PRIMARY KEY (id_Obra_social),
Constraint FK_OBRAS_SOCIALES_CATEGORIAS FOREIGN KEY (id_categoria) REFERENCES Categorias_obras_sociales (id_categoria) 
)
GO

CREATE TABLE Descuentos_obras_sociales
(
	id_desc_obrasSociales int,
	id_obra_social int,
	id_descuento int,
Constraint PK_DESC_OBRASOCIALES PRIMARY KEY (id_desc_obrasSociales),
Constraint FK_DESC_OBRASOCIAL_OBRASOCIALES FOREIGN KEY (id_Obra_social) REFERENCES Obras_Sociales(id_Obra_social),
Constraint FK_DESC_OBRASOCIALES_DESCUENTOS FOREIGN KEY (id_Descuento) REFERENCES Descuentos (id_Descuento)	
)
--------------------------------------------------------
GO
CREATE TABLE Solicitudes
(
	id_solicitud int,
	id_obra_social int,
	fecha datetime
Constraint PK_SOLICITUDES PRIMARY KEY (id_solicitud),
Constraint FK_SOLICITUDES_OBRAS_SOCIALES FOREIGN KEY (id_obra_social) REFERENCES Obras_sociales (id_obra_social)
)
GO
------------------------------------------------------
CREATE TABLE Recetas
(
	id_receta int,
	id_medico int,
	id_cliente int,
	id_obra_social int,
	fecha datetime
Constraint PK_RECETAS PRIMARY KEY (id_receta),
Constraint FK_RECETAS_MEDICOS FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico),
Constraint FK_RECETAS_CLIENTES FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente),
Constraint FK_RECETAS_OBRASOCIALES FOREIGN KEY (id_Obra_social) REFERENCES Obras_Sociales (id_Obra_social)
)
GO
CREATE TABLE Detalles_Recetas
(
	id_Detalle_Receta int,
	id_receta int,
	cantidad int,
	precio_unit money,
	id_suministro int,
Constraint PK_DETALLES_RECETAS PRIMARY KEY (id_detalle_receta),
Constraint FK_DETALLESRE_RECETAS FOREIGN KEY (id_receta) REFERENCES Recetas (id_receta),
Constraint FK_DETALLESRE_SUMINISTROS FOREIGN KEY (id_suministro) REFERENCES Suministros (id_suministro)
)
-------------------------------------------------------------
GO
CREATE TABLE Reintegros_cabezas
(
	id_Reintegro int,
	id_obra_social int,
	fecha datetime,
Constraint PK_REINTEGROS_CABEZAS PRIMARY KEY (id_reintegro),
Constraint FK_REINTEGROS_OBRAS_SOCIALES FOREIGN KEY (id_obra_social) REFERENCES Obras_sociales (id_obra_social)
)
GO
CREATE TABLE Reintegros_Cuerpos
(
	id_Reintegro_cuerpo int,
	id_reintegro int,
	id_Suministro int,
	cantidad int,
	pre_unitario money
Constraint REINT_CUERPOS PRIMARY KEY (id_reintegro_cuerpo),
Constraint REINTEGROS_CUERPOS_CABEZAS FOREIGN KEY (id_reintegro) REFERENCES Reintegros_cabezas (id_reintegro),
Constraint REINTEGROS_CUERPOS_SUMINISTROS FOREIGN KEY (id_Suministro) REFERENCES Suministros (id_Suministro)
)
----------------------------------------------------------

GO
CREATE TABLE Bancos_Cuentas
(
	id_banco_cuenta int,
	banco varchar(50)
Constraint PK_BANCOS_ PRIMARY KEY (id_banco_cuenta)
)


GO
CREATE TABLE Cuentas_Bancarias
(
	id_Cuenta int,
	id_banco_cuenta int,
	id_cliente int,
	cbu varchar (25)
Constraint PK_CUENTAS_BANCARIAS PRIMARY KEY (id_Cuenta),
Constraint FK_CUENTAS_BANCOS FOREIGN KEY (id_banco_cuenta) REFERENCES Bancos_Cuentas (id_banco_cuenta),
Constraint FK_CUENTAS_CLIENTES FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente) 
)
GO
CREATE TABLE Formas_Pagos
(
	id_Forma_pago int,
	id_cuenta int,
	forma_pago varchar(50)
Constraint PK_FORMAS_PAGOS PRIMARY KEY (id_forma_pago),
Constraint FK_FORMASP_CUENTAS FOREIGN KEY (id_cuenta) REFERENCES Cuentas_Bancarias (id_cuenta)
)
-------------------------------------------------
GO
CREATE TABLE Ventas_Cabezas
(
	id_venta_cabeza int,
	id_sucursal int,
	id_forma_pago int,
	fecha datetime,
Constraint PK_VENTAS_CABEZAS PRIMARY KEY (id_venta_cabeza),
Constraint FK_VCABEZAS_SUCURSALES FOREIGN KEY (id_sucursal) REFERENCES Sucursales (id_sucursal),
Constraint FK_VCABEZAS_FORMAS_PAGOS FOREIGN KEY (id_forma_pago) REFERENCES Formas_pagos (id_forma_pago)
)
GO

CREATE TABLE Ventas_Detalles
(
	id_venta_detalle int,
	id_venta_cabeza int,
	cantidad int,
	pre_unitario money,
Constraint PK_VENTALES_DETALLES PRIMARY KEY (id_venta_detalle),
Constraint FK_VDETALLES_CABEZA FOREIGN KEY (id_venta_cabeza) REFERENCES Ventas_Cabezas (id_venta_cabeza)
)
GO
CREATE TABLE Tipos_Compras
(
	id_tipo_compra int,
	tipo_compra varchar(50)
Constraint PK_TIPOS_COMPRAS PRIMARY KEY (id_tipo_compra)
)
GO
CREATE TABLE Compras_Cabezas
(
	id_compra_cabeza int,
	id_tipo_compra int,
	id_forma_pago int,
	id_transporte int,
	fecha datetime
Constraint PK_COMPRAS_CABEZAS PRIMARY KEY(id_compra_cabeza),
Constraint FK_COMPRAS_TCOMPRAS FOREIGN KEY (id_tipo_compra) REFERENCES Tipos_compras (id_tipo_compra),
Constraint FK_COMPRAS_FORMAS_PAGOS FOREIGN KEY (id_forma_pago) REFERENCES Formas_pagos (id_forma_pago),
Constraint FK_COMPRAS_TRANSPORTES FOREIGN KEY (id_transporte) REFERENCES Transportes (id_transporte)
)
GO

CREATE TABLE Compras_Detalles
(
	id_compra_detalle int,
	id_compra_cabeza int,
	id_Suministro int,
	cantidad int,
	pre_unitario money
Constraint PK_COMPRAS_DETALLES PRIMARY KEY (id_compra_detalle),
Constraint FK_COMPRAS_DETALLES_CABEZAS FOREIGN KEY (id_compra_cabeza) REFERENCES Compras_Cabezas(id_compra_cabeza),
Constraint FK_COMPRAS_DETALLES_SUMINISTROS FOREIGN KEY (id_Suministro) REFERENCES Suministros (id_Suministro)
)

-----------------------------------------------------------------------------
--FORMAS PAGOS
INSERT INTO FormasPagos (descripcion) VALUES ('EFECTIVO',1);
INSERT INTO FormasPagos (descripcion) VALUES ('TARJ DEBITO',1);
INSERT INTO FormasPagos (descripcion) VALUES ('TARJ CREDITO',1);
INSERT INTO FormasPagos (descripcion) VALUES ('TRANS BANCARIA',1);
INSERT INTO FormasPagos (descripcion) VALUES ('CHEQUE CPD',1);
INSERT INTO FormasPagos (descripcion) VALUES ('APP QR',1);
INSERT INTO FormasPagos (descripcion) VALUES ('USD',2);
-------------------------------------------------------------
--TIPO COMPROBANTE DE COMPRA
INSERT INTO TipoComprobanteCompra (Tipo) VALUES ('FACTURA A');
INSERT INTO TipoComprobanteCompra (Tipo) VALUES ('FACTURA B');
INSERT INTO TipoComprobanteCompra (Tipo) VALUES ('REMITO X');
-------------------------------------------------------------
--TIPO PRODUCTOS
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('MEDICAMENTOS');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('CUIDADO PERSONAL');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('CUIDADO INFANTIL');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('SALUD Y BIENESTAR');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('PRIMEROS AUXILIOS');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('COSMETICOS Y BELLEZA');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('SALUD SEXUAL');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('ALIMENTOS Y BEBIDAS');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('HIGIENE Y LIMPIEZA');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('ELECTRONICA');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('MASCOTAS');
INSERT INTO TipoProductos (DescripcionTipo) VALUES ('LIBROS');
-------------------------------------------------------------
--PROVINCIAS
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (1, 'Buenos Aires');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (2, 'Catamarca');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (3, 'Chaco');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (4, 'Chubut');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (5, 'Córdoba');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (6, 'Corrientes');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (7, 'Entre Ríos');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (8, 'Formosa');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (9, 'Jujuy');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (10, 'La Pampa');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (11, 'La Rioja');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (12, 'Mendoza');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (13, 'Misiones');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (14, 'Neuquén');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (15, 'Río Negro');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (16, 'Salta');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (17, 'San Juan');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (18, 'San Luis');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (19, 'Santa Cruz');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (20, 'Santa Fe');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (21, 'Santiago del Estero');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (22, 'Tierra del Fuego');
INSERT INTO Provincias (ID_Provincia, Descripcion) VALUES (23, 'Tucumán');
-------------------------------------------------------------
--LOCALIDADES
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (1, 1, 'Mar del Plata');--1
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (2, 2, 'San Fernando del Valle de Catamarca');--2
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (3, 3, 'Resistencia');--3
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (4, 4, 'Puerto Madryn');--4
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (5, 5, 'Villa Carlos Paz');--5
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (6, 6, 'Goya');--6
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (7, 7, 'Concordia');--7
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (8, 8, 'Clorinda');--8
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (9, 9, 'San Pedro de Jujuy');--9
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (10, 10, 'General Pico');--10
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (11, 11, 'Chilecito');--11
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (12, 12, 'San Rafael');--12
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (13, 13, 'Eldorado');--13
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (14, 14, 'San Martín de los Andes');--14
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (15, 15, 'Tartagal');--15
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (16, 16, 'Pocito');--16
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (17, 17, 'Villa Mercedesl');--17
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (18, 18, 'Puerto Deseado');--18
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (19, 19, 'Rosario');--19
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (20, 20, 'La Banda');--20
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (21, 21, 'Río Grande');--21
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (22, 22, 'San Miguel de Tucumán');--22
INSERT INTO Localidades (ID_Localidad, ID_Provincia, Descripcion) VALUES (23, 23, 'Cordoba');--23
-------------------------------------------------------------
--BARRIOS
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (1, 'Palermo');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (2, 'La Chacarita');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (3, 'Villa Centenario');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (4, 'Pueyrredón');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (5, 'Nueva Córdoba');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (6, 'Cambá Cuá');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (7, 'Parque Urquiza');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (8, 'San Francisco');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (9, 'Gorriti');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (10, 'Río Atuel');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (11, 'Matadero');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (12, 'Godoy Cruz');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (13, 'Villa Lanús');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (14, 'Villa María');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (15, 'Belgrano');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (16, 'San Lorenzo');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (17, 'Concepción');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (18, 'Pringles');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (19, '3 de Febrero');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (20, 'Barrio Candioti');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (21, 'Los Flores');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (22, 'Río Grande');
INSERT INTO BARRIOS (ID_Barrio, descripcion) VALUES (23, 'Yerba Buena');
-------------------------------------------------------------
--UNIDADES
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (1, 'Fentolitros');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (2, 'Gramos (g)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (3, 'Gramos por decilitro (g/dL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (4, 'Gramos por litro (g/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (5, 'Microgramos (mcg)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (6, 'Microgramos por decilitro (mcg/dL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (7, 'Microgramos por litro (mcg/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (8, 'Microkats por litro (mckat/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (9, 'Microlitros (mcL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (10, 'Micromoles por litro (mcmol/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (11, 'Miliequivalentes (mEq)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (12, 'Miliequivalentes por litro (mEq/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (13, 'Miligramos (mg)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (14, 'Miligramos por decilitro (mg/dL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (15, 'Miligramos por litro (mg/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (16, 'Mililitros (mL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (17, 'Milímetros (mm)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (18, 'Milímetros de mercurio (mm Hg)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (19, 'Milimoles (mmol)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (20, 'Milimoles por litro (mmol/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (21, 'Miliosmoles por kilogramo de agua (mOsm/kg agua)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (22, 'Miliunidades internacionales por litro (mUI/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (23, 'Miliunidades por gramo (mU/g)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (24, 'Miliunidades por litro (mU/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (25, 'Nanogramos por decilitro (ng/dL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (26, 'Nanogramos por litro (ng/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (27, 'Nanogramos por mililitro (ng/mL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (28, 'Nanogramos por mililitro por hora (ng/mL/h)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (29, 'Nanomoles (nmol)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (30, 'Nanomoles por litro (nmol/L)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (31, 'Picogramos (pg)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (32, 'Picogramos por mililitro (pg/mL)');
INSERT INTO Unidades (ID_Unidad, Descripcion) VALUES (33, 'Picomoles por litro (pmol/L)');
-------------------------------------------------------------
--TIPOS CONTACTOS
insert into Tipos_Contactos (id_tipo_contacto, Descripcion)
values (1,'email')
insert into Tipos_Contactos (id_tipo_contacto, Descripcion)
values (2,'facebook')
insert into Tipos_Contactos (id_tipo_contacto, Descripcion)
values (3,'celular')
insert into Tipos_Contactos (id_tipo_contacto, Descripcion)
values (4,'instagram')
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (1, 'Santander', 266)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (2, 'ICBC', 669)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (3, 'HCBC', 753)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (4, 'Banco Cordoba', 852)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (5, 'Galicia', 654)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (6, 'Naranja', 324)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (7, 'BBVA Frances', 123)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (8, 'Credicoop', 321)
insert into Bancos (ID_Banco, NombreBanco, CodigoUnico)
values (9, 'Bancor', 743)
-------------------------------------------------------------






