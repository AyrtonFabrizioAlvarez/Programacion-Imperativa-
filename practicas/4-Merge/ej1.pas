program ej1;

const
	dimF = 12;
type
	prestamo = record
		isbn:integer;
		numSocio:integer;
		dia:integer;
		mes:integer;
		cantDias:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:prestamo;
		sig:lista;
	end;
	
	prestamoTotal = record	//REGISTRO PARA MERGE ACUMULADOR
		isbn:integer;
		cantDias:integer;
	end;
	
	lista2 = ^nodo2;	//NUEVA LISTA PARA EL REGISTRO QUE UTILIZA EL MERGE ACUMULADOR
	nodo2 = record
		dato:prestamoTotal;
		sig:lista2;
	end;
	
	vector = array [1..dimF] of lista;
	
procedure cargarVectorListas(var V:vector);

	procedure inicarVetorListas(var V:vector);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			V[i]:= nil
	end;

	procedure leerPrestamo(var P:prestamo);
	begin
		writeln('Ingrese el numero de ISBN');
		readln(P.isbn);
		if (P.isbn <> -1) then
		begin
			writeln('Ingrese el numero de socio');
			P.numSocio:= random(1001);
			writeln('Ingrese el dia');
			P.dia:= random(30)+1;
			writeln('Ingrese el mes');
			readln(P.mes);
			writeln('Ingrese la cantidad de dias prestado');
			P.cantDias:= random(11);
		end;
	end;
	
	procedure insertarOrdenado(var L:lista ; P:prestamo);
	var
		nuevo, anterior, actual:lista;
	begin
		new(nuevo);
		nuevo^.dato:= P;
		anterior:= L;
		actual:= L;
		while (actual <> nil) and (actual^.dato.isbn <= P.isbn) do
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
	P:prestamo;
begin
	leerPrestamo(P);
	while (P.isbn <> -1) do
	begin
		insertarOrdenado(V[P.mes], P);
		leerPrestamo(P);
	end;
end;

procedure mostrarVectorListas(V:vector);

	procedure mostrarListaRecursiva(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('ISBN: ', L^.dato.isbn, ' NUMSOCIO: ', L^.dato.numSocio);
			mostrarListaRecursiva(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:=1 to dimF do
	begin
		writeln('MES: ', i);
		mostrarListaRecursiva(V[i]);
	end;
end;

procedure merge (V:vector ; var L:lista);

	procedure minimo(var V:Vector ; var min:prestamo);
	var
		pos, i:integer;
	begin
		min.isbn:= 999;
		pos:= -1;
		for i:= 1 to dimF do
		begin
			if (V[i] <> nil) then
				if (V[i]^.dato.isbn <= min.isbn) then
				begin
					pos:= i;
					min:= V[i]^.dato; 
				end;					
		end;
		if (pos <> -1) then
			V[pos]:= V[pos]^.sig;
	end;
	
	procedure agregarAtras(var L, ultimo:lista ; P:prestamo);
	var
		nuevo:lista;
	begin
		new(nuevo);
		nuevo^.dato:= P;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;

var
	min:prestamo;
	ultimo:lista;
begin
	L:= nil;
	minimo(V, min);
	while (min.isbn <> 999) do
	begin
		agregarAtras(L, ultimo, min);
		minimo(V, min);
	end;
end;

procedure mostrarListaRecursiva(L:lista);
begin
	if (L <> nil) then
	begin
		writeln('ISBN: ', L^.dato.isbn, ' NUMSOCIO: ', L^.dato.numSocio);
		mostrarListaRecursiva(L^.sig);
	end;
end;

procedure mergeAcumulador(V:vector ; var L:lista2);

	procedure minimo(var V:vector ; var min:prestamo);
	var
		pos, i:integer;
	begin
		min.isbn:= 999;
		pos:= -1;
		for i:=1 to dimF do
		begin
			if (V[i] <> nil) then
				if (V[i]^.dato.isbn < min.isbn) then
				begin
					pos:= i;
					min:= V[i]^.dato;
				end;
		end;
		if (pos <> -1) then
			V[pos]:= V[pos]^.sig
	end;
	
	procedure agregarAtras(var L, ultimo:lista2 ; P:prestamoTotal);
	var
		nuevo:lista2;
	begin
		new(nuevo);
		nuevo^.dato:= P;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;

var
	min:prestamo;
	actual:prestamoTotal;
	ultimo:lista2;
begin
	L:= nil;
	minimo(V, min);
	while (min.isbn <> 999) do
	begin
		actual.isbn:= min.isbn;
		actual.cantDias:= 0;
		while (actual.isbn = min.isbn) do
		begin
			actual.cantDias:= actual.cantDias + 1;
			minimo(V, min);
		end;
		agregarAtras(L, ultimo, actual);
	end;
end;

procedure mostrarListaRecursiva2(L:lista2);
begin
	if (L <> nil) then
	begin
		writeln('ISBN: ', L^.dato.isbn, ' TOTAL PRESTAMOS: ', L^.dato.cantDias);
		mostrarListaRecursiva2(L^.sig);
	end;
end;

var
	V:vector;
	//L:lista;
	L2:lista2;
BEGIN
	Randomize;
	cargarVectorListas(V);
	//mostrarVectorListas(V);
	//merge(V, L);
	//mostrarListaRecursiva(L);
	writeln;
	mergeAcumulador(V, L2);
	mostrarListaRecursiva2(L2);
END.
