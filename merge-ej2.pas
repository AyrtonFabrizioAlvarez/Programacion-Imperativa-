{
3- Implementar un programa que procese la información de las ventas de productos de una librería que tiene 4 sucursales.
* De cada venta se lee fecha de venta, código del producto vendido, código de sucursal y cantidad vendida.
* El ingreso de las ventas finaliza cuando se lee el código de sucursal 0. Implementar un programa que:
a- Almacene las ventas ordenadas por código de producto y agrupados por sucursal, en una estructura de datos adecuada.
b- Contenga un módulo que reciba la estructura generada en el punto a y retorne una estructura donde esté acumulada
* la cantidad total vendida para cada código de producto.
}

program ej3;

const
	dimF = 4;
	
type
	
	venta = record
		fecha: integer;
		codProd: integer;
		codSucursal: integer;
		vendidas: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: venta;
		sig: lista;
	end;

	venta2 = record
		codProd: integer;
		vendidas: integer;
	end;
	lista2 = ^nodo2;
	nodo2 = record
		dato: venta2;
		sig: lista2;
	end;

	arrListas = array [1..dimF] of lista;
	
procedure cargarVectorListas(var arr: arrListas);

	procedure inicializarVectorListas(var arr: arrListas);
	var
		i: integer;
	begin
		for i:=1 to dimF do
			arr[i]:= nil;
	end;

	procedure leerVenta (var V:venta);
	begin
		writeln('Ingrese el codigo de la sucursal');
		readln(V.codSucursal);
		if (V.codSucursal <> 0) then
		begin
			writeln('Ingrese la fecha de venta');
			readln(V.fecha);
			writeln('Ingrese el codigo de producto');
			readln(V.codProd);
			writeln('Ingrese la cantidad de ventas');
			readln(V.vendidas);
		end;
	end;
	
	procedure insertarOrdenado(var L: lista ; V: venta);
	var
		nuevo, anterior, actual: lista;
	begin
		new(nuevo);
		nuevo^.dato:= V;
		anterior:= L;
		actual:= L;
		while (actual <> nil) and (V.codProd <= actual^.dato.codProd) do
		begin
			anterior:= actual;
			actual:= actual^.sig;
		end;
		if (anterior = actual) then
			L:= nuevo
		else
			anterior^.sig:= nuevo
		nuevo^.sig:= actual;
	end;
	
var
	V: venta;
begin
	inicializarVectorListas(arr)
	leerVenta(V);
	while (V.venta <> 0) do
	begin
		insertarOrdenado(arr[V.codSucursal], V);
		leerVenta(V);
	end;
end;


{b- Contenga un módulo que reciba la estructura generada en el punto a y retorne una estructura donde esté acumulada
* la cantidad total vendida para cada código de producto.}
procedure mergeAcumulador (arr: arrListas ; var L: lista2);



var
begin

end;

var
	arr: arrListas;
	L: lista2;
BEGIN
	cargarVectorListas(arr);
	mergeAcumulador(arr, L);
END.

