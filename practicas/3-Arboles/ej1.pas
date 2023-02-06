program ej1;

type
	
	socio = record
		numero:integer;
		nombre:string;
		edad:integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:socio;
		HI:arbol;
		HD:arbol;
	end;
	
procedure cargarArbol(var A:arbol);

	procedure leerSocio (var S:socio);
	begin
		writeln('Ingrese el numero de socio');
		readln(S.numero);
		if (S.numero <> 0) then
		begin
			//writeln('Ingrese el nombre del Socio');
			//readln(S.nombre);
			//writeln('Ingrese la edad del socio');
			S.edad:= random(101);
		end;
	end;
	
	procedure crear (var A:arbol ; S:socio);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= S;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (S.numero < A^.dato.numero) then
				crear(A^.HI, S)
			else
				crear(A^.HD, S)
	end;

var
	S:socio;
begin
	leerSocio(S);
	while (S.numero <> 0) do
	begin
		crear(A, S);
		leerSocio(S);		
	end;	
end;

procedure mostrarArbol (A: arbol);
begin
	if (A <> nil) then
	begin
		writeln('Numero: ', A^.dato.numero);
		mostrarArbol(A^.HI);
		mostrarArbol(A^.HD);
	end;
end;

procedure informarMaxMinNum(A:arbol);

	function socioMasGrande(A:arbol):integer;
	begin
		if (A = nil) then
			socioMasGrande:= -1
		else
			if (A^.HD = nil) then
				socioMasGrande:= A^.dato.numero
			else
				sociomasGrande:= socioMasGrande(A^.HD)
	end;
	
	function socioMasChico(A:arbol):integer;
	begin
		if (A = nil) then
			socioMasChico:= -1
		else
			if (A^.HI = nil) then
				socioMasChico:= A^.dato.numero
			else
				socioMasChico:= socioMasChico(A^.HI)
	end;

var
	auxMin, auxMax:integer;
begin
	auxMax:= socioMasGrande(A);
	if (auxMax = -1) then
		writeln('El Arbol esta vacio')
	else
	begin
		auxMin:= socioMasChico(A);
		writeln('El numero de socio mas chico es: ', auxMin);
		writeln('El numero de socio mas grande es: ', auxMax);
	end;
end;


procedure informarMayorEdad(A:arbol);

	procedure maximo (edad, num:integer ; var maxEdad, maxNum:integer);
	begin
		if (edad > maxEdad) then
		begin
			maxEdad:= edad;
			maxNum:= num;
		end;
	end;
	
	procedure mayorEdad(A:arbol ; var maxEdad, maxNum:integer);
	begin
		if (A <> nil) then
		begin
			maximo(A^.dato.edad, A^.dato.numero, maxEdad, maxNum);
			mayorEdad(A^.HI, maxEdad, maxNum);
			mayorEdad(A^.HD, maxEdad, maxNum);
		end;
	end;
	
var
	maxNum, maxEdad:integer;
begin
	maxEdad:= -1;
	mayorEdad(A, maxEdad, maxNum);
	if (maxEdad = -1) then
		writeln('El Arbol esta vacio')
	else
		writeln('El numero de socio con mayor edad es el: ', maxNum, ' con: ', maxEdad, ' anos')
end;

procedure incrementarEdad(A:arbol);
begin
	if (A <> nil) then
	begin
		A^.dato.edad:= A^.dato.edad + 1;
		incrementarEdad(A^.HI);
		incrementarEdad(A^.HD);
	end;
end;

procedure buscarSocio(A:arbol);

	function buscar(A:arbol ; x:integer):boolean;
	begin
		if (A = nil) then
			buscar:= false
		else
			if (x = A^.dato.numero) then
				buscar:= true
			else
				if (x < A^.dato.numero) then
					buscar:= buscar(A^.HI, x)
				else
					buscar:= buscar(A^.HD, x)
	end;
	
	procedure buscar2(A:arbol ; x:string ; var ok:boolean);
	begin
		if (A <> nil) and (not ok) then
		begin
			if (x = A^.dato.nombre) then
				ok:= true
			else
				buscar2(A^.HI, x, ok);
				buscar2(A^.HD, x, ok);
		end;
	end;


var
	x:integer;
	y:string;
	existe:boolean;
begin
	writeln('Ingrese el numero de socio que desea buscar');
	readln(x);
	if (buscar (A, x)) then
		writeln('El numero ', x, ' se encuentra en el arbol')
	else
		writeln('El numero ', x, ' no se encuentra en el arbol');
		
	writeln('Ingrese el nombre de socio que desea buscar');
	readln(y);
	existe:= false;
	buscar2(A, y, existe);
	if (existe) then
		writeln('El socio con nombre ', y, ' existe')
	else
		writeln('El socio con nombre ', y, ' no existe')
end;

function cantidadSocios(A:arbol):integer;
begin
	if (A = nil) then
		cantidadSocios := 0
	else
		cantidadSocios := cantidadSocios(A^.HI) + cantidadSocios(A^.HD) + 1
end;

procedure promedioEdades(A:arbol);

	function totalEdades(A:arbol):integer;
	begin
		if (A = nil) then
			totalEdades:= 0
		else
			totalEdades:= totalEdades(A^.HI) + totalEdades(A^.HD) + A^.dato.edad
	end;
	
	function promedio (x, y:integer):real;
	begin
		promedio:= x/y;
	end;

begin
	writeln('El promedio de edad es: ', promedio(totalEdades(A), cantidadSocios(A)):2:2);
end;

procedure cantidadEntreValores(A:arbol);

	function contar(A:arbol ; inferior, superior:integer):integer;
	begin
		if (A = nil) then
			contar:= 0
		else
			if (A^.dato.numero >= inferior) and (A^.dato.numero <= superior) then
				contar:= contar(A^.HI, inferior, superior) + contar(A^.HD, inferior, superior) + 1
			else
				if (A^.dato.numero > inferior) then
					contar:= contar(A^.HI, inferior, superior)
				else
					if (A^.dato.numero < superior) then
						contar:= contar(A^.HD, inferior, superior)
	end;

var
	inferior, superior:integer;
begin
	writeln('Ingrese el numero mas chico');
	readln(inferior);
	writeln('Ingrese el numero mas grande');
	readln(superior);
	writeln('La cantidad de socios en rango es: ', contar(A, inferior, superior));
end;


procedure mostrarArbolCreciente (A: arbol);
begin
	if (A <> nil) then
	begin
		mostrarArbol(A^.HI);
		writeln('Numero: ', A^.dato.numero);
		mostrarArbol(A^.HD);
	end;
end;

procedure mostrarArbolParesDecreciente (A: arbol);
begin
	if (A <> nil) then
	begin
		mostrarArbol(A^.HI);
		mostrarArbol(A^.HD);
		if (A^.dato.numero MOD 2 = 0) then
			writeln(A^.dato.numero MOD 2 = 0);
			writeln('Numero: ', A^.dato.numero);
	end;
end;

var
	A:arbol;
BEGIN
	Randomize;
	A:= nil;
	cargarArbol(A);
	//mostrarArbol(A);
	//writeln;
	//informarMaxMinNum(A);
	//writeln;
	//informarMayorEdad(A);
	//writeln;
	//incrementarEdad(A);
	writeln;
	//mostrarArbol(A);
	//buscarSocio(A);
	//writeln;
	//writeln('La cantidad de socios es: ', cantidadSocios(A));
	//writeln;
	//promedioEdades(A);
	//cantidadEntreValores(A);
	mostrarArbolCreciente(A);
	writeln;
	mostrarArbolParesDecreciente(A);
END.

