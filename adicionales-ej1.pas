
program ej1;

const
	dimF = 300;

type
	oficina = record
		cod: integer;
		dni: integer;
		valor: integer;
	end;

	arrOficinas = array [1..dimF] of oficina;
	
procedure generarVector(var arr: arrOficinas ; var dimL: integer);

	procedure leerOficina (var O: oficina);
	begin
		writeln('Ingrese el codigo de oficina');
		readln(O.cod);
		if (O.cod <> -1) then
		begin
			writeln('Ingrese el DNI del propietario');
			readln(O.dni);
			writeln('Ingrese el valor de las expensas');
			readln(O.valor);
		end;
	end;

var
	O: oficina;
begin
	dimL:= 0;
	leerOficina(O);
	while (dimL < dimF) and (O.cod <> -1) do
	begin
		dimL:= dimL + 1;
		arr[dimL]:= O;
		leerOficina(O);
	end;
end;


procedure ordenSeleccion (var arr: arrOficinas ; dimL: integer);
var
	i, j, pos: integer;
	item: oficina;
begin
	for i:= 1 to (dimL - 1) do
	begin
		pos:= i;
		for j:= (i + 1) to dimL do
		begin
			if (arr[j].cod < arr[pos].cod) then
				pos:= j;
		end;
		item:= arr[pos];
		arr[pos]:= arr[i];
		arr[i]:= item;
	end;
end;

procedure busquedaDicotomica (arr: arrOficinas ; dimL: integer);

	procedure busqueda (arr: arrOficinas ;  primero: integer ; ultimo: integer ;  buscado: integer ; var pos: integer);
	var
		medio: integer;
	begin
		if (primero > ultimo) then
			pos:= -1
		else
			medio:= (primero + ultimo) div 2;
			if (buscado = arr[medio].cod) then
				pos:=medio
			else
				if (buscado < arr[medio].cod) then
					busqueda(arr, primero, medio - 1, buscado, pos)
				else
					busqueda(arr, medio + 1, ultimo, buscado, pos)
	end;
var
	numBuscado: integer;
	pos: integer;
begin
	writeln('Ingrese el numero de oficina que desea buscar');
	readln(numBuscado);
	busqueda(arr, 1, dimL, numBuscado, pos);
	if (pos <> -1) then
		writeln('El codigo de oficina ingresado se encuentra en el array, su dni es: ', pos)
	else
		writeln('El codigo de oficina ingresado no se encuentra en el array');
end;


procedure mostrarVectorRecursivo (arr: arrOficinas ; dimL: integer ; var expensas: integer);
begin
	if (dimL >= 1) then
	begin
		mostrarVectorRecursivo(arr, dimL - 1, expensas);
		expensas:= expensas + arr[dimL].valor; 
	end;
end;
	
var
	arr: arrOficinas;
	dimL: integer;
	expensas: integer;
BEGIN
	expensas:= 0;
	generarVector(arr, dimL);
	ordenSeleccion(arr, dimL);
	busquedaDicotomica(arr, dimL);
	mostrarVectorRecursivo(arr, dimL, expensas);
	
END.




