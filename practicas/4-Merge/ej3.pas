program ej3;

const
	dimF = 4;
type
	venta = record
		fecha:integer;
		codProducto:integer;
		codSucursal:integer;
		cantVendidas:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:venta;
		sig:lista;
	end;
	
	vectorListas = array [1..dimF] of lista;
	
	
procedure cargarVectorListas(var V:vectorListas);

	procedure iniciarVectorListas(var V:vectorListas);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			V[i]:= nil
	end;
	
	procedure leerVenta(var V:venta);
	begin
		writeln('Ingrese el codigo de SUCURSAL');
		readln(V.codSucursal);
		if (V.codSucursal <> 0) then
		begin
			writeln('Ingrese el codigo de PRODUCTO');
			readln(V.codProducto);//random(1001);
			//writeln('Ingrese la cantidad vendida');
			V.cantVendidas:= random(11);
			//writeln('Ingrese la fecha de la venta');
			V.fecha:= random(30)+1;
		end;
	end;
	
	procedure insertarOrdenado(var L:lista ; V:venta);
	var
		nuevo, anterior, actual:lista;
	begin
		new(nuevo);
		nuevo^.dato:= V;
		anterior:= L; actual:= L;
		while (actual <> nil) and (actual^.dato.codProducto <= V.codProducto) do
		begin
			anterior:= actual;
			actual:= actual^.sig;
		end;
		if (anterior = actual) then
			L:= nuevo
		else
			anterior^.sig:= nuevo;
		nuevo^.sig:= actual;
	end;

var
	vent:venta;
begin
	iniciarVectorListas(V);
	leerVenta(vent);
	while (vent.codSucursal <> 0) do
	begin
		insertarOrdenado(V[vent.codSucursal], vent);
		leerVenta(vent);
	end;
end;

procedure mostrarVectorListas(V:vectorListas);

	procedure mostrarLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('Producto: ', L^.dato.codProducto, '	Cantidad: ', L^.dato.cantVendidas);
			mostrarLista(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:= 1 to dimF do
	begin
		writeln('Sucursal: ', i);
		mostrarLista(V[i]);
		writeln;
	end;
end;

procedure mergeAcumulador(V:vectorListas ; var L:lista);

	procedure minimo(var V:vectorListas ; var min:venta);
	var
		pos, i:integer;
	begin
		min.codProducto:= 999;
		pos:= -1;
		for i:=1 to dimF do
		begin
			if (V[i] <> nil) then
				if (V[i]^.dato.codProducto <= min.codProducto) then
				begin
					min:= V[i]^.dato;
					pos:= i
				end;
		end;
		if (pos <> -1) then
			V[pos]:= V[pos]^.sig
	end;
	
	procedure agregarAtras(var L, ultimo:lista ; V:venta);
	var
		nuevo:lista;
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
var
	actual, min:venta;
	ultimo:lista;
begin
	minimo(V, min);
	while (min.codProducto <> 999) do
	begin
		actual:= min;
		actual.cantVendidas:= 0;
		while (actual.codProducto = min.codProducto) do
		begin
			actual.cantVendidas:= actual.cantVendidas + min.cantVendidas;
			minimo(V, min);
		end;
		agregarAtras(L, ultimo, actual);
	end;
end;


procedure mostrarLista(L:lista);
begin
	if (L <> nil) then
	begin
		writeln('Producto: ', L^.dato.codProducto, '	Cantidad: ', L^.dato.cantVendidas);
		mostrarLista(L^.sig);
	end;
end;
	
var
	V:vectorListas;
	L:lista;
BEGIN
	Randomize;
	cargarVectorListas(V);
	mostrarVectorListas(V);
	writeln;
	mergeAcumulador(V, L);
	mostrarLista(L);
END.
		
