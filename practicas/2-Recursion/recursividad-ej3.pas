
program ej3;


{3.- Escribir un programa que:
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. 


a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100.
 Finalizar con el número 0.}
 


type
	lista = ^nodo;
	nodo = record
		dato: integer;
		sig: lista;
	end;


procedure cargarListaRecursiva (var L: lista);

	procedure agregarAdelante (var L: lista ; valor: integer);
	var
		nuevo: lista;
	begin
		new(nuevo);
		nuevo^.dato:= valor;
		nuevo^.sig:= L;
		L:= nuevo;
	end;

var
	num: integer;	
begin
	writeln('Ingrese un numero');
	readln(num);
	if (num <> 0) then begin
		cargarListaRecursiva(L);
		agregarAdelante(L, num);
	end;
end;

procedure imprimirLista (L: lista);
begin
	if (L <> nil) then begin
		writeln(L^.dato);
		L:= L^.sig;
		imprimirLista(L);
	end;
end;

Procedure actualizarMaxMin (L: lista ; var min, max: integer);
begin
	if (L <> nil) then begin
		if (min > L^.dato) then
			min:= L^.dato;
		if (max < L^.dato) then
			max:= L^.dato;
		L:= L^.sig;
		actualizarMaxMin(L, min, max)
		
	end;
end;

procedure encontrar (L: lista ; valor: integer ; var esta: boolean);
begin
	if (L <> nil) and (not esta) then begin
		if (L^.dato <> valor) then begin
			L:= L^.sig;
			encontrar(L, valor, esta);
		end
		else
			esta:=true;
	end;
end;





var 
	L: lista;
	min, max: integer;
	ok: boolean;
	buscado: integer;
BEGIN
	min:= 102;
	max:= 0;
	ok:= false;
	cargarListaRecursiva(L);
	imprimirLista(L);
	actualizarMaxMin(L, min, max);
	writeln('el menor es ', min);
	writeln('el mayor es ', max);
	
	writeln('Que numero desea saber si se encuentra en la lista');
	readln(buscado);
	encontrar(L, buscado, ok);
	if (ok) then
		writeln('El valor se encuentra en la lista')
	else
		writeln('El valor no se encuentra en la lista');
END.

