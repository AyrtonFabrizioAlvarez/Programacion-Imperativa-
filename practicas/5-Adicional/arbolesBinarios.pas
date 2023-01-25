program arbolesBinarios;


Type
	arbol = ^nodo;

	nodo = record
		dato: integer;
		HI: arbol;
		HD: arbol;
	end;
	
	
	
Procedure crear (var A:árbol; num:integer);
Begin
	if (A = nil) then
	begin
      new(A);
      A^.dato:= num; 
      A^.HI:= nil; 
      A^.HD:= nil;
	end
	else if (num < A^.dato) then
			crear(A^HI,num)
		else 
			crear(A^.HD,num)   
End;

Procedure enOrden ( a : arbol );
begin
	if ( a<> nil ) then begin
		enOrden (a^.HI);
		write (a^.dato);
		enOrden (a^.HD);
	end;
end;

Procedure preOrden ( a : arbol );
begin
	if ( a<> nil ) then begin
		write (a^.dato);   
		preOrden (a^.HI);
		preOrden (a^.HD);
	end;
end;

Procedure posOrden ( a : arbol );
begin
	if ( a<> nil ) then begin
		posOrden (a^.HI);
		posOrden (a^.HD);
		write (a^.dato);
	end;
end;

Function Buscar (a:arbol; x:elemento): arbol; 
 begin
	if (a=nil) then 
		Buscar:=nil
	else if (x = a^.dato) then
			Buscar:=a
		else if (x < a^.dato) then 
          Buscar:= Buscar(a^.hi ,x)
        else  
          Buscar:=Buscar(a^.hd ,x)
end;


var 

BEGIN
	
	
END.

