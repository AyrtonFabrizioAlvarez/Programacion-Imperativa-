program ej3;

type

	alumno = record
		legajo:integer;
		dni:integer;
		ingreso:integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:alumno;
		HI: arbol;
		HD: arbol;
	end;
	
procedure cargarArbol(var A:arbol);

	procedure leerAlumno(var Al:alumno);
	begin
		writeln('Ingrese el año de Ingreso');
		readln(Al.ingreso);
		if (Al.ingreso > 2010) then
		begin
			writeln('Ingrese el numero de dni');
			Al.dni:= random(10000);
			writeln('Ingrese el legajo');
			Al.legajo:= random(101);
		end;
	end;
	
	procedure crear(var A:arbol ; alu:alumno);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= alu;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (alu.legajo < A^.dato.legajo) then
				crear(A^.HI, alu)
			else
				crear(A^.HD, alu)
	end;

var
	alu:alumno;
begin
	leerAlumno(alu);
	while (alu.ingreso > 2010) do
	begin
		crear(A, alu);
		leerAlumno(alu);
	end;
end;


procedure mostrarArbol (A:arbol);
begin
	if (A <> nil) then
	begin
		writeln('Legajo: ', A^.dato.legajo, ' Dni: ', A^.dato.dni, ' Ingreso: ', A^.dato.ingreso);
		mostrarArbol(A^.HI);
		mostrarArbol(A^.HD);
	end;
end;

procedure menorIngreso(A:arbol);

	procedure buscar(A:arbol ; x:integer);
	begin
		if (A <> nil) then
			if (A^.dato.legajo < x) then
			begin
				writeln('Legajo: ', A^.dato.legajo, ' Dni: ', A^.dato.dni, ' Ingreso: ', A^.dato.ingreso);
				buscar(A^.HI, x);
				buscar(A^.HD, x);
			end
			else
				buscar(A^.HI, X)
				
	end;

var
	x:integer;
begin
	writeln('Ingrese el numero del legajo a filtrar para encontrar los menores');
	readln(x);
	buscar(A, x);
end;

procedure entreLegajos(A: arbol);

	procedure buscar(A:arbol ; sup, inf:integer);
	begin
		if (A <> nil) then
			if (A^.dato.legajo > inf) and (A^.dato.legajo < sup) then
			begin
				writeln('Legajo: ', A^.dato.legajo, ' Dni: ', A^.dato.dni, ' Ingreso: ', A^.dato.ingreso);
				buscar(A^.HI, sup, inf);
				buscar(A^.HD, sup, inf);
			end
			else
				if (A^.dato.legajo > inf) then
					buscar(A^.HI, sup, inf)
				else
					buscar(A^.HD, sup, inf)
	end;

var
	sup, inf:integer;
begin
	writeln('Ingrese el numero superior');
	readln(sup);
	writeln('Ingrese el numero inferior');
	readln(inf);
	buscar(A, sup, inf);
end;

procedure mayorDni(A:arbol);

	procedure maximo(A:arbol ; var max:integer);
	begin
		if (A <> nil) then
		begin
			if (A^.dato.dni > max) then
				max:= A^.dato.dni;
			maximo(A^.HI, max);
			maximo(A^.HD, max);
		end;				
	end;

var
	max:integer;
begin
	max:= -1;
	maximo(A, max);
	writeln('El dni mas grande es: ', max);
end;



var
	A:arbol;
BEGIN
	Randomize;
	A:= nil;
	cargarArbol(A);
	mostrarArbol(A);
	//menorIngreso(A);
	//entreLegajos(A);
	mayorDni(A);
END.

