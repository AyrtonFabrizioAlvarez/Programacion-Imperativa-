program ej1;

const dimF= 20;

type
	
	venta = record
		codigo: integer;
		cantVendidas: integer;
	end;
	
	vectorVentas = array [1..dimF] of venta;
	
procedure leerVenta (var V: venta);
begin
	Randomize;
	V.codigo:= Random(16);
	if (V.codigo <> 0 ) then
	begin
		writeln('Ingrese la cantidad vendidas para el codigo ', V.codigo);
		readln(V.cantVendidas);
	end;
end;

procedure cargarVector (var V:vectorVentas ; var dimL: integer);
var
	vent: venta;
begin
	dimL:= 0;
	leerVenta(vent);
	while (vent.codigo <> 0) and (dimL < dimF) do
	begin
		V[dimL]:= vent;
		dimL:= dimL + 1;
		leerVenta(vent);
	end;
end;

procedure mostrarVector(V:vectorVentas ; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
	begin
		writeln (i,')- Codigo producto es: ',v[i].codigo, '. Cantidad vendida: ', v[i].cantVendidas);
		writeln('');
	end;
end;

procedure ordenarVector (var V:vectorVentas ; dimL:integer);
var
	i, j, pos: integer;
	item: venta;
begin
	for i:=1 to dimL-1 do
	begin
		pos:= i;
		for j:= i+1 to dimL do
		begin
			if(V[j].codigo < V[pos].codigo) then
				pos:= j;
		end;
		item:= V[pos];
		V[pos]:= V[i];
		V[i]:= item;
	end;
end;


procedure eliminar (var V:vectorVentas ; dimL:integer ; inf, sup:integer);

	procedure posicionInferior (V:vectorVentas ; x:integer ; var pos:integer);
	var
		i:integer;
	begin
		while (i <= dimL) and (x > V[i].codigo) do
		begin
			i:= i + 1;
		end;
		if (i > dimL) then
			pos:= i;
	end;
	procedure posicionSuperior (V:vectorVentas ; x:integer ; var pos:integer);
	var
		i:integer;
	begin
		while (i >= dimL) and (x < V[i].codigo) do
		begin
			i:= i + 1;
		end;
		if (i > dimL) then
			pos:= i;
	end;
var
	posInf, posSup, x, elemTotales, i, aux: integer;
begin
	writeln('Cual es el minimo codigo entre el que desea eliminar los elementos');
	readln(x);
	posicionInferior(V, x, posInf)
	writeln('Cual es el maximo codigo entre el que desea eliminar los elementos');
	readln(x);
	posicionSuperior(V, x, posSup)
	
	writeln('La posicion inferior es ', posInf):
	writeln('La posicion superior es ', posSup):
	
	elemTotales:= posSup - posInf + 1;
	
	for i:= posSup+1 to dimL do
	begin
		
	end;
	dimL:= dimL - elemTotales;
end;

var
	V: vectorVentas;
	dimL: integer;
BEGIN
	Random;
	
	cargarVector(V, dimL);
	mostrarVector(V, dimL);
	
	ordenarVector(V, dimL);
	mostrarVector(V, dimL);
END.

