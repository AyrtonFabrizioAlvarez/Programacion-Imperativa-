
program parcialImperativoPrueba2;

type
	infectado = record
		dni: integer;
		nombre: string;
		sintoma: integer;
		codCiudad: integer;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: infectado;
		HI: arbol;
		HD: arbol;
	end;
	
	lista = ^nodoLista;
	nodoLista = record
		dato: infectado;
		sig: lista;
	end;
	
	
procedure generarArbol(var A: arbol);

	procedure leerinfectado(var I: infectado);
	begin
		writeln('Ingrese el DNI de la persona infectada');
		readln(I.dni);
		if (I.dni <> 0) then
		begin
			writeln('Ingrese el nombre de la persona infectada');
			readln(I.nombre);
			writeln('Ingrese su sintoma');
			readln(I.sintoma);
			writeln('Ingrese el codigo de ciudad a la que pertenece');
			readln(I.codCiudad);
		end;
	end;
	procedure crear(var A: arbol ; I: infectado);
	begin
		if(A = nil) then
		begin
			new(A);
			A^.dato:= I;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if(I.dni < A^.dato.dni) then
				crear(A^.HI, I)
			else
				crear(A^.HD, I)
	end;
var
	I: infectado;
begin
	leerInfectado(I);
	while (I.dni <> 0) do
	begin
		crear(A, I);
		leerInfectado(I);
	end;
end;

procedure minimo(A: arbol ; var min: infectado);
begin
	if (A = nil) then
		min.dni:= -1
	else
		if (A^.HI <> nil) then
			minimo(A^.HI, min)
		else
			min:= A^.dato;
end;

procedure generarLista (A: arbol ; var L: lista);

	procedure agregarAdelante(var L: lista ; I: infectado);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= I;
		nuevo^.sig:= L;
		L:= nuevo;
	end;	

	procedure filtrarArbol(A: arbol ; var L: lista ; buscado: integer);
	begin
		if (A <> nil) then
			if (A^.dato.codCiudad = buscado) then
				agregarAdelante(L, A^.dato)
			else
			begin
				filtrarArbol(A^.HI, L, buscado);
				filtrarArbol(A^.HD, L, buscado);
			end;
	end;
var
	codBuscado: integer;
begin
	L:= nil;
	writeln('Ingrese el codigo de ciudad del que desea generar la lista');
	readln(codBuscado);
	filtrarArbol(A, L, codBuscado);
end;

procedure mostrarListaRecursiva(L: lista);
begin
	if (L <> nil) then
	begin
		writeln('dni: ', L^.dato.dni);
		writeln('nombre: ', L^.dato.nombre);
		writeln('sintoma: ', L^.dato.sintoma);
		mostrarListaRecursiva(L^.sig)		
	end;
end;

var
	A: arbol;
	min: infectado;
	L: lista;
BEGIN
	writeln('antes de generar arbol');
	generarArbol(A);
	writeln('despues de generar arbol y antes del minimo');
	minimo(A, min);
	writeln('sali del minimo');
	writeln('El infectado con mayor edad tiene dni ',min.dni,' nombre: ',min.nombre,'con sintomatologia ',min.sintoma,' codigo de ciudad: ',min.codCiudad);
	generarLista(A, L);
	writeln('Datos de lista generada segun codigo de ciudad ingresado', '(',L^.dato.codCiudad,')');
	mostrarListaRecursiva(L);
END.

