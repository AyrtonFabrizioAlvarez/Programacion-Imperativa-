
program ej4;

const
dimF = 7;
type
	entrada = record
		dia: integer;
		codigo: integer;
		asiento: integer;
		monto: integer;
	end;
	lista= ^nodo;
	nodo = record
		dato: entrada;
		sig: lista;
	end;
	
	arrListas = array [1..dimF] of lista;
	
	entrada2 = record
		codigo: integer;
		entradas: integer;
	end;
	lista2 = ^nodo2;
	nodo2 = record
		dato: entrada2;
		sig: lista2;
	end;

procedure cargarVectorListas (var arr: arrListas);


	procedure iniciarArray(var arr: arrListas);
	var
		i: integer;
	begin
		for i:= 1 to dimF do
			arr[i]:= nil
	end;
	
	procedure leerEntrada(var E: entrada);
	begin
		writeln('Ingrese el codigo de obra');
		readln(E.codigo);
		if (E.codigo <> 0) then
		begin
			writeln ('Ingrese el dia de la entrada');
			readln (E.dia);
			writeln ('Ingese el numero de asiento');
			readln (E.asiento);
			writeln ('Ingrese el monto de la entrada');
			readln (E.monto);
		end;
	end;
	
	procedure insertarOrdenado(var L: lista ; E: entrada);
	var
		nuevo, anterior, actual: lista;
	begin
		new(nuevo);
		nuevo^.dato:= E;
		anterior:= L;
		actual:= L;
		while (actual <> nil) and (actual^.dato.codigo < E.codigo) do
		begin
			anterior:= actual;
			actual:= actual^.sig;
		end;
		if (anterior = actual) then
			L:= nuevo
		else
			anterior^.sig:= nuevo;
		nuevo^.sig:= actual
	end;

var
	E: entrada;
begin
	iniciarArray (arr);
	leerEntrada (E);
	while (E.codigo <> 0) do
	begin
		insertarOrdenado (arr[E.dia], E);
		leerEntrada(E);
	end;
end;


procedure mergeAcumulador(arr: arrListas ; var L: lista2);

	procedure agregarAtras(var L: lista2 ; var ultimo: lista2 ; E: entrada2);
	var
		nuevo: lista2;
	begin
		new(nuevo);
		nuevo^.dato:= E;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;

	procedure minimo(var arr: arrListas ; var min: entrada);
	var
		i, pos: integer;
	begin
		pos:= -1;
		min.codigo:= 9999;
		for i:= 1 to dimF do
		begin
			if (arr[i] <> nil) then
				if (arr[i]^.dato.codigo < min.codigo) then
				begin
					min:= arr[i]^.dato;
					pos:= i;
				end;
		end;
		if (pos <> -1) then
			arr[pos]:= arr[pos]^.sig
	end;

var
 min: entrada;
 actual: entrada2;
 ultimo: lista2;
begin
	minimo(arr, min);
	actual.codigo:= min.codigo;
	while (min.codigo <> 9999) do
	begin
		actual.entradas:= 0;
		while (actual.codigo = min.codigo) do
		begin
			actual.entradas:= actual.entradas + 1;
			minimo(arr, min);
		end;
		agregarAtras(L, ultimo, actual)
	end;
end;



procedure mostrarListaRecursiva(L: lista2);
begin
	if (L <> nil) then
	begin
		writeln('Para la obra con codigo ', L^.dato.codigo, ' se vendieron ', L^.dato.entradas, ' entradas');
		mostrarListaRecursiva(L^.sig);
	end;
		
end;

 

var
	arr: arrListas;
	L: lista2;
BEGIN
	cargarVectorListas (arr);
	mergeAcumulador (arr, L);
	mostrarListaRecursiva (L);
	
END.

