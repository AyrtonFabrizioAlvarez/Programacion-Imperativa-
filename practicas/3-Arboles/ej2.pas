program ej2;

type
	venta = record
		codigo:integer;
		fecha:integer;
		unidades:integer;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:venta;
		HI:arbol;
		HD:arbol;
	end;
	
procedure cargarArboles(var A1:arbol ; var A2:arbol);

	procedure leerVenta(var V:venta);
	begin
		writeln('Ingrese el codigo de producto');
		readln(V.codigo);
		if (V.codigo <> 0) then
		begin
			writeln('Ingrese la fecha de venta');
			readln(V.fecha);
			writeln('Ingrese la cantidad de unidades');
			V.unidades:= random(11);
		end;
	end;
	
	procedure crear1(var A:arbol ; V:venta);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= V;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (V.codigo < A^.dato.codigo) then
				crear1(A^.HI, V)
			else
				crear1(A^.HD, V)
	end;
	
	procedure crear2(var A:arbol ; V:venta);
	begin
		if (A = nil) then
		begin
			new(A);
			A^.dato:= V;
			A^.HI:= nil;
			A^.HD:= nil;
		end
		else
			if (V.codigo = A^.dato.codigo) then
				A^.dato.unidades:= A^.dato.unidades + V.unidades
			else
				if (V.codigo < A^.dato.codigo) then
					crear2(A^.HI, V)
				else
					crear2(A^.HD, V)
	end;
	
var
	V:venta;
begin
	leerVenta(V);
	while (V.codigo <> 0) do
	begin
		crear1(A1, V);
		crear2(A2, V);
		leerVenta(V);
	end;
end;

procedure mostrarArbol(A:arbol);
begin
	if (A <> nil) then
	begin
		writeln('Codigo: ', A^.dato.codigo, ' Fecha: ', A^.dato.fecha, ' Unidades: ', A^.dato.unidades);
		mostrarArbol(A^.HI);
		mostrarArbol(A^.HD);
	end;
end;

procedure informarTotalA1 (A:arbol);

	function contar(A:arbol ; x:integer):integer;
	begin
		if (A = nil) then
			contar:= 0
		else
			if (A^.dato.codigo = x) then
			begin
				if (x < A^.dato.codigo) then
					contar:= contar(A^.HI, x) + A^.dato.unidades
				else
					contar:= contar(A^.HD, x) + A^.dato.unidades
			end
			else
				if (x < A^.dato.codigo) then
					contar:= contar(A^.HI, x)
				else
					contar:= contar(A^.HD, x)
	end;
var
	x, aux:integer;
begin
	writeln('Ingrese el codigo de producto del que desea saber el total de ventas');
	readln(x);
	aux:= contar(A, x);
	if (aux > 0) then
		writeln('La cantidad de unidades vendidas para el producto con codigo ', x, ' es: ', aux)
	else
		writeln('No se registraron ventas del producto con codigo ', x);
	
end;

procedure informarTotalA2(A:arbol);

	function contar(A:arbol ; x:integer):integer;
	begin
		if (A = nil) then
			contar:= 0
		else
			if (x = A^.dato.codigo) then
				contar:= A^.dato.unidades
			else
				if (x < A^.dato.codigo) then
					contar:= contar(A^.HI, x)
				else
					contar:= contar(A^.HD, x)
	end;

var
	x, aux:integer;
begin
	writeln('Ingrese el codigo de producto del que desea saber el total de ventas');
	readln(x);
	aux:= contar(A, x);
	if (aux > 0) then
		writeln('La cantidad de unidades vendidas para el producto con codigo ', x, ' es: ', aux)
	else
		writeln('No se registraron ventas del producto con codigo ', x);
end;

var
	A1, A2:arbol;
BEGIN
	Randomize;
	A1:= nil;
	A2:= nil;
	cargarArboles(A1, A2);
	mostrarArbol(A1);
	writeln;
	mostrarArbol(A2);
	writeln;
	informarTotalA1(A1);
	informarTotalA2(A2);
END.

