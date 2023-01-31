program ej3;
type
	lista = ^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;
	
procedure generarNumero(var x:integer);
begin
	x:= random(100);
end;

procedure cargarLista (var L:lista);
var
	nuevo:lista;
    x:integer;
begin
	generarNumero(x);
	if (x <> 0) then
	begin
        cargarLista(L);
		new(nuevo);
		nuevo^.dato:= x;
		nuevo^.sig:= L;
        L:= nuevo;
	end;	
end;

procedure maxMin(L:lista ; var max, min:integer);
begin
    if (L <> nil) then
    begin
        if (L^.dato > max) then
            max:= L^.dato
        else
            if (L^.dato < min) then
                min:= L^.dato;
        maxMin(L^.sig, max, min);
    end;
end;

procedure imprimirLista (L:lista);
begin
    if (L <> nil) then begin
        writeln(L^.dato);
        imprimirLista(L^.sig);
    end;
end;


function buscar(L:lista;x:integer):boolean;
begin
    if(L<>nil)then
        if(L^.dato=x)then
            buscar:=true
        else    
            buscar:=buscar(L^.sig,x)
    else
        buscar:=false;
end;



var
    L:lista;
    max, min:integer;
    x:integer;
BEGIN
    L:= nil;
	Randomize;
    max:= -1;
    min:= 999;
    cargarLista(L);
    imprimirLista(L);
    maxMin(L, max, min);
    writeln('El maximo es ', max);
    writeln('El minimo es ', min);
    writeln('Ingrese el numero que desea buscar');
    readln(x);
    writeln(buscar(L, x));
END.
