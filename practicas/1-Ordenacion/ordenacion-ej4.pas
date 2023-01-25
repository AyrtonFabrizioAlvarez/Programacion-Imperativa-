{4.- Una librería requiere el procesamiento de la información de sus productos.
* *De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
}

program Ej4;
const
	dimF = 8;
type
	producto = record
		codProd: integer;
		codRubro: integer;
		precio: integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato: producto;
		sig: lista;
	end;
	
	arrLista = array [1..dimF] of lista;
	
	arrRubro3 = array [1..30] of producto;
	
{a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, 
 en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se lee el precio 0.}

procedure leerProducto (var P:producto);
begin
	writeln('Ingrese el PRECIO del producto');
	readln(P.precio);
	if (P.precio <> 0) then
	begin
		writeln('Ingrese el CODIGO del producto');
		readln(P.codProd);
		writeln('Ingrese el CODIGO del RUBRO');
		readln(P.codRubro);
	end;
end;

procedure iniciarArrayLista (var arr: arrLista);
var
	i: integer;
begin
	for i:=1 to dimF do
		arr[i]:= nil;
end;

procedure insertarOrdenado (var L:lista ; P:producto);
var
	nuevo, actual, anterior: lista;
begin
	new(nuevo);
	nuevo^.dato:= P;
	actual:= L;
	anterior:= L;
	while (actual <> nil) and (P.codProd < actual^.dato.codProd) do begin
		anterior:= actual;
		actual:= actual^.sig;
	end;
	if (anterior = actual) then
		L:= nuevo
	else
		anterior^.sig:= nuevo;
	nuevo^.sig:= actual;
end;

procedure cargarArray (var arr: arrLista);
var
	P: producto;
begin
	iniciarArrayLista(arr);
	leerProducto(P);
	while (P.precio <> 0) do begin
		insertarOrdenado(arr[P.codRubro], P);
		leerProducto(P);
	end;
end;


{b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.}

procedure verCodigoPorRubro (arr: arrLista);
var
	i: integer;
begin
	for i:= 1 to dimF do begin
		writeln('RUBRO ', i);
		while (arr[i] <> nil) do begin
			writeln('codigo ', arr[i]^.dato.codProd);
			arr[i]:= arr[i]^.sig;
		end;
	end;
end;


{c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3.
  Considerar que puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 30,
  almacenar los primeros 30 que están en la lista e ignore el resto.}
  
procedure cargarArrayRubro3(arr: arrLista ; var arrR3: arrRubro3 ; var dimL:integer);
begin
	dimL:= 0;
	while (arr[3] <> nil) and (dimL < 30) do begin
		arrR3[dimL]:= arr[3]^.dato;
		dimL:= dimL + 1;
		arr[3]:= arr[3]^.sig;
	end;
end;


{d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la teoría.} 

Procedure ordenInsercion ( var arr: arrRubro3);
var
	i, j: integer; 
	actual: producto;		
begin
	for i:=2 to dimF do begin 
		 actual:= arr[i];
		 j:= i-1; 
		 while (j > 0) and (arr[j].codProd > actual.codProd) do      // si '<' ordena de mayor a menor, sino, '>' menor a mayor.
		   begin
			 arr[j+1]:= arr[j];
			 j:= j - 1;                  
		   end;  
		 arr[j+1]:= actual; 
	end;
end;

{e. Muestre los precios del vector ordenado.}

procedure verPreciosArrR3(arr: arrRubro3 ; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do begin
		writeln(i, '- El precio es de ', arr[i].precio);
	end;
end;


var 
	arr: arrLista;
	arr2: arrRubro3;
	dimL: integer;
BEGIN
	cargarArray(arr);
	verCodigoPorRubro(arr);
	cargarArrayRubro3(arr, arr2, dimL);
	verPreciosArrR3(arr2, dimL)
	
END.

