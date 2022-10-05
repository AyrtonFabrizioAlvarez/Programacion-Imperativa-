{4.- Escribir un programa que:
a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}

program ej4;
const
	dimF = 20;
type
	arrNum = array [1..dimF] of integer;

procedure cargarVectorRecursivo (var arr: arrNum ; var  pos: integer);
begin	
	if (pos <= dimF) then begin
		writeln('ingrese un num');
		readln(arr[pos]);  {arr[pos]:= random(10);}
		if (arr[pos] <> 0) then begin			{si es 0 hace loop para obtener otro numero sin sumar 0 al array}
			pos:= pos + 1;
			cargarVectorRecursivo(arr, pos);
		end
		else
			cargarVectorRecursivo(arr, pos);

	end;
end;

procedure maximo (arr: arrNum ; var max: integer ; var pos: integer);
begin
	if (pos < dimF) then begin
		pos:= pos + 1;
		if (arr[pos] > max) then
			max:= arr[pos];
			
		maximo(arr, max, pos);
	end;
end;

procedure sumaTotalArr(arr: arrNum ; var pos: integer ; var total: integer);
begin
	if (pos < dimF) then begin
		pos:= pos + 1;
		total:= total + arr[pos];
		writeln(total);
		sumaTotalArr(arr, pos, total)
	end;	
end;


var
	arr: arrNum;
	pos, max, total: integer;
BEGIN
	pos:= 1;
	cargarVectorRecursivo(arr, pos);
	
	max:= -1;
	pos:= 0;
	maximo(arr, max, pos);
	writeln('El maximo en el array es: ', max);
	
	
	total:= 0;
	pos:=0;
	sumaTotalArr(arr, pos, total);
	writeln('El total de la suma de elementos del vector es: ', total);

END.

