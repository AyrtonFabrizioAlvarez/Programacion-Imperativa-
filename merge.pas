
program merge;
const
	dimF = 12;
	
type
	prestamo = record
		isbn: integer;
		numSocio: integer;
		dia: integer;
		mes: integer;
		cantDiasPrestado: integer;
	end;
	lista = ^nodo;
	nodo = record
		dato: prestamo;
		sig: lista;
	end;
	
	prestamoUnificado = record
		isbn: integer;
		cantTotal: integer;
	end;
	listaUnificada = ^nodo2;
	nodo2 = record
		dato: prestamoUnificado;
		sig: listaUnificada;
	end;
	
	arrListas = array [1..dimF] of lista;
	
	
	
	
procedure generarVectorListas (var arr: arrListas);

	procedure iniciarArray (var arr: arrListas);
	var
		i: integer;
	begin
		for i:=1 to dimF do begin
			arr[i]:= nil;
		end;
	end;
		
	procedure leerPrestamo (var P:prestamo);
	begin
		writeln('Ingrese el numero de ISBN');
		readln(P.isbn);
		if (P.isbn <> -1) then begin
			writeln('Ingrese el numero de socio');
			readln(P.numSocio);
			writeln('Ingrese el dia del prestamo');
			readln(P.dia);
			writeln('Ingrese el mes del prestamo');
			readln(P.mes);
			writeln('Ingrese la cantidad de dias prestado');
			readln(P.cantDiasPrestado);
		end;
	end;
	
	procedure insertarOrdenado (var L:lista ; P: prestamo);
	var
		anterior, actual, nuevo: lista;
	begin
		new (nuevo);
		nuevo^.dato:= P;
		anterior:= L;
		actual:= L;
		while (actual <> nil) and (actual^.dato.isbn < P.isbn) do begin
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
	P: prestamo;
begin
	iniciarArray(arr);
	leerPrestamo(P);
	while (P.isbn <> -1) do begin
		insertarOrdenado(arr[P.mes],P);
		leerPrestamo(P);
	end;
end;


procedure mostrarVectorLista(arr:arrListas);
	procedure mostrarListasRecursiva(l:lista);
	begin
		if (l<>nil) then 
		begin
			writeln(l^.dato.isbn);
			writeln(l^.dato.numSocio);
			mostrarListasRecursiva(l^.sig);
		end;
	end;

var
	i: integer;
begin
	for i:= 1 to dimF do
	begin
		writeln('Mes ',i, ' :'); 
		mostrarListasRecursiva(arr[i]);
	end;
end;


procedure merge (arr: arrListas ; var L: lista);


	procedure agregarAtras (var L: lista ; var ultimo: lista ; P: prestamo);
	var
		nuevo: lista;
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
	
	procedure minimo (var arr: arrListas ; var min: prestamo);
	var
		pos, i: integer;
	begin
		min.isbn:= 999;
		pos:= -1;
		for i:= 1 to dimF do
		begin
			if (arr[i] <> nil) then
				if (arr[i]^.dato.isbn <= min.isbn) then begin
					pos:= i;
					min:= arr[i]^.dato;
				end;
		end;
		
		if (pos <> -1) then
			arr[pos]:= arr[pos]^.sig
	end;

var
	min: prestamo;
	ultimo: lista;
begin
	L:= nil;
	minimo(arr, min);
	while (min.isbn <> 999) do begin
		agregarAtras(L, ultimo, min);
		minimo(arr, min);
	end;
end;


procedure recorrerListaRecursiva (L: lista);
begin
	if (L <> nil) then begin
		writeln(L^.dato.isbn);
		writeln(L^.dato.numSocio);
		recorrerListaRecursiva(L^.sig);
	end;
end;

{Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN,
 donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó durante el año 2021.}
 
 procedure mergeAcumulador (arr: arrListas ; var L: listaUnificada);
 
	procedure agregarAtras2(var L: listaUnificada ; var ultimo: listaUnificada; P: prestamoUnificado);
	var
		nuevo: listaUnificada;
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
	
	procedure minimo (var arr: arrListas ; var min: prestamo);
	var
		pos, i: integer;
	begin
		min.isbn:= 999;
		pos:= -1;
		for i:= 1 to dimF do
		begin
			if (arr[i] <> nil) then
				if (arr[i]^.dato.isbn <= min.isbn) then
				begin
					pos:= i;
					min:= arr[i]^.dato;
				end;
		end;
				
			if (pos <> -1) then
				arr[pos]:= arr[pos]^.sig;
				
	end;
	
 var
	min: prestamo;
	actual: prestamoUnificado;
	ultimo: listaUnificada;
 begin
	L:= nil;
	minimo(arr, min);
	while (min.isbn <> 999) do
	begin
		actual.isbn:= min.isbn;
		actual.cantTotal:= 0;
		while (actual.isbn = min.isbn) do
		begin
			actual.cantTotal:= actual.cantTotal + 1;
			minimo(arr, min);
		end;
		agregarAtras2(L, ultimo, actual)
	end;
 end;
 
 procedure recorrerListaRecursiva2 (L: listaUnificada);
 begin
	if (L <> nil) then
	begin
		writeln(L^.dato.isbn);
		writeln(L^.dato.cantTotal);
		recorrerListaRecursiva2(L^.sig);
	end;
 end;

var
	arr: arrListas;
	L1: lista;
	L2: listaUnificada;
BEGIN
	generarVectorListas(arr);
	mostrarVectorLista(arr);
	merge (arr, L1);
	recorrerListaRecursiva(L1);
	mergeAcumulador (arr, L2);
	recorrerListaRecursiva2(L2);
	
END.

