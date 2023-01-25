{
Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de datos sólo a aquellos alumnos que posean año de ingreso posterior al 2010. De cada alumno se lee legajo, DNI y año de ingreso. La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro. 
c. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
   
}
program ej3;
const
	ingreso = 2010;


{a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de datos sólo
 a aquellos alumnos que posean año de ingreso posterior al 2010. De cada alumno se lee legajo, DNI y año de ingreso. 
 La estructura generada debe ser eficiente para la búsqueda por número de legajo. }

type

	alumno = record
		legajo: integer;
		dni: integer;
		anoIngreso: integer;
	end;
	arbol = ^nodoArbol;
	nodoArbol = record
		dato: alumno;
		HI: arbol;
		HD: arbol;
	end;
	
procedure generarArbol(var a: arbol);

	procedure leerAlumno (var A: alumno);
	begin
		writeln('Ingrese el numero de legajo del alumno');
		readln(A.legajo);
		if (A.legajo <> -1) then begin
			writeln('Ingrese el dni del alumno');
			readln(A.dni);
			writeln('Ingrese el año de ingreso del alumno');
			readln(A.anoIngreso);
		end;
	end;
	
	procedure insertarNodoArbol(var a:arbol ; alu: alumno);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:= alu;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else begin
			if (alu.legajo < a^.dato.legajo) then
				insertarNodoArbol(a^.HI, alu)
			else
				insertarNodoArbol(a^.HD, alu)
		end;
	end;
				

var
	alu: alumno;
begin
	leerAlumno(alu);
	while (alu.legajo <> -1) do begin
		if (alu.anoIngreso > ingreso) then begin
			insertarNodoArbol(a, alu);
		end;
		leerAlumno(alu);
	end;
end;

{b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo
 sea inferior a un valor ingresado como parámetro.}
 
 
procedure informarIngresoPorLejagoInferior(a: arbol);

	procedure debajoDeLegajo(A: arbol; leg: integer);
	begin
		if(A <> nil) then begin
			if(A^.dato.legajo < leg) then begin
				writeln('El alumno cumple condicion ', '(legajo ', a^.dato.legajo, ')', '	dni: ', a^.dato.dni, ' y su año de ingreso fue: ', a^.dato.anoIngreso);
				debajoDeLegajo(A^.HI, leg);
				debajoDeLegajo(A^.HD, leg);
			end
		else 
			debajoDeLegajo(A^.HI, leg);
	end;
	end;


var
	num: integer;
begin
	writeln('Ingrese el valor para retornar los datos de alumnos con legajo inferior');
	readln(num);
	debajoDeLegajo(a, num);
	
end;
 
 
{c. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo
 esté comprendido entre dos valores que se reciben como parámetro.}
procedure informarLegajoEntreValores (a: arbol );

	procedure entreValores (a: arbol ; inf, sup:integer);
	begin
		if (a <> nil) then begin
			if (a^.dato.legajo >= inf ) and (a^.dato.legajo <= sup) then begin
				writeln('El alumno cumple con la condicion ', '(legajo ',a^.dato.legajo,')', ' dni: ', a^.dato.dni, ' año de ingreso: ', a^.dato.anoIngreso);
				entreValores(a^.HI, inf, sup);
				entreValores(a^.HD, inf, sup);
			end
			else
				if (a^.dato.legajo > inf) then
					entreValores(a^.HI, inf, sup)
				else
					if (a^.dato.legajo < sup) then
						entreValores(a^.HD, inf, sup)
		end;
	end;

var
	num1, num2: integer;
begin
	writeln('Ingrese el valor minimo a buscar');
	readln(num1);
	writeln('Ingrese el valor maximo a buscar');
	readln(num2);
	entreValores(a, num1, num2);
end;


{d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.}

procedure informarMaxDni (a: arbol);

	procedure maximo (a:arbol ; var max: integer);
	begin
		if (a <> nil) then
			if (a^.dato.dni > max) then begin
				max:= a^.dato.dni;
			end;	
			maximo(a^.HI, max);
			maximo(a^.HD, max);
	end;

var
	max: integer;
begin
	max:= -1;
	maximo(a, max);
	writeln('El dni maximo es: ', max);
end;

{e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.}

procedure informarCantAlumnosDniImpar (a: arbol);

	function contarDniImpar (a: arbol): integer;
	begin
		if (a = nil) then
			contarDniImpar:= 0
		else
			if (a^.dato.dni mod 2 = 1) then
				contarDniImpar:= contarDniImpar(a^.HI) + contarDniImpar(a^.HD) + 1
			else begin
				contarDniImpar:=contarDniImpar(a^.HI);
				contarDniImpar:=contarDniImpar(a^.HD);				
			end;
	end;
begin
	writeln('La cantidad de alumnos con dni impar es: ', contarDniImpar(a));
end;

var
	a: arbol;
BEGIN
	generarArbol(a);
	informarIngresoPorLejagoInferior(a);
	informarLegajoEntreValores(a);
	informarMaxDni(a);
	informarCantAlumnosDniImpar(a);	
END.

