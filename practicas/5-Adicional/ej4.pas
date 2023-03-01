program ej4;

const
	dimF = 7;
type
	entrada = record
		dia:integer;
		codigo:integer;
		monto:integer;
		asiento:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:entrada;
		sig:lista;
	end;
	
	entradasTotales = record
		codigo:integer;
		entradas:integer;
	end;
	
	lista2 = ^nodo2;
	nodo2 = record
		dato:entradasTotales;
		sig:lista2;
	end;
	
	vector = array [1..7] of lista;

procedure cargarVectorListas(var V:vector);

	procedure iniciarVectorListas(var V:vector);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			V[i]:= nil
	end;

	procedure leerEntrada(var E:entrada);
	begin
		writeln('Ingrese el codigo de entrada');
		readln(E.codigo);
		if (E.codigo <> 0) then
		begin
			writeln('Ingrese el dia de la entrada');
			readln(E.dia);
			//writeln('Ingrese el monto de la entrada');
			E.monto:= random(1001);
			//writeln('Ingrese el asiento de la entrada');
			E.asiento:= random(101);
		end;
	end;

	procedure insertarOrdenado(var L:lista ; E:entrada);
	var
		nuevo, anterior, actual:lista;
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
	E:entrada;
begin
	iniciarVectorListas(V);
	leerEntrada(E);
	while (E.codigo <> 0) do
	begin
		insertarOrdenado(V[E.dia], E);
		leerEntrada(E);
	end;
end;


procedure mergeAcumulador(V:vector ; var L:lista2);

	procedure minimo(var V:vector ; var min:entrada);
	var
		i, pos:integer;
	begin
		min.codigo:= 999;
		pos:= -1;
		for i:= 1 to dimF do
		begin
			 if (V[i] <> nil) then
				if (V[i]^.dato.codigo < min.codigo) then
				begin
					pos:= i;
					min:= V[i]^.dato;
				end;
		end;
		if (pos <> -1) then
			V[pos]:= V[pos]^.sig;
	end;
	
	procedure agregarAtras(var L, ultimo:lista2 ; E:entradasTotales);
	var
		nuevo:lista2;
	begin
		new(nuevo);
		nuevo^.dato:= E;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo
	end;

var
	actual:entradasTotales;
	min:entrada;
	ultimo:lista2;
begin
	L:= nil;
	minimo(V, min);
	while (min.codigo <> 999) do
	begin
		actual.codigo:= min.codigo;
		actual.entradas:= 0;
		while (actual.codigo = min.codigo) do
		begin
			actual.entradas:= actual.entradas + 1;
			minimo(V, min);
		end;
		agregarAtras(L, ultimo, actual);
	end;
end;


procedure mostrarListaRecursiva(L:lista2);
begin
	if (L <> nil) then
	begin
		writeln('Para la obra con codigo ', L^.dato.codigo, ' se vendieron ', L^.dato.entradas, ' entradas');
		mostrarListaRecursiva(L^.sig);
	end;
end;


VAR
	V:vector;
	L:lista2;
BEGIN
	cargarVectorListas(V);
	mergeAcumulador(V, L);
	mostrarListaRecursiva(L);
END.
