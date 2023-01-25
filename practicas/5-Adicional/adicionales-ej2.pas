
program ej2;

type
	auto = record
		patente: string;
		ano: integer;
		marca: string;
		modelo: integer;
	end;
	
	lista = ^nodoLista;
	nodoLista = record
		dato: auto;
		sig: lista;
	end;
	
	arrListas = array [2010..2018] of lista;
	
	arbol = ^nodo;
	nodo = record
		dato: auto;
		HI: arbol;
		HD: arbol;
	end;
	
procedure cargarArbol (var A: arbol);

	procedure leerVenta (var au: auto);
	begin
		writeln('Ingrese la patente patente');
		readln(au.patente);
		if (au.patente <> 'ZZZ') then
		begin
			writeln('Ingrese el año de fabricacion');
			readln(au.ano);
			writeln('Ingrese la marca');
			readln(au.marca);
			writeln('Ingrese el modelo del auto');
			readln(au.modelo);
		end;
	end;
	
	procedure crearArbol (var A: arbol ; au: auto);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= au;
			A^.HI:= nil;
			A^.HD:= nil;
		end;
		if (au.patente < A^.dato.patente) then
			crearArbol(A^.HI, au)
		else
			crearArbol(A^.HD, au);
	end;


var
	au: auto;
begin
	leerVenta(au);
	while (au.patente <> 'ZZZ') do
	begin
		crearArbol(A, au);
		leerVenta(au);
	end;

end;

procedure cantPorMarca (A: arbol ; buscado: string ; var cant: integer);
begin
	if (A <> nil) then
		if (A^.dato.marca = buscado) then
			cant:= cant + 1;
		cantPorMarca(A^.HI, buscado, cant);
		cantPorMarca(A^.HD, buscado, cant);
end;

procedure iniciarArray(var arr: arrListas);
var
	i: integer;
begin
	for i:=2010 to 2018 do 
	begin
		arr[i]:= nil
	end;
end;


procedure cargarVectorListas (A: arbol ; var arr: arrListas);

	procedure agregarAtras(var L: lista ; var ultimo: lista ; au: auto);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= au;
		nuevo^.sig:= nil;
		if (L = nil) then
			L:= nuevo
		else
			ultimo^.sig:= nuevo;
		ultimo:= nuevo;
	end;
var
	ultimo: lista;
begin
	if (A <> nil) then
	begin
		agregarAtras(arr[A^.dato.modelo], ultimo, A^.dato);
		cargarVectorListas(A^.HI, arr);
		cargarVectorListas(A^.HD, arr);
	end;
end;

function buscarPatente(A: arbol ; buscada: string ):arbol;
begin
	if (A = nil) then
		buscarPatente:= nil
	else
		if (A^.dato.patente = buscada) then
			buscarPatente:= A
		else
			if (buscada < A^.dato.patente) then
				buscarPatente:= buscarPatente(A^.HI, buscada)
			else
				buscarPatente:= buscarPatente(A^.HD, buscada)
end;



var
	A: arbol;
	arr: arrListas;
	marcaBuscada: string;
	cant: integer;
	patenteBuscada: string;
BEGIN
	cargarArbol(A);
	
	cant:= 0;
	writeln('Ingrese la marca de la que desea saber la cantidad de autos que tiene la agencia');
	readln(marcaBuscada);
	cantPorMarca(A, marcaBuscada, cant);
	writeln('La cantidad de autos de la marca ', marcaBuscada, ' es de: ', cant);
	
	iniciarArray(arr);
	cargarVectorListas(A, arr);
	
	
	writeln('Ingrese la patente del auto del cual desea saber el modelo');
	readln(patenteBuscada);
	if( buscarPatente(A, patenteBuscada) <> nil) then
		writeln('El modelo del auto con patente: ', patenteBuscada, ' es: ', buscarPatente(A, patenteBuscada)^.dato.modelo)
	else
		writeln('La patente no se encuentra en el arbol binario');

	
END.

