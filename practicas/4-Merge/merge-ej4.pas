
program ej4;

const
	dimF = 7;

type
	entrada = record
		dia: integer;
		cod: integer;
		asiento: integer;
		monto: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: entrada;
		sig: lista;
	end;
	
	arrListas = array [1..dimF] of lista;
	
	entrada2 = record
		cod: integer;
		vendidas: integer;
	end;
	lista2 = ^nodo2;
	nodo2 = record
		dato: entrada2;
		sig: lista2;
	end;
	
	
procedure generarVectorListas (var arr: arrListas);

	procedure iniciarArray (var arr: arrListas);
	var
		i:integer;
	begin
		for i:= 1 to dimF do
			arr[i]:= nil
	end;
	
	procedure leerEntrada (var E: entrada);
	begin
		writeln('Ingrese el codigo de la obra');
		readln(E.cod);
		if (E.cod <> 0) then
		begin
			writeln('Ingrese el dia correspondiente');
			readln(E.dia);
			writeln('Ingrese el asiento');
			readln(E.asiento);
			writeln('Ingrese el monto');
			readln(E.monto);
		end;
	end;

	procedure insertarOrdenado (var L: lista ; E: entrada);
	var
		nuevo, actual, anterior: lista;
	begin
		new(nuevo);
		nuevo^.dato:= E;
		nuevo^.sig:= nil;
		actual:= L;
		anterior:= L;
		while (actual <> nil) and (E.cod < actual^.dato.cod) do
		begin
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
	E: entrada;
begin
	iniciarArray(arr);
	leerEntrada(E);
	while (E.cod <> 0) do
	begin
		insertarOrdenado(arr[E.dia], E);
		leerEntrada(E);
	end;
end;



procedure mergeAcumulador (arr: arrListas ; var L: lista2);

	procedure agregarAtras(var L: lista2 ; var ultimo: lista2 ; actual: entrada2);
	var
		nuevo: lista2;
	begin
		new(nuevo);
		nuevo^.dato:= actual;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;

	procedure minimo (var arr: arrListas ; var min: entrada);
	var
		pos, i: integer;
	begin
		min.cod:= 9999;
		pos:= -1;
		for i:= 1 to dimF do
		begin
			if (arr[i] <> nil) then
				if (arr[i]^.dato.cod <= min.cod) then
				begin
					min:= arr[i]^.dato;
					pos:= i;
				end;
		end;
		if (pos <> -1) then
			arr[pos]:= arr[pos]^.sig;
	end;

var
	min: entrada;
	actual: entrada2;
	ultimo: lista2;
begin
	minimo(arr, min);
	while (min.cod <> 9999) do
	begin
		actual.cod:= min.cod;
		actual.vendidas:= 0;
		while (min.cod = actual.cod) do
		begin
			actual.vendidas:= actual.vendidas + 1;
			minimo(arr, min);
		end;
	agregarAtras(L, ultimo, actual)
	end;
end;



var
	arr: arrListas;
	L: lista2;
BEGIN
	generarVectorListas(arr);
	mergeAcumulador(arr, L);
END.

