program Ej1;

Const
	dimF=20;
	
type
	rango = 0..15;
	nVentas = 1..99;
	venta = record
		codigo:rango;
		cantVendida: nVentas;
	end;
	
arrVentas = array [1..dimF] of venta;

lista = ^nodo;
nodo = record
	dato:venta;
	sig:lista;
end;



procedure leerVenta (var V:venta);
begin
	Randomize; {esto se realiza para que no se repitan los digitos random }
	V.codigo:=random(16); {hace random un cod de 0 a 15}
	if (V.codigo <> 0) then
	begin
		writeln('Ingrese la cantidad vendida bajo el codigo ', V.codigo);
		writeln('');
		writeln('');
		read(V.cantVendida);
	end;
end;


procedure cargarVector (var arr:arrVentas ; var dimL:integer);
var
	V:venta;
begin
	dimL:=0;
	leerVenta(V);
	while (V.codigo <> 0) and (dimL<dimF) do
	begin
		dimL:= dimL + 1;
		arr[dimL]:= V;
		leerVenta(V);
	end; 
end;

procedure ordenarVector (var arr:arrVentas ; dimL:integer);
var
	i, j, pos:integer;
	item : venta;
begin
	for i:=1 to dimL-1 do begin {busca el mínimo y guarda en p la posición}
		pos := i;
		for j := i+1 to dimL do
			if (arr[j].codigo < arr[pos].codigo) then
				pos:=j;

			 {intercambia v[i] y v[p]}
		item := arr[pos];   
		arr[pos]:= arr[i];   
		arr[i]:= item;
      end;
end;

procedure eliminar (var arr:arrVentas ; var dimL:integer; num1, num2:integer);


	function buscarPosInf (arr:arrVentas; dimL, buscado:integer):integer;
	var
		pos:integer;
	begin
		pos:=1;
		while (pos <= dimL) and (buscado > arr[pos].codigo) do {Busco el codigo para guardarme su posicion en posInf}
			pos:= pos + 1;
		
		if (pos > dimL) then {Si la posicion esta fuera de la dimL asignamos 0 para no buscar la posSup, caso contrario nos guardamos la posicion}
			buscarPosInf:= 0
		else
			buscarPosInf:= pos;
	end;
	
	function buscarPosSup (arr:arrVentas; dimL, buscado, pos:integer):integer;
	begin
		while (pos <= dimL) and (buscado >= arr[pos].codigo) do {Busco el codigo para guardarme su posicion en posSup}
			pos:= pos + 1;
	
		if (pos > dimL) then	{Si la posicion esta fuera de la dimL asignamos dimL para correr el resto del array, caso contrario restamos 1 a pos para qeudar en la posicion correcta}
			buscarPosSup:= dimL
		else
			buscarPosSup:= pos - 1;
		
	end;
	
var
	i, posInf,posSup, salto, aux:integer;
begin
	posInf:= buscarPosInf(arr, dimL, num1);
	if (posInf <> 0) then
	begin
		posSup:=buscarPosSup(arr, dimL, num2, posInf);
	
		salto:= posSup - posInf + 1;
		
		aux:=posInf;
		
		writeln(posInf);
		writeln(posSup);
	
		for i:= (posSup + 1) to dimL do
			arr[aux]:= arr[i];
		dimL:= dimL - salto;
		end
	else
		writeln('La posicion esta fuera del rango del Vector')
end;

procedure agregarAtras (var L, ultimo:lista; valor:venta);
var
	nuevo:lista;
begin
	new(nuevo);
	nuevo^.dato:=valor;
	nuevo^.sig:=nil;
	if (L = nil) then
		L:=nuevo
	else
		ultimo^.sig:=nuevo;
	ultimo:=nuevo;
end;

procedure cargarLista (var L:lista ; arr:arrVentas ; dimL:integer);
var
	i:integer; ultimo:lista;
begin 
	ultimo:=nil;
	for i:=1 to dimL do
	begin
		if (arr[i].codigo mod 2 = 0) then
			agregarAtras(L, ultimo, arr[i])
	end;
end;

procedure mostrarVector(v:arrVentas; dimL:integer);
var
i: integer;
begin
	for i :=1 to dimL do
	writeln (i,')- Codigo producto es: ',v[i].codigo, '. Cantidad vendida: ', v[i].cantVendida);
end;

procedure mostrarLista(L:lista);
var
indiceLista:integer;
begin
indiceLista:=1;
while (L <> nil) do begin
	write(indiceLista,'-Codigo del producto es: ', L^.dato.codigo);
	writeln('. Cantidad de ventas del producto es: ', L^.dato.cantVendida);
	indiceLista:=indiceLista + 1;
	
	L:=L^.sig;
end;
end;

		
		{PROGRAMA PRINCIPAL}
		
var
arr:arrVentas;
dimL:integer;
num1, num2:integer;
L:lista;


BEGIN
cargarVector(arr, dimL);
mostrarVector (arr,dimL);

writeln('');
writeln('');

ordenarVector(arr, dimL);
mostrarVector (arr,dimL);

writeln('');
writeln('');

num1:=7;
num2:=12;
eliminar(arr, dimL, num1, num2);
mostrarVector (arr,dimL);

writeln('');
writeln('');

L:=nil;
cargarLista(L, arr, dimL);
mostrarLista(L);

END.

