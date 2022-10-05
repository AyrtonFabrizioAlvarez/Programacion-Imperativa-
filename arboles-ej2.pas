{
2-  Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.  
}
program ej2;

{a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, 
fecha y cantidad de unidades vendidas. La lectura finaliza con el código de producto 0.
Un producto puede estar en más de una venta. Se pide:}

type

	venta = record
		codigo: integer;
		fecha: integer;
		cantVendidas: integer;
	end;
	arbol1 = ^nodoArbol;
	nodoArbol = record
		dato: venta;
		HI: arbol1;
		HD: arbol1;
	end;

	ventaCompleta = record
		codigo: integer;
		totalVendidas: integer;
	end;
	arbol2 = ^nodoArbol2;
	nodoArbol2 = record	
		dato: ventaCompleta;
		HI: arbol2;
		HD: arbol2;
	end;
	
procedure generarArbol (var a1: arbol1; var a2:arbol2);
	
	procedure leerVenta (var V:venta);
	begin
		writeln('Ingrese el codigo de producto');
		readln(V.codigo);
		if (V.codigo <> 0) then begin
				writeln('Ingrese la fecha de venta');
				readln(V.fecha);
				writeln('Ingrese la cantidad vendida');
				readln(V.cantVendidas);
		end;
	end;
	{i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.}

	procedure insertarNodoArbol1 (var a: arbol1 ; V: venta);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:= V;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
			if (V.codigo < a^.dato.codigo) then
				insertarNodoArbol1(a^.HI, V)
			else
				insertarNodoArbol1(a^.HD,V)
	end;

	{ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.}
	procedure insertarNodoArbol2( var a:arbol2 ; V: ventaCompleta);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:= V;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
			if ((V.codigo = a^.dato.codigo)) then
				a^.dato.totalVendidas:= a^.dato.totalVendidas + V.totalVendidas
			else
				if (V.codigo < a^.dato.codigo) then
					insertarNodoArbol2(a^.HI, V)
				else
					insertarNodoArbol2(a^.HD, V)
	end;
var
	V: venta;
	V2: ventaCompleta;
begin
	leerVenta(V);
	while (V.codigo <> 0) do begin
		writeln('Generando arbol 1');
		insertarNodoArbol1(a1, V);

		V2.codigo:= V.codigo;
		V2.totalVendidas:=  V.cantVendidas; 

		writeln('Generando arbol 2');
		insertarNodoArbol2(a2, V2);

		leerVenta(V);
	end;
end;

{b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.}
procedure totalVentasProducto (a: arbol1);

	function totalVentas1(a:arbol1 ; num: integer):integer;
	begin
		if(a = nil) then
			totalVentas1:= 0
		else
			if (a^.dato.codigo = num) then
			begin
				if (num < a^.dato.codigo) then
					totalVentas1:= totalVentas1(a^.HI, num) + a^.dato.cantVendidas
				else
					totalVentas1:= totalVentas1(a^.HD, num) + a^.dato.cantVendidas
			end
			else begin
				if (num < a^.dato.codigo) then
					totalVentas1:= totalVentas1(a^.HI, num)
				else
					totalVentas1:= totalVentas1(A^.HD, num)
			end;

	end;	
var
	num: integer;
begin
	writeln('Ingrese el codigo de producto del cual desea saber el total de ventas');
	readln(num);
	writeln('El total de ventas para el producto codigo ', num, ' es de ',	totalVentas1(a, num));
end;



	{c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.}
procedure totalVentasProducto2 (a:arbol2);

	function totalVentas2 (a:arbol2 ; num: integer):integer;
	begin
		if (a = nil) then
			totalVentas2:= 0
		else
			if (a^.dato.codigo = num) then
				totalVentas2:= a^.dato.totalVendidas
			else 
				if (num < a^.dato.codigo) then
					totalVentas2:= totalVentas2(a^.HI, num)
				else
					totalVentas2:= totalVentas2(a^.HD, num)
	end;
var
	num: integer;
begin
	writeln('Ingrese el codigo de producto del cual desea saber el total de ventas');
	readln(num);
	writeln('El total de ventas para el producto codigo ', num, ' es de ',	totalVentas2(a, num));
end;


var
	a1: arbol1;
	a2: arbol2;

BEGIN
	generarArbol(a1, a2);
	totalVentasProducto(a1);
	totalVentasProducto2(a2);
END.

