program ej4;

const
	dimF = 7;
type
	entrada = record
		dia:integer;
		codigo:integer;
		asiento:integer;
		monto:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:entrada;
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

	procedure leerEntrada(var E:entrada);
	begin
		writeln('Ingrese el codigo de Obra');
		readln(E.codigo);
		if (E.codigo <> 0) then
		begin
			writeln('Ingrese el dia de la entrada');
			readln(E.dia);
			//writeln('Ingrese el numero de asiento');
			E.asiento:= random(101);
			//writeln('Ingrese el monto de la entrada');
			E.monto:= random(11);
		end;
	end;
	
	procedure insertarOrdenado(var L:lista ; E:entrada);
	var
		nuevo, anterior, actual:lista;
	begin
		new(nuevo);
		nuevo^.dato:= E;
		anterior:= L; actual:= L;
		while (actual <> nil) and (actual^.dato.codigo < E.codigo) do
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

procedure mostrarVectorListas(V:vectorListas);

	procedure mostrarLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('Codigo: ', L^.dato.codigo, ' Monto: ', L^.dato.monto);
			mostrarLista(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:=1 to dimF do
	begin
		writeln('DIA: ', i);
		mostrarLista(V[i]);
	end;
end;

procedure mergeAcumulador (V:vectorListas ; var L:lista);

	procedure minimo(var V:vectorListas ; var min:entrada);
	var
		pos, i:integer;
	begin
		min.codigo:= 999;
		pos:= -1;
		for i:=1 to dimF do
		begin
			if (V[i] <> nil) then
			begin
				if (V[i]^.dato.codigo <= min.codigo) then
				begin
					pos:= i;
					min:= V[i]^.dato;
				end;
			end;
		end;
		if (pos <> -1) then
			v[pos]:= v[pos]^.sig
	end;
	
	procedure agregarAtras(var L, ultimo:lista ; E:entrada);
	var
		nuevo:lista;
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

var
	min, actual:entrada;
	ultimo:lista;
begin
	minimo(V, min);
	while (min.codigo <> 999) do
	begin
		actual:= min;
		actual.monto:= 0;
		while (actual.codigo = min.codigo) do
		begin
			actual.monto:= actual.monto + min.monto;
			minimo(V, min);
		end;
		agregarAtras(L, ultimo, actual);
	end;
end;

procedure mostrarLista(L:lista);
begin
	if (L <> nil) then
	begin
		writeln('Codigo: ', L^.dato.codigo, ' Monto Total: ', L^.dato.monto);
		mostrarLista(L^.sig);
	end;
end;


var
	V:vectorListas;
	L:lista;
BEGIN
	cargarVectorListas(V);
	mostrarVectorListas(V);
	mergeAcumulador(V, L);
	mostrarLista(L);
END.
