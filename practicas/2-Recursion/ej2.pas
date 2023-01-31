program ej2;


procedure imprimirNumero(x:integer);
begin
	if (x <> 0) then
	begin
		imprimirNumero(x div 10);
		writeln(x mod 10);
	end;
end;


var
	x:integer;
BEGIN
	x:= 1024;
	imprimirNumero(x)
END.

