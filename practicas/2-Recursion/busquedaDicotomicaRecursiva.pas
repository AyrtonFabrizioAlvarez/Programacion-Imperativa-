

program busquedaDicotomicaRecursiva;


procedure busquedaDicotomicaRecursiva (arr: array ; primero: integer ; ultimo: integer ; dato: integer ; var pos: integer);
var
	medio: integer;
begin
	if (primero > ultimo) then
		pos:= -1
	else
	begin
		medio:= (primero + ultimo) div 2;
		if (dato = arr[medio]) then
			pos:= medio;
		else
			if (dato < arr[medio]) then
				busquedaDicotomicaRecursiva(arr, primero, (medio - 1), dato, pos)
			else
				busquedaDicotomicaRecursiva(arr, (medio + 1), ultimo, dato, pos)
	end;
end;



var
	arr: vector;
	dimL: integer;
	dato: integer;
	pos: integer;
BEGIN
	pos:= 0;
	busquedaDicotomicaRecursiva(arr, 1, dimL, dato, pos);
	
END.

