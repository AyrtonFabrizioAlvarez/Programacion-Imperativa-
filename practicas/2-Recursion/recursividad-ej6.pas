{
 6.- Realizar un programa que lea números y que utilice un procedimiento recursivo que escriba 
 * el equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa el número 0 (cero). 
}


program ej6;

procedure decimaBinario (num: integer);
begin
	if (num <> 0) then begin

		decimaBinario(num div 2);
		write(num mod 2);
	end;
end;


var
	num: integer;
BEGIN	
	writeln('Ingrese el numero que desea transcribir a su equivalente binario');
	readln(num);
	decimaBinario(num);
END.

