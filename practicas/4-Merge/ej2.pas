program ej2;

const
	dimF = 8;
type
	pelicula = record
		codigo:integer;
		genero:integer;
		puntaje:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:pelicula;
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

	procedure leerPelicula(var P:pelicula);
	begin
		writeln('Ingrese el codigo de la pelicula');
		readln(P.codigo);
		if (P.codigo <> -1) then
		begin
			writeln('Ingrese el genero de la pelicula');
			readln(P.genero);
			writeln('Ingrese el puntaje de la pelicula');
			P.puntaje:= random(101);
		end;
	end;
	
	procedure insertarOrdenado(var L:lista ; P:pelicula);
	var
		nuevo, anterior, actual:lista;
	begin
		new(nuevo);
		nuevo^.dato:= P;
		anterior:= L; actual:= L;
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
	P:pelicula;
begin
	iniciarVectorListas(V);
	leerPelicula(P);
	while (P.codigo <> -1) do
	begin
		insertarOrdenado(V[P.genero], P);
		leerPelicula(P);
	end;
end;

procedure mostrarVectorListas(V:VectorListas);

	procedure mostrarLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('Codigo: ', L^.dato.codigo, '	Puntaje: ', L^.dato.puntaje);
			mostrarLista(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:=1 to dimF do
	begin
		if (V[i] <> nil) then
			writeln('Genero: ', i);
		mostrarLista(V[i]);
		writeln;
	end;
end;

procedure merge(V:VectorListas ; var L:lista);

	procedure minimo(var V:vectorListas ; var min:pelicula);
	var
		i, pos:integer;
	begin
		min.codigo:= 999;
		pos:= -1;
		for i:=1 to dimF do
		begin
			if (V[i] <> nil) then
				if (V[i]^.dato.codigo <= min.codigo) then
				begin
					pos:= i;
					min:= V[i]^.dato;
				end;
		end;
		if (pos <> -1) then
			V[pos]:= V[pos]^.sig
	end;
	
	procedure agregarAtras(var L, ultimo:lista ; P:pelicula);
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
	min:pelicula;
	ultimo:lista;
begin
	L:= nil;
	minimo(V, min);
	while(min.codigo <> 999) do
	begin
		agregarAtras(L, ultimo, min);
		minimo(V, min);
	end;
end;


procedure mostrarLista(L:lista);
begin
	if (L <> nil) then
	begin
		writeln('Codigo: ', L^.dato.codigo, '	Puntaje: ', L^.dato.puntaje);
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
	merge(V, L);
	mostrarLista(L);
END.
