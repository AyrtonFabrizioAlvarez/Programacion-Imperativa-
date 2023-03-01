program ej2;


type
	auto = record
		patente:string;
		anoFabricacion:integer;
		marca:string;
		modelo:integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:auto;
		HI:arbol;
		HD:arbol;
	end;
	
	lista = ^nodolista;
	nodolista = record
		dato:auto;
		sig:lista;
	end;
	
	vector = array [2010..2018] of lista;
	
procedure generarArbol(var A:arbol);

	procedure leerAuto(var A:auto);
	begin
		writeln('Ingrese la patente');
		readln(A.patente);
		if (A.patente <> 'zzz') then
		begin
			//writeln('Ingrese el año de fabricacion');
			A.anoFabricacion:= random(9)+2010;
			writeln('Ingrese la marca del auto');
			readln(A.marca);
			//writeln('Ingrese el modelo del auto');
			A.modelo:= random(10);
		end;
	end;
	
	procedure crear(var A:arbol ; aut:auto);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= aut;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (aut.patente < A^.dato.patente) then
				crear(A^.HI, aut)
			else
				crear(A^.HD, aut)
	end;


var
	aut:auto;
begin
	leerAuto(aut);
	while (aut.patente <> 'zzz') do
	begin
		crear(A, aut);
		leerAuto(aut);
	end;
end;

procedure buscarMarca(A:arbol);

	function buscar(A:arbol ; x:string):integer;
	begin
		if (A = nil) then
			buscar:= 0
		else
			if (A^.dato.marca = x) then
				buscar:= buscar(A^.HI, x) + buscar(A^.HD, x) + 1
			else
				buscar:= buscar(A^.HI, x) + buscar(A^.HD, x)
	end;

var
	x:string;
	res:integer;
begin
	writeln('Ingrse la marca que desea saber la cantidad de autos');
	readln(x);
	res:= buscar(A, x);
	if (res <> 0) then
		writeln('Hay ', res, ' autos de la marca ', x)
	else
		writeln('No hay autos de la marca ', x);
end;

procedure iniciarVectorListas(var V:vector);
var
	i:integer;
begin
	for i:= 2010 to 2018 do
		V[i]:= nil
end;

procedure cargarVectorListas(A:arbol ; var V:vector);

	procedure agregarAdelante(var L:lista ; x:auto);
	var
		nuevo:lista;
	begin
		new(nuevo);
		nuevo^.dato:= x;
		nuevo^.sig:= L;
		L:= nuevo;
	end;

begin
	if (A <> nil) then
	begin
		agregarAdelante(V[A^.dato.anoFabricacion], A^.dato);
		cargarVectorListas(A^.HI, V);
		cargarVectorListas(A^.HD, V);
	end;
end;

procedure mostrarVectorListas(V:vector);

	procedure mostrarLista(L:lista);
	begin
		if (L <> nil) then
		begin
			writeln('	Patente: ', L^.dato.patente, ' ano: ', L^.dato.anoFabricacion);
			writeln;
			mostrarLista(L^.sig);
		end;
	end;

var
	i:integer;
begin
	for i:= 2010 to 2018 do
	begin
		writeln('Ano: ', i);
		mostrarLista(V[i]);
	end;
end;

procedure buscarPatente(A:arbol);

	function buscar(A:arbol ; x:string):integer;
	begin
		if (A = nil) then
			buscar:= -1
		else
			if (A^.dato.patente = x) then
				buscar:= A^.dato.anoFabricacion
			else
				if (x < A^.dato.patente) then
					buscar:= buscar(A^.HI, x)
				else
					buscar:= buscar(A^.HD, x)
	end;

var
	x:string;
	res:integer;
begin
	writeln('Ingrese la patente qeu desea buscar');
	readln(x);
	res:= buscar(A, x);
	if (res <> -1) then
		writeln('El ano de fabricacion del auto con patente ', x, ' es: ', res)
	else
		writeln('El auto con patente ', x, ' no se encuentra')
end;

VAR
	A:arbol;
	V:vector;
BEGIN
	generarArbol(A);
	buscarMarca(A);
	iniciarVectorListas(V);
	cargarVectorListas(A, V);
	mostrarVectorListas(V);
	buscarPatente(A);
END.
