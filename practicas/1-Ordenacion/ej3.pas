program ej3;

const

	dimF = 8;
	
type

	pelicula = record
		codigo: integer;
		genero: integer;
		puntaje: integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: pelicula;
		sig: lista;
	end;
	
	vectorPeliculas = array [1..dimF] of lista;
	vectorMejores = array [1..dimF] of pelicula;
	

procedure cargarVector (var V:vectorPeliculas);

	procedure iniciarVector (var V:vectorPeliculas);
	var
		i:integer;
	begin
		for i:=1 to dimF do
			V[i]:=nil;
	end;
	
	procedure leerPelicula(var P:pelicula);
	begin
		Randomize;
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
	
	procedure agregarAtras (var L, ultimo:lista ; P:pelicula);
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
	P:pelicula;
	vectorUltimos:vectorPeliculas;
begin
	iniciarVector(V);
	iniciarVector(vectorUltimos);
	leerPelicula(P);
	while (P.codigo <> -1) do
	begin
		agregarAtras(V[P.genero], vectorUltimos[P.genero], P);
		leerPelicula(P)
	end;
end;

procedure mostrarVectorListas (V: vectorPeliculas);

	procedure recorrerLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('codigo: ', L^.dato.codigo, ' puntaje: ', L^.dato.puntaje);
			recorrerLista(L^.sig);
		end;	
	end;
	
var
	i:integer;
begin
	for i:=1 to dimF do
	begin
		writeln('GENERO ', V[i]^.dato.genero);
		recorrerLista(V[i])
	end;
end;

procedure buscarMejoresPelis (vectorOriginal:vectorPeliculas ; var vectorNuevo:vectorMejores);

	procedure recorrerLista2 (L:lista ; var max:integer ; var maxPeli:pelicula);
	begin
		if (L <> nil) then
		begin
			if (L^.dato.puntaje > max) then
			begin
				max:= L^.dato.puntaje;
				maxPeli:= L^.dato;
			end;
			recorrerLista2(L^.sig, max, maxPeli);
		end;
	end;

var
	max, i:integer;
	maxPeli:pelicula;
begin
	for i:=1 to dimF do
	begin
		max:= -1;
		recorrerLista2(vectorOriginal[i], max, maxPeli);
		vectorNuevo[i]:= maxPeli;
	end;
end;

procedure mostrarMejoresPelis(V:vectorMejores);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln('Genero: ', V[i].genero, ' codigo: ', V[i].codigo, ' puntaje: ', V[i].puntaje);
end;

procedure ordenSeleccion(var V:vectorMejores);
var
	i, j, pos:integer;
	item:pelicula;
begin
	for i:=1 to dimF-1 do
	begin
		pos:= i;
		for j:=i+1 to dimF do
		begin
			if (V[j].puntaje < V[pos].puntaje) then
				pos:= j;
		end;
		item:= V[pos];
		V[pos]:= V[i];
		V[i]:= item;
	end;
end;
	
	
var
	V:vectorPeliculas;
	V2:vectorMejores;
BEGIN
	Random;
	cargarVector(V);
	//mostrarVectorListas(V);
	buscarMejoresPelis(V, V2);
	mostrarMejoresPelis(V2);
	ordenSeleccion(V2);
	writeln('');
	mostrarMejoresPelis(V2);
	writeln('Codigo de pelicula con mayor puntaje ', V2[8].codigo);
	writeln('Codigo de pelicula con menor puntaje ', V2[1].codigo);
END.
