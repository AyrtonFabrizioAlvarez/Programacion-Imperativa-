program ej1;

const
	
	dimF = 10;
	
type
	
	vector = array [1..dimF] of char;
	
	lista = ^nodo;
	nodo = record
		dato:char;
		sig:lista;
	end;


procedure cargarVectorRecursivo (var V:vector ; var dimL:integer);
var
	x:char;
begin
	writeln('Ingrese un caracter');
	readln(x);
	if (dimL < dimF) and (x <> '.') then
	begin
		dimL:= dimL + 1;
		V[dimL]:= x;
		cargarVectorRecursivo(V, dimL);
	end;
end;

procedure imprimirVector (V:vector ; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln(i, ': ', V[i])
end;

procedure imprimirVectorRecursivo (V:vector ; dimL:integer);
begin
	if (dimL > 1) then
		imprimirVectorRecursivo(V, dimL-1);
		writeln(dimL, ': ', V[dimL]);
end;

function contarCaracteres ():integer;
var
	x:char;
begin
	writeln('Ingrese un caracter');
	readln(x);
	if (x <> '.') then
		contarCaracteres:= contarCaracteres() + 1
	else
		contarCaracteres:= 0;
end;

procedure cargarListaRecursiva(var L:lista);
var
	x:char;
begin
	writeln('Ingrese un caracter');
	readln(x);
	if (x <> '.') then
	begin
		new(L);
		L^.dato:= x;
		cargarListaRecursiva(L^.sig);
	end
	else
		L:= nil;
end;

procedure imprimirListaOrden(L:lista);
begin
	if (L <> nil) then
	begin
		writeln(L^.dato);
		imprimirListaOrden(L^.sig);
	end;
end;

procedure imprimirListaDesorden(L:lista);
begin
	if (L <> nil) then
	begin
		imprimirListaDesorden(L^.sig);
		writeln(L^.dato);
	end;
end;



var
	V:vector;
	dimL:integer;
	L:lista;
BEGIN
	dimL:= 0;
	L:= nil;
	cargarVectorRecursivo(V, dimL);
	imprimirVector(V, dimL);
	writeln(' ');
	imprimirVectorRecursivo(V, dimL);
	writeln(contarCaracteres());
	cargarListaRecursiva(L);
	imprimirListaOrden(L);
	writeln(' ');
	imprimirListaDesorden(L);
END.

