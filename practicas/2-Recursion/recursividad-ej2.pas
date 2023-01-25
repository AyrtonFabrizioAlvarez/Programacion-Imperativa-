

program untitled;



procedure imprimirNumerosRecursiva(num: integer);
begin
	if (num <> 0) then begin
		imprimirNumerosRecursiva(num div 10);
		writeln(num mod 10);
	end;
end;




var
num: integer;

BEGIN
	num:= 1024;
	imprimirNumerosRecursiva(num)
	
END.

