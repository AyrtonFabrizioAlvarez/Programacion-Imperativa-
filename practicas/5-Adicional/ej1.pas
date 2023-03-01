program ej1;

const
	dimF = 300;
type
	oficina = record
		codigo:integer;
		dni:integer;
		expensas:integer;
	end;
	
	vectorOficinas = array [1..dimF] of oficina;

procedure cargarVector(var V:vectorOficinas ; var dimL:integer);

	procedure leerOficina(var O:oficina);
	begin
		writeln('Ingrese el codigo de la oficina');
		readln(O.codigo);
		if (O.codigo <> -1) then
		begin
			//writeln('Ingrese el dni del propietario');
			O.dni:= random(10001);
			//writeln('Ingrese el monto de las expensas');
			O.expensas:= random(1001);
		end;
	end;

var
	O:oficina;
begin
	leerOficina(O);
	while (dimL < dimF) and (O.codigo <> -1) do
	begin
		dimL:= dimL + 1;
		V[dimL]:= O;
		leerOficina(O);
	end;
end;

procedure mostrarVector(V:vectorOficinas ; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln('Codigo: ', V[i].codigo, ' Dni: ', V[i].dni, ' Expensas: ', V[i].expensas);
end;

procedure ordenSeleccion(var V:vectorOficinas ; dimL:integer);
var
	i, j, pos:integer;
	item: oficina;
begin
	for i:=1 to dimL-1 do
	begin
		pos:= i;
		for j:=i+1 to dimL do
			if (V[j].codigo < V[pos].codigo) then
				pos:= j;
		item:= V[pos];
		V[pos]:= V[i];
		V[i]:= item;
	end;		
end;

procedure busquedaDicotomica(V:vectorOficinas ; dimL:integer);

	procedure busqueda (V:vectorOficinas ; primero, ultimo, dato:integer ; var pos:integer);
	var
		medio:integer;
	begin
		if (primero > ultimo) then
			pos:= -1
		else
		begin
			medio:= (primero + ultimo) DIV 2;
			if (dato = V[medio].codigo) then
				pos:= medio
			else
				if (dato > V[medio].codigo) then
					busqueda(V, medio+1, ultimo, dato, pos)
				else
					busqueda(V, primero, medio-1, dato, pos)
		end;
	end;

var
	dato:integer;
	pos:integer;
begin
	writeln('Ingrese el codigo de oficina a buscar');
	readln(dato);
	pos:= 0;
	busqueda(V, 1, dimL, dato, pos);
	if (pos <> -1) then
		writeln('Dni del propietario es: ', V[pos].dni)
	else
		writeln('El codigo buscado no existe')
end;


var
	V:vectorOficinas;
	dimL:integer;
BEGIN
	Randomize;
	dimL:= 0;
	cargarVector(V, dimL);
	mostrarVector(V, dimL);
	writeln;
	ordenSeleccion(V, dimL);
	mostrarVector(V, dimL);
	writeln;
	busquedaDicotomica(V, dimL);
END.
