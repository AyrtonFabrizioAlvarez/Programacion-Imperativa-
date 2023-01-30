program ej4;

const
	dimF = 8;
	
type
	producto = record
		codigo:integer;
		rubro:integer;
		precio:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:producto;
		sig:lista;
	end;
	
	vectorProd = array [1..dimF] of lista;
	vector3 = array [1..30] of producto;
	
procedure cargarVector (var V:vectorProd);

	procedure iniciarVector (var V:vectorProd);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			V[i]:= nil;
	end;
	
	procedure leerProducto(var P:producto);
	begin
		Randomize;
		writeln('Ingrese el precio del producto');
		readln(P.precio);
		if (P.precio <> 0) then
		begin
			writeln('Ingrese el rubro del producto');
			readln(P.rubro);
			writeln('Ingrese el codigo del producto');
			P.codigo:= random(1000);
		end;
	end;
	
	procedure insertarOrdenado(var L:lista ; P:producto);
	var
		nuevo, actual, anterior:lista;
	begin
		new(nuevo);
		nuevo^.dato:= P;
		actual:= L;
		anterior:= L;
		while (actual <> nil) and (actual^.dato.codigo < P.codigo) do
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
	P:producto;
begin
	iniciarVector(V);
	leerProducto(P);
	while (P.precio <> 0) do
	begin
		insertarOrdenado(V[P.rubro], P);
		leerProducto(P);
	end;
end;


procedure mostrarCodigos(var V:vectorProd);

	procedure recorrerLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('Codigo: ', L^.dato.codigo);
			recorrerLista(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:=1 to dimF do
	begin
		writeln('RUBRO: ', i);
		recorrerLista(V[i])
	end;
end;

procedure filtrarRubro3(L:lista ; var V:vector3 ; var dimL:integer);
begin
	if (L <> nil) and (dimL < 30) then
	begin
		dimL:= dimL + 1;
		V[dimL]:= L^.dato;
		filtrarRubro3(L^.sig, V, dimL);
	end;
end;

procedure ordenSeleccion(var V:vector3 ; var dimL:integer);
var
	i, j, pos:integer;
	item:producto;
begin
	for i:=1 to dimL-1 do
	begin
		pos:= i;
		for j:=i+1 to dimL do
		begin
			if (V[j].precio < V[pos].precio) then
				pos:= j;
		end;
		item:= V[pos];
		V[pos]:= V[i];
		V[i]:= item;
	end;
end;

procedure mostrarVector(V:vector3 ; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln(i, ':', V[i].precio);
end;

var
	V:vectorProd;
	V3:vector3;
	dimL:integer;
BEGIN
	Random;
	dimL:= 0;
	cargarVector(V);
	mostrarCodigos(V);
	filtrarRubro3(V[3], V3, dimL);
	mostrarVector(V3, dimL);
	ordenSeleccion(V3, dimL);
	writeln('');
	mostrarVector(V3, dimL);
END.

