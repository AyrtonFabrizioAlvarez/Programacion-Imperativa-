

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
	
	ventaTotal = record
		codProd: integer;
		vendidas: integer;
	end;
	lista2 = ^nodo2;
	nodo2 = record
		dato: ventaTotal;
		sig: lista2;
	end;

	arrListas = array [1..dimF] of lista;
	
procedure cargarVectorListas(var arr: arrListas);

	procedure leerVenta (var V:venta);
	begin
		writeln('Ingrese el codigo de la sucursal');
		readln(V.codSucursal);
		if (V.codSucursal <> -1) then
		begin
			{writeln('Ingrese la fecha de venta');
			readln(V.fecha);}
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
		nuevo^.sig:= nil;
		anterior:= L;
		actual:=L;
		while (actual <> nil) and (V.codProd <= actual^.dato.codProd) do begin
			anterior:= actual;
			actual:= actual^.sig;
		end;
		if (actual = anterior) then
			L:= nuevo
		else
			anterior^.sig:= nuevo;
		nuevo^.sig:= actual;
	end;
		
var
	V: venta;
begin
	leerVenta(V);
	while (V.codSucursal <> -1) do begin
		insertarOrdenado(arr[V.codSucursal], V);
		leerVenta(V);
	end;
end;


procedure mergeAcumulador (arr: arrListas ; var L: lista2);

	procedure agregarAtras (var L: lista2; var ultimo: lista2 ; V: ventaTotal);
	var
		nuevo: lista2;
	begin
		new(nuevo);
		nuevo^.dato:= V;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;
	
	procedure minimo (var arr: arrListas ; var min: venta);
	var
		pos, i: integer;
	begin
		min.codProd:= 999;
		pos:= -1;
		for i:=1 to dimF do
		begin
			if (arr[i] <> nil) then
				if (arr[i]^.dato.codProd <= min.codProd) then
				begin
					pos:= i;
					min:= arr[i]^.dato;
				end;
		end;
		if (pos <> -1) then
			arr[pos]:= arr[i]^.sig;
	end;
	
var
	ultimo: lista2;
	min: venta;
	actual: ventaTotal;
	
begin
	writeln('antes del minimo');
	minimo (arr, min);
	writeln('despues del minimo');
	while (min.codProd <> 999) do
	begin
		actual.codProd:= min.codProd;
		actual.vendidas:= 0;
		
		while (actual.codProd = min.codProd) do
		begin
			actual.vendidas:= actual.vendidas + min.vendidas;
			minimo (arr, min)
		end;
		agregarAtras(L, ultimo, actual)
	end;
end;


procedure mostrarLista(L: lista2);
begin
	if(L <> nil) then begin
		writeln('CodPRod: ',L^.dato.codProd,' VentaTotales: ',L^.dato.codProd,'.');
		mostrarLista(L^.sig);
	end;
end; 



var
	arr: arrListas;
	L: lista2;
BEGIN
	cargarVectorListas(arr);
	mergeAcumulador(arr, L);
	mostrarLista(L);
END.


